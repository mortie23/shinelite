library(shiny)
library(bslib)

light <- bs_theme()
dark <- bs_theme(bg = "black", fg = "white", primary = "purple")

ui <- page_sidebar(
  title = "Shine Lite",
  sidebar = "Sidebar",
  theme = light,
  checkboxInput("dark_mode", "Dark mode"),
  "Main content area"
)

server <- function(input, output, session) {
  observe(session$setCurrentTheme(
    if (isTRUE(input$dark_mode)) dark else light
  ))
}

shinyApp(ui, server)
