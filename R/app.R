
#' Get SQLite database connection
#'
#' @return connection
#' @export
#'
#' @examples get_db_connection()
get_db_connection <- function() {
  config <- set_environment()
  db_path <- config$db_path
  conn <- dbConnect(SQLite(), dbname = db_path)
  return(conn)
}


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
    })

    # When add todo button is clicked, insert todo into database
    observeEvent(input$add_todo, {
      todo_text <- isolate(input$todo_input)
      if (nchar(todo_text) > 0) {
        db <- conn()
        dbExecute(db, "INSERT INTO todos (todo) VALUES (?)", todo_text)
        # Update the list of todos after adding a new one
        todos <- dbGetQuery(db, "SELECT id, todo FROM todos")
        output$todos_table <- renderDataTable({
          datatable(todos, options = list(dom = 't'))
        })
      }
    })

    # Update checkbox input with todos from database
    observe({
      db <- conn()
      todos <- dbGetQuery(db, "SELECT id, todo FROM todos")
      output$todos_table <- renderDataTable({
        datatable(todos, options = list(dom = 't'))
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
