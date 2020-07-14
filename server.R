#'////////////////////////////////////////////////////////////////////////////
#' FILE: server.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-09-09
#' MODIFIED: 2020-07-14
#' PURPOSE: Shiny server
#' STATUS: in.progress
#' PACKAGES: see global
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////
server <- function(input, output, session) {

    # init session analytics
    session_db <- analytics$new(log = FALSE)

    # set app reactiveVals
    logged <- reactiveVal(TRUE)
    navigation <- reactiveVal(1)

    # page navigation
    mod_nav_server("instructions-a", navigation, session_db)
    mod_nav_server("instructions-b", navigation, session_db)
    mod_nav_server("instructions-c", navigation, session_db)
    mod_nav_server("instructions-d", navigation, session_db)
    mod_nav_server("sideEffects", navigation, session_db)
    mod_nav_server("results", navigation, session_db)
    mod_nav_server("quit", navigation, session_db)

    # side effect cards pass reset state and reactive object
    mod_se_server("akathisia", session_db)
    mod_se_server("anticholinergic", session_db)
    mod_se_server("antiparkinson", session_db)
    mod_se_server("prolactin", session_db)
    mod_se_server("qtc", session_db)
    mod_se_server("sedation", session_db)
    mod_se_server("weight_gain", session_db)

    # call sign in form module
    mod_login_server("signin-form", accounts, logged, session_db)

    # output pages
    observe({

        # when logged
        if (logged()) {

            # update progress bar
            utils$updateProgressBar(now = navigation(), max = length(pages))

            # show menu buttons
            browsertools::remove_css("#item-restart-app", "item-hidden")
            browsertools::remove_css("#item-signout-app", "item-hidden")

            # update document title
            browsertools::set_document_title(
                title = paste0(
                    attributes(pages)$title, " | ",
                    attributes(pages[[navigation()]])$title
                )
            )

            # render page
            browsertools::scroll_to()
            output$current_page <- renderUI({
                pages[[navigation()]]
            })
        }

        # if unlogged, render signin page (on app load)
        if (!logged()) {

            # reset progress bar
            utils$updateProgressBar(now = 0, max = length(pages))

            # hide menu buttons
            browsertools::add_css("#item-restart-app", "item-hidden")
            browsertools::add_css("#item-signout-app", "item-hidden")

            # reset scroll
            browsertools::scroll_to()

            # render signin page
            output$current_page <- renderUI({
                tags$article(
                    id = "signin",
                    mod_login_ui("signin-form", "form-ui")
                )
            })
        }
    })

    #'//////////////////////////////////////

    # onSubmit: find recommendations
    observeEvent(input$`sideEffects-submit`, {

        # hide mssage
        utils$side_effects$hide_error_message()

        # validate input
        choice <- data.frame(
            akathisia = ifelse(input$`akathisia-checked`, 1, 0),
            anticholinergic = ifelse(input$`anticholinergic-checked`, 1, 0),
            antiparkinson = ifelse(input$`antiparkinson-checked`, 1, 0),
            prolactin = ifelse(input$`prolactin-checked`, 1, 0),
            qtc = ifelse(input$`qtc-checked`, 1, 0),
            sedation = ifelse(input$`sedation-checked`, 1, 0),
            weight_gain = ifelse(input$`weight_gain-checked`, 1, 0)
        )

        # if sum of selections is zero
        if (sum(choice[1, ]) == 0) {

            # show error (no need to reset inputs since nothing was selected)
            browsertools::scroll_to()
            browsertools::console_error("No selections were detected.")
            utils$side_effects$show_error_message(
                "No selections were made. You must select one side effect"
            )

        } else  if (sum(choice[1, ]) > 1) {

            # throw error when more than 1 selection was made
            # reset side effects + show error
            browsertools::scroll_to()
            browsertools::console_error(
                "User selected more than 1 option. Only 1 is allowed"
            )
            utils$side_effects$reset_side_effects()
            utils$side_effects$show_error_message(
                "Too many selections were made. You may select one side effect."
            )

        } else {

            # log message to browser that selections are valid
            browsertools::console_log("Selections are valid")

            # exclude cases where selection has NA values
            #' selected_side_effect <- names(choice)[choice[1, ] == 1]
            #' filtered_df <- incontrolofeffects_rx[(
            #'         incontrolofeffects_rx$side_effect == selected_side_effect
            #'         & !is.na(incontrolofeffects_rx$value)
            #'     ), ]

            # generate new scores for each medication based on the user's
            # preferences for side effects. Run against the reference dataset
            # `incontrolofeffects_rx`. Note for future: removing NA cases is
            # not required. Doing so has no effect on the returned score.
            # Use `filtered df` for limiting countries when the time comes.
            raw_results <- as.data.frame(
                user_preferences(
                    data = incontrolofeffects_rx,
                    weights = choice[1, ],
                    return_all = FALSE
                )
            )

            # reduce results to desired elements
            results <- data.frame(
                time = Sys.time(),
                rx_rec_a = raw_results[1, "name"],
                rx_rec_b = raw_results[2, "name"],
                rx_rec_c = raw_results[3, "name"],
                rx_avoid_a = raw_results[NROW(raw_results), "name"],
                rx_avoid_b = raw_results[NROW(raw_results) - 1, "name"],
                rx_avoid_c = raw_results[NROW(raw_results) - 2, "name"]
            )

            # reset side effects
            utils$side_effects$reset_side_effects()

            # onSuccess: increment page
            navigation(navigation() + 1)

            # write results with delay (time in milliseconds)
            utils$side_effects$write_side_effects(results, delay = 175)

            # log results to db
            session_db$capture_selections(choice)
            session_db$capture_results(results)

        }
    })

    #'//////////////////////////////////////

    # onClick: navigation bar restart
    observeEvent(input$appRestart, {

        # log action before updating attempts
        browsertools::console_log("Resetting application")
        session_db$capture_action(
            event = "session",
            id = "app_restart",
            desc = "user clicked restart menu button"
        )

        # update attempts and navigation
        session_db$update_attempts()
        navigation(1)
    })

    # onClick: navigation bar logout
    observeEvent(input$appSignout, {

        # reset navigation value
        browsertools::console_log("User signed out")
        navigation(1)

        # log user out and send to database
        session_db$capture_action(
            event = "session",
            id = "app_logout",
            desc = "user clicked the log out button"
        )

        # set logged to FALSE
        logged(FALSE)
    })

    # on sesssion end
    session$onSessionEnded(function() {

        # make sure session_db is disconnected if not already
        tryCatch({

            # log quit
            session_db$capture_action(
                event = "session",
                id = "app_quit",
                desc = "application closed"
            )

            # disconnect
            session_db$disconnect()

        }, error = function(e) {
            cat("User already disconnected\n")
        })
    })
}