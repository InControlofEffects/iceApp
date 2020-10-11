#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

    # set primary reactiveValues
    logged <- reactiveVal(FALSE)
    initProg <- reactiveVal(TRUE)
    pageCounter <- reactiveVal(1)
    analytics <- analytics$new(version = "0.0.3", active = FALSE)
    response <- mod_login_server("signin-form", accounts, logged, analytics)
 
    # output pages
    observe({

        # when logged
        if (logged()) {

            if (initProg()) {
                appProgress$increase()
                initProg(FALSE)
            }
            browsertools::remove_css("#item-signout-app", "item-hidden")
            browsertools::remove_css("#item-restart-app", "item-hidden")
            browsertools::set_document_title(
                title = paste0(
                    attributes(pages)$title, " | ",
                    attributes(pages[[pageCounter()]])$title
                )
            )

            # render page based on pageCounter counter
            browsertools::scroll_to()
            output$current_page <- renderUI({
                pages[[pageCounter()]]
            })

            browsertools::console_log(
                list(
                    progressbar = appProgress$current,
                    pagecount = pageCounter()
                )
            )
        }

        # if unlogged, render signin page (on app load)
        if (!logged()) {

            # reset progress bar
            appProgress$reset()

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

    # functions for updating internal page counter
    prevPage <- function() {
        pageCounter(pageCounter() - 1)
        appProgress$decrease()
    }
    nextPage <- function() {
        pageCounter(pageCounter() + 1)
        appProgress$increase()
    }

    observeEvent(input$reselect, prevPage())
    observeEvent(input$prevPage, prevPage())
    observeEvent(input$nextPage, nextPage())
    observeEvent(input$done, nextPage())

    # onSubmit: generate recommendations
    observeEvent(input$submit, {

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
            nextPage()

            # write results with delay (time in milliseconds)
            write_se_results(response$data$recs)

            # save click
            analytics$save_click(
                btn = "next_page",
                description = paste0(
                    "navigated to 'results' ",
                    "(page ", pageCounter(), ")"
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
        pageCounter(1)
        appProgress$reset()
        analytics$save_click(
            btn = "app_restart",
            description = paste0(
                "application restarted, resetting to first page ",
                "(page ", pageCounter(), ")"
            )
        )
        analytics$save_restart()
        initProg(TRUE)
    })

    # onClick: pageCounter bar logout
    observeEvent(input$appSignout, {
        pageCounter(1)
        logged(FALSE)
        analytics$save_logout()
        appProgress$reset()
        initProg(TRUE)
    })


    # on sesssion end
    session$onSessionEnded(function() {
        analytics$save_session_end()
    })
}
