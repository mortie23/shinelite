#' Run the Shiny application
#'
#' @export
#'
runShineLite <- function() {

  # Theme manager
  light <- bs_theme()
  dark <- bs_theme(bg = "black", fg = "white", primary = "purple")

  ui <- page_sidebar(
    title = "Shine Lite - Todo App",
    sidebar = "Sidebar",
    theme = light,
    checkboxInput("dark_mode", "Dark mode"),
    textInput("todo_input", "Enter todo"),
    actionButton("add_todo", "Add Todo"),
    hr(),
    DTOutput("todos_table"), # Output for DataTable
    hr(),
    "Main content area",
    # Include JavaScript code to bind "enter" key to button click
    tags$script('
      $(document).on("keypress", function(e) {
        if (e.which == 13) {
          $("#add_todo").click();
        }
      });
    ')
  )

  # Define server logic
  server <- function(input, output, session) {

    # Set theme based on checkbox input
    observe({
      session$setCurrentTheme(
        if (isTRUE(input$dark_mode)) dark else light
      )
    })

    # Connect to database
    conn <- reactiveVal(NULL)

    observe({
      conn(get_db_connection())
      # Call refreshTable function to render the table on initial load
      refreshTable()
    })

    # Function to refresh the DataTable
    refreshTable <- function() {
      db <- conn()
      todos <- dbGetQuery(db, "SELECT id, todo FROM todos order by id desc")
      todos$delete <- sprintf('<input type="button" id="delete_%s" value="Done">', todos$id)
      output$todos_table <- renderDT({
        datatable(
          todos,
          options = list(dom = 't', columnDefs = list(list(targets = "_all"))),
          escape = FALSE,
          callback = JS('table.on("click.dt", "input", function() {
            var id = $(this).attr("id");
            Shiny.setInputValue(id, 1, {priority: "event"});
          });')
        )
      })
    }

    # When add todo button is clicked, insert todo into database
    observeEvent(input$add_todo, {
      todo_text <- isolate(input$todo_input)
      if (nchar(todo_text) > 0) {
        db <- conn()
        dbExecute(db, "INSERT INTO todos (todo) VALUES (?)", todo_text)
        # Refresh the DataTable
        refreshTable()
      }
    })

    # Delete todo when Done button is clicked
    observe({
      lapply(grep("^delete_", names(input), value = TRUE), function(delete_id) {
        observeEvent(input[[delete_id]], {
          todo_id <- as.numeric(strsplit(delete_id, "_")[[1]][2])
          db <- conn()
          dbExecute(db, paste0("DELETE FROM todos WHERE id = ", todo_id))
          # Refresh the DataTable
          refreshTable()
        })
      })
    })

    # Cleanup database connection when session ends
    session$onSessionEnded(function() {
      db <- conn()
      dbDisconnect(db)
    })
  }

  # Run the application
  shinyApp(ui, server)
}
