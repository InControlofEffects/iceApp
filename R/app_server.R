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

    # call login module
    mod_login_server("signin-form", accounts, logged)

    # page navigation for each subpage navigation component
    mod_nav_server("instructions-a", navigation)
    mod_nav_server("instructions-b", navigation)
    mod_nav_server("instructions-c", navigation)
    mod_nav_server("instructions-d", navigation)
    mod_nav_server("sideEffects", navigation)
    mod_nav_server("results", navigation)
    mod_nav_server("quit", navigation)

    # output pages
    observe({

        # when logged
        if (logged()) {

            # update progress bar
            update_progress_bar(now = navigation(), max = length(pages))

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

        # process response
        if (response$ok) {

            # advance to  results page
            navigation(navigation() + 1)

            # write results with delay (time in milliseconds)
            write_se_results(response$data$recs, delay = 250)
        }

        # process failed response
        if (!response$ok) {
            browsertools::console_error(response$error$log)
            update_error_box(
                id = "side-effects-error",
                error = response$error$msg
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
    })

    # onClick: navigation bar logout
    observeEvent(input$appSignout, {
        navigation(1)
        logged(FALSE)
    })
}