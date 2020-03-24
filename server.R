#'//////////////////////////////////////////////////////////////////////////////
#' FILE: server.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-09-09
#' MODIFIED: 2020-03-24
#' PURPOSE: server for in control of effects application
#' STATUS: in.progress
#' PACKAGES: see global
#' COMMENTS:
#'      The server.R for the ICE application handles the loading of server and
#'      ui components, as well as the loading/rendering of application pages.
#'      The primary function of the server.R file is to handle the login status
#'      of the application. The further processing of client interactivity is
#'      handled in the server/index.R file and other files in the server.
#'      Please refer to those files for more information.
#'//////////////////////////////////////////////////////////////////////////////
#' SERVER
server <- function(input, output, session) {

    # load server components
    source("server/utils/patient_prefs.R", local = TRUE)
    source("server/modules/login.R", local = TRUE)
    source("server/modules/effects.R", local = TRUE)
    source("server/modules/navigation.R", local = TRUE)

    # load ui components
    source("src/components/primary/app.R", local = TRUE)
    users <- readRDS("server/database/users.RDS")

    # define pages and starting point
    page_num <- reactiveVal()
    page_num(1)
    file_order <- c(
        "instructions_1.R",
        "instructions_2.R",
        "instructions_3.R",
        "side_effects.R",
        "results.R",
        "quit.R"
    )

    # BUILD FILE PATHS + GET LENGTH
    file_paths <- as.character(
        sapply(file_order, function(x) {
            paste0("src/pages/", x)
        })
    )
    file_length <- length(file_paths)

    # init logged value
    logged <- reactiveVal()
    logged(TRUE)  # default use TRUE for dev

    # run app when logged == TRUE
    observe({
        if (logged() == "TRUE") {
            browsertools::remove_css(elem = "#app", css = "app-fullscreen")

            # LOAD AND RENDER FIRST PAGE INTO APP TEMPLATE
            source(file = file_paths[1], local = TRUE)
            output$app <- shiny::renderUI(app())
            output$current_page <- page

            # INIT PROGRESS BAR
            session$sendCustomMessage(
                type = "updateProgressBar",
                c(0, file_length, 1)
            )

        } else {
            output$app <- shiny::renderUI(loginScreen())
            browsertools::add_css(elem = "#app", css = "app-fullscreen")
        }
    })
}
