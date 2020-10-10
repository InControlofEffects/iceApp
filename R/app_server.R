#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

    # set primary reactiveValues
    logged <- reactiveVal(TRUE)
    navigation <- reactiveVal(1)
    analytics <- analytics$new(version = "0.0.2", active = FALSE)

    # call login module
    response <- mod_login_server("signin-form", accounts, logged, analytics)

    # page navigation for each subpage navigation component
    mod_nav_server("instructions-a", navigation, analytics, ice_progressbar)
    mod_nav_server("instructions-b", navigation, analytics, ice_progressbar)
    mod_nav_server("instructions-c", navigation, analytics, ice_progressbar)
    mod_nav_server("instructions-d", navigation, analytics, ice_progressbar)
    mod_nav_server("sideEffects", navigation, analytics, ice_progressbar)
    mod_nav_server("results", navigation, analytics, ice_progressbar)
    mod_nav_server("quit", navigation, analytics, ice_progressbar)

    # output pages
    observe({

        # when logged
        if (logged()) {

            # show logout button regardless of usertype
            browsertools::remove_css("#item-signout-app", "item-hidden")

            # init page
            # ice_progressbar$increase()
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

        # if unlogged, render signin page (on app load)
        if (!logged()) {

            # reset progress bar
            ice_progressbar$reset()

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

        analytics$save_click(
            btn = "side_effects_submit",
            description = "side effect selections were submitted"
        )

        # hide existing error messages
        iceComponents::hide_error_box(inputId = "side-effects-error")

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
        analytics$save_selections(selections = selections)

        # process response
        if (response$ok) {

            # advance to  results page
            navigation(navigation() + 1)

            # write results with delay (time in milliseconds)
            write_se_results(response$data$recs)

            # save click
            analytics$save_click(
                btn = "next_page",
                description = paste0(
                    "navigated to 'results' ",
                    "(page ", navigation(), ")"
                )
            )

            # save results
            analytics$save_results(results = response$data$recs)

        }

        # process failed response
        if (!response$ok) {
            browsertools::console_error(response$error$log)
            iceComponents::show_error_box(
                inputId = "side-effects-error",
                error = response$error$msg
            )
            analytics$save_error(
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
        analytics$save_click(
            btn = "app_restart",
            description = paste0(
                "application restarted, resetting to first page ",
                "(page ", navigation(), ")"
            )
        )

        analytics$save_restart()
    })

    # onClick: navigation bar logout
    observeEvent(input$appSignout, {
        navigation(1)
        logged(FALSE)
        analytics$save_logout()
    })


    # on sesssion end
    session$onSessionEnded(function() {
        analytics$save_session_end()
    })
}
