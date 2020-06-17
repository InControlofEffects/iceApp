#'//////////////////////////////////////////////////////////////////////////////
#' FILE: server.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-09-09
#' MODIFIED: 2020-06-17
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

    # wrapper for progress bar updater
    updateProgressBar <- function(el = "bar", now, max = file_length) {
        session$sendCustomMessage(
            type = "updateProgressBar",
            list(el = el, now = now, max = max)
        )
    }

    # load server components
    source("server/assets/user_preferences.R", local = TRUE)
    source("server/modules/login.R", local = TRUE)
    source("server/modules/effects.R", local = TRUE)
    source("server/modules/navigation.R", local = TRUE)

    # load ui components
    source("client/login-screen.R", local = TRUE)
    users <- readRDS("server/database/users.RDS")

    # define pages and starting point
    page_num <- reactiveVal()
    page_num(4)

    # set order using full file paths
    file_paths <- c(
        "client/pages/instructions_1.R",
        "client/pages/instructions_2.R",
        "client/pages/instructions_3.R",
        "client/pages/side_effects.R",
        "client/pages/results.R",
        "client/pages/quit.R"
    )
    file_length <- length(file_paths)


    #'//////////////////////////////////////

    # main observe that renders app based on user logged status
    logged <- reactiveVal(TRUE)
    observe({

        # when logged
        if (logged()) {

            # LOAD AND RENDER FIRST PAGE INTO APP TEMPLATE
            source(file = file_paths[page_num()], local = TRUE)
            output$app <- shiny::renderUI(app())
            output$current_page <- page

            # INIT PROGRESS BAR
            updateProgressBar(now = page_num())
        }

        # when !logged
        if (!logged()) {
            output$current_page <- renderUI(loginScreen())
        }
    })
}
