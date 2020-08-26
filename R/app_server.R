#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

    # set primary reactiveValues
    logged <- reactiveVal(FALSE)
    navigation <- reactiveVal(1)
    session_data <- session_analytics$new(version = "0.0.11")

    # call login module
    response <- mod_login_server("signin-form", accounts, logged, session_data)

    # page navigation for each subpage navigation component
    mod_nav_server("instructions-a", navigation, session_data)
    mod_nav_server("instructions-b", navigation, session_data)
    mod_nav_server("instructions-c", navigation, session_data)
    mod_nav_server("instructions-d", navigation, session_data)
    mod_nav_server("sideEffects", navigation, session_data)
    mod_nav_server("results", navigation, session_data)
    mod_nav_server("quit", navigation, session_data)

    # output pages
    observe({

        # when logged
        if (logged()) {

            # show logout button regardless of usertype
            browsertools::remove_css("#item-signout-app", "item-hidden")


            # for default users
            if (response$usertype %in% c("standard", "demo")) {

                # init page
                update_progress_bar(now = navigation(), max = length(pages))
                browsertools::remove_css("#item-restart-app", "item-hidden")
                browsertools::set_document_title(
                    title = paste0(
                        attributes(pages)$title, " | ",
                        attributes(pages[[navigation()]])$title
                    )
                )

                # render page based on navigation counter
                browsertools::scroll_to()
                output$current_page <- renderUI({
                    pages[[navigation()]]
                })
            }

            # admin panel
            if (response$usertype == "admin") {
                output$current_page <- renderUI({
                    tagList(
                        tags$h2("Admin Panel"),
                        tags$p("This page is in development")
                    )
                })
            }
        }

        # if unlogged, render signin page (on app load)
        if (!logged()) {

            # reset progress bar
            update_progress_bar(now = 0, max = length(pages))

            # update document title
            browsertools::set_document_title(
                title = paste0(
                    attributes(pages)$title, " | ",
                    "Signin"
                )
            )

            # hide menu buttons
            browsertools::add_css("#item-restart-app", "item-hidden")
            browsertools::add_css("#item-signout-app", "item-hidden")

            # reset scroll
            browsertools::scroll_to()

            # render signin page
            output$current_page <- renderUI({
                tags$article(
                    id = "signin",
                    class = "signin_ui",
                    mod_login_ui("signin-form")
                )
            })
        }
    })

    # onSubmit: generate recommendations
    observeEvent(input$`sideEffects-submit`, {

        session_data$save_click(
            btn = "side_effects_submit",
            description = "side effect selections were submitted"
        )

        # hide existing error messages
        reset_error_box(id = "side-effects-error")

        # gather inputs
        selections <- data.frame(
            akathisia = as.numeric(input$akathisia),
            anticholinergic = as.numeric(input$anticholinergic),
            antiparkinson = as.numeric(input$antiparkinson),
            prolactin = as.numeric(input$prolactin),
            qtc = as.numeric(input$qtc),
            sedation = as.numeric(input$sedation),
            weight_gain = as.numeric(input$weight_gain)
        )

        # validate inputs
        response <- validate_side_effects(data = selections)

        # save selections
        session_data$save_selections(selections = selections)

        # process response
        if (response$ok) {

            # advance to  results page
            navigation(navigation() + 1)

            # write results with delay (time in milliseconds)
            write_se_results(response$data$recs, delay = 250)

            # save click
            session_data$save_click(
                btn = "next_page",
                description = paste0(
                    "navigated to 'results' ",
                    "(page ", navigation(), ")"
                )
            )

            # save results
            session_data$save_results(results = response$data$recs)

        }

        # process failed response
        if (!response$ok) {
            browsertools::console_error(response$error$log)
            update_error_box(
                id = "side-effects-error",
                error = response$error$msg
            )
            session_data$save_error(
                error = "sie_effects_error",
                message = response$error$msg
            )
        }

        # reset inputs as the last step
        iceComponents::reset_accordion_input("akathisia")
        iceComponents::reset_accordion_input("anticholinergic")
        iceComponents::reset_accordion_input("antiparkinson")
        iceComponents::reset_accordion_input("prolactin")
        iceComponents::reset_accordion_input("qtc")
        iceComponents::reset_accordion_input("sedation")
        iceComponents::reset_accordion_input("weight_gain")

        # scroll to top of page
        browsertools::scroll_to()
    })

    # onClick: application restart
    observeEvent(input$appRestart, {
        navigation(1)
        session_data$save_click(
            btn = "app_restart",
            description = paste0(
                "application restarted, resetting to first page ",
                "(page ", navigation(), ")"
            )
        )

        session_data$save_restart()
    })

    # onClick: navigation bar logout
    observeEvent(input$appSignout, {
        navigation(1)
        logged(FALSE)
        session_data$save_logout()
    })


    # on sesssion end
    session$onSessionEnded(function() {
        session_data$save_session_end()
    })
}
