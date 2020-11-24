#' Run the Shiny Application
#'
#' @param use_analytics if TRUE (default), app logging will run
#' @param analytics_outdir Path to write the logs into (default "logs/")
#' @param users_db_path path to user accounts RDS file
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(
    use_analytics = TRUE,
    analytics_outdir = "logs/",
    users_db_path = NULL
) {

    # disable analytics if path is not supplied
    if (is.null(users_db_path)) {
        use_analytics <- FALSE
    }

    with_golem_options(
        app = shinyApp(
            ui = app_ui,
            server = app_server
        ),
        golem_opts = list(
            use_analytics = use_analytics,
            analytics_outdir = analytics_outdir,
            users_db_path = users_db_path
        )
    )
}