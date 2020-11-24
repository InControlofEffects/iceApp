#'////////////////////////////////////////////////////////////////////////////
#' FILE: run_dev.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-08-12
#' MODIFIED: 2020-11-24
#' PURPOSE: run application in dev mode
#' STATUS: working
#' PACKAGES: golem; shiny; iceApp
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

# set opts
options(
    golem.app.prod = FALSE,
    shiny.port = 8000,
    shiny.launch.browser = FALSE
)

# Detach all loaded packages and clean your environment
golem::detach_all_attached()

# Document and reload your package
golem::document_and_reload()

# Run the application
run_app(
    use_analytics = FALSE,
    analytics_outdir = "logs/",
    users_db_path = "data-raw/demo_accounts.RDS"
)
