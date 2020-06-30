#'////////////////////////////////////////////////////////////////////////////
#' FILE: server.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-09-09
#' MODIFIED: 2020-06-27
#' PURPOSE: Shiny server
#' STATUS: in.progress
#' PACKAGES: see global
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////
server <- function(input, output, session) {

    # init session analytics
    session_db <- analytics$new()

    # set app reactiveVals
    logged <- reactiveVal(T)
    navigation <- reactiveVal(1)

    # page navigation
    callModule(mod_nav_server, "instructions-a", navigation, session_db)
    callModule(mod_nav_server, "instructions-b", navigation, session_db)
    callModule(mod_nav_server, "instructions-c", navigation, session_db)
    callModule(mod_nav_server, "sideEffects", navigation, session_db)
    callModule(mod_nav_server, "results", navigation, session_db)
    callModule(mod_nav_server, "quit", navigation, session_db)

    # side effect cards pass reset state and reactive object
    callModule(mod_se_server, "akathisia")
    callModule(mod_se_server, "anticholinergic")
    callModule(mod_se_server, "antiparkinson")
    callModule(mod_se_server, "prolactin")
    callModule(mod_se_server, "qtc")
    callModule(mod_se_server, "sedation")
    callModule(mod_se_server, "weight_gain")

    # call module
    callModule(mod_login_server, "signin-form", accounts, logged, session_db)

    # output pages
    observe({

        # when logged
        if (logged()) {

            # update progress bar
            utils$updateProgressBar(now = navigation(), max = length(pages))

            # show buttons
            browsertools::show_elem(elem = "#restart")
            browsertools::show_elem(elem = "#logout")

            # render page
            browsertools::scroll_to()
            output$current_page <- renderUI({
                pages[[navigation()]]
            })
        }

        # if unlogged, render signin page
        if (!logged()) {
            utils$updateProgressBar(now = 0, max = length(pages))
            browsertools::scroll_to()
            output$current_page <- renderUI({
                tags$article(
                    id = "signin",
                    mod_login_ui("signin-form", "form-ui")
                )
            })
        }
    })

    # onClick: navigation bar restart
    observeEvent(input$restart, {
        session_db$update_attempts()
        navigation(1)
    })

    # onClick: navigation bar logout
    observeEvent(input$logout, {
        navigation(1)
        logged(FALSE)
    })

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

            # resetCheckboxes + show error
            browsertools::scroll_to()
            utils$side_effects$reset_side_effects()
            utils$side_effects$show_error_message(
                "No selections were made. You must select one side effect"
            )

        } else  if (sum(choice[1, ]) > 1) {

            # throw error when more than 1 selection was made
            # reset side effects + show error
            browsertools::scroll_to()
            utils$side_effects$reset_side_effects()
            utils$side_effects$show_error_message(
                "Too many selections were made. You may select one side effect."
            )
        } else {

            # exclude cases where selection has NA values
            selected_side_effect <- names(choice)[choice[1, ] == 1]
            filtered_df <- incontrolofeffects_rx[(
                    incontrolofeffects_rx$side_effect == selected_side_effect &
                    !is.na(incontrolofeffects_rx$value)
                ), ]

            # run user inputs
            raw_results <- as.data.frame(
                user_preferences(
                    data = filtered_df,
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
                rx_avoid_a = raw_results[length(raw_results), "name"],
                rx_avoid_b = raw_results[length(raw_results) - 1, "name"],
                rx_avoid_c = raw_results[length(raw_results) - 2, "name"],
            )

            # reset side effects
            utils$side_effects$reset_side_effects()

            # onSuccess: increment page
            next_page <- navigation() + 1
            navigation(next_page)

            # set write delay
            delay <- 125

            #'//////////////////////////////////////
            # write recommended medication #1
            browsertools::inner_text(
                elem = "#rec-rx-a-result-title",
                string = results$rx_rec_a,
                delay = delay
            )

            # write recommended medication #2
            browsertools::inner_text(
                elem = "#rec-rx-b-result-title",
                string = results$rx_rec_b,
                delay = delay
            )

            # write recommended medication #3
            browsertools::inner_text(
                elem = "#rec-rx-c-result-title",
                string = results$rx_rec_c,
                delay = delay
            )

            #'//////////////////////////////////////
            # write avoid medication # 1
            browsertools::inner_text(
                elem = "#avoid-rx-a-result-title",
                string = results$rx_avoid_a,
                delay = delay
            )

            # write avoid medication # 2
            browsertools::inner_text(
                elem = "#avoid-rx-b-result-title",
                string = results$rx_avoid_b,
                delay = delay
            )

            # write avoid medication # 3
            browsertools::inner_text(
                elem = "#avoid-rx-c-result-title",
                string = results$rx_avoid_c,
                delay = delay
            )

            # log results to db
            session_db$capture_results(results)

        }

    })

}