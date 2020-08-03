#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

    # set primary reactiveValues
    logged <- reactiveVal(TRUE)
    navigation <- reactiveVal(5)

    # page navigation for each subpage navigation component
    mod_nav_server("instructions-a", navigation)
    mod_nav_server("instructions-b", navigation)
    mod_nav_server("instructions-c", navigation)
    mod_nav_server("instructions-d", navigation)
    mod_nav_server("sideEffects", navigation)
    mod_nav_server("results", navigation)
    mod_nav_server("quit", navigation)

    # call sign in form module
    mod_login_server("signin-form", accounts, logged)

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

    # onSubmit: find recommendations
    observeEvent(input$`sideEffects-submit`, {

        # hide mssage
        reset_error_box(id = "side-effects-error")

        # Gather Selections convert TRUE to 1
        choice <- data.frame(
            akathisia = as.numeric(input$akathisia),
            anticholinergic = as.numeric(input$anticholinergic),
            antiparkinson = as.numeric(input$antiparkinson),
            prolactin = as.numeric(input$prolactin),
            qtc = as.numeric(input$qtc),
            sedation = as.numeric(input$sedation),
            weight_gain = as.numeric(input$weight_gain)
        )

        # if sum of selections is zero
        if (sum(choice[1, ]) == 0) {

            # show error (no need to reset inputs since nothing was selected)
            browsertools::scroll_to()
            browsertools::console_error("Side Effects: No options selected")
            update_error_box(
                id = "side-effects-error",
                error = "No selections were made. Please select a side effect"
            )

        } else  if (sum(choice[1, ]) > 1) {

            # throw error when more than 1 selection was made
            browsertools::scroll_to()
            update_error_box(
                id = "side-effects-error",
                error = "Too many selections were made. Please select 1 option."
            )

            # reset inputs
            iceComponents::reset_accordion_input("akathisia")
            iceComponents::reset_accordion_input("anticholinergic")
            iceComponents::reset_accordion_input("antiparkinson")
            iceComponents::reset_accordion_input("prolactin")
            iceComponents::reset_accordion_input("qtc")
            iceComponents::reset_accordion_input("sedation")
            iceComponents::reset_accordion_input("weight_gain")

            # log issue to browser
            browsertools::console_error("Side Effects: Selections > 1")
        } else {

            # log message to browser that selections are valid
            browsertools::console_log("Selections are valid")

            # exclude cases where selection has NA values
            # selected_side_effect <- names(choice)[choice[1, ] == 1]
            # filtered_df <- incontrolofeffects_rx[(
            #         incontrolofeffects_rx$side_effect == selected_side_effect
            #         & !is.na(incontrolofeffects_rx$value)
            #     ), ]

            # generate new scores for each medication based on the user's
            # preferences for side effects. Run against the reference dataset
            # `incontrolofeffects_rx`. Note for future: removing NA cases is
            # not required. Doing so has no effect on the returned score.
            # Use `filtered df` for limiting countries when the time comes.
            raw_results <- as.data.frame(
                iceData::user_preferences(
                    data = iceData::meds,
                    weights = choice[1, ],
                    return_all = FALSE
                )
            )

            # reduce results to desired elements
            results <- data.frame(
                rx_rec_a = raw_results[1, "name"],
                rx_rec_b = raw_results[2, "name"],
                rx_rec_c = raw_results[3, "name"],
                rx_avoid_a = raw_results[NROW(raw_results), "name"],
                rx_avoid_b = raw_results[NROW(raw_results) - 1, "name"],
                rx_avoid_c = raw_results[NROW(raw_results) - 2, "name"]
            )

            # reset side effects
            # reset_accordion_input()

            # onSuccess: increment page
            navigation(navigation() + 1)

            # write results with delay (time in milliseconds)
            write_se_results(results, delay = 225)

        }
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