# This is the parent script which runs the web app.

# Running the app as an interactive app.
if (interactive()) {
  # Sourcing the ui and server scripts.
  source("ui.R")
  source("server.R")
  
  # Run the application.
  shinyApp(ui = ui, server = server)
}