# Set options here
system("clear")
options(golem.app.prod = FALSE, shiny.port = 8000, shiny.launch.browser = FALSE)

# Detach all loaded packages and clean your environment
golem::detach_all_attached()
# rm(list=ls(all.names = TRUE))

# Document and reload your package
golem::document_and_reload()

# Run the application
run_app()
