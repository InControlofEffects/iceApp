#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

    # set app reactiveVals
    logged <- reactiveVal(TRUE)
    navigation <- reactiveVal(4)

    # page navigation
    callModule(mod_nav_server, "instructions-a", navigation)
    callModule(mod_nav_server, "instructions-b", navigation)
    callModule(mod_nav_server, "instructions-c", navigation)
    callModule(mod_nav_server, "submitEffects", navigation)
    callModule(mod_nav_server, "results", navigation)
    callModule(mod_nav_server, "quit", navigation)

    # side effect cards pass reset state and reactive object
    callModule(mod_se_server, "akathisia")
    callModule(mod_se_server, "anticholinergic")
    callModule(mod_se_server, "antiparkinson")
    callModule(mod_se_server, "prolactin")
    callModule(mod_se_server, "qtc")
    callModule(mod_se_server, "sedation")
    callModule(mod_se_server, "weight_gain")

    # output pages
    observe({

        # when logged
        if (logged()) {

            # show buttons
            browsertools::show_elem(elem = "#restart")
            browsertools::show_elem(elem = "#logout")

            # render page
            output$current_page <- renderUI({
                browsertools::scroll_to()
                pages[[navigation()]]
            })
        } else {
            # output$current_page <- loading_screen
        }
    })

    # onClick: navigation bar restart
    observeEvent(input$restart, {
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
        hide_error_message()

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
        sum <- sum(choice[1, ])
        print(choice)

        # if sum of selections is zero
        if (sum == 0) {

            # throw error when nothing was selected
            browsertools::scroll_to()
            browsertools::console_error(
                message = "Selection Error: no selections were made"
            )

            # resetCheckboxes
            updateCheckboxInput(session, "akathisia-checked", value = 0)
            updateCheckboxInput(session, "anticholinergic-checked", value = 0)
            updateCheckboxInput(session, "antiparkinson-checked", value = 0)
            updateCheckboxInput(session, "prolactin-checked", value = 0)
            updateCheckboxInput(session, "qtc-checked", value = 0)
            updateCheckboxInput(session, "sedation-checked", value = 0)
            updateCheckboxInput(session, "weight_gain-checked", value = 0)
            session$sendCustomMessage("reset_side_effects", "")
            

            # print message
            show_error_message(
                "No selections were made. You must select one side effect"
            )

        } else  if (sum > 1) {

            # remove css
            updateCheckboxInput(session, "akathisia-checked", value = 0)
            updateCheckboxInput(session, "anticholinergic-checked", value = 0)
            updateCheckboxInput(session, "antiparkinson-checked", value = 0)
            updateCheckboxInput(session, "prolactin-checked", value = 0)
            updateCheckboxInput(session, "qtc-checked", value = 0)
            updateCheckboxInput(session, "sedation-checked", value = 0)
            updateCheckboxInput(session, "weight_gain-checked", value = 0)
            session$sendCustomMessage("reset_side_effects", "")

            # throw error when more than 1 selection was made
            browsertools::scroll_to()
            browsertools::console_error(
                message = "Selection Error: too many side effects were selected"
            )

            # print message
            show_error_message(
                "Too many selections were made. You may select one side effect."
            )
        } else {

            # exclude cases where selection has NA values
            selectedSideEffect <- names(choice)[choice[1, ] == 1]
            filteredDF <- incontrolofeffects_rx[(
                    data$side_effect == selectedSideEffect &
                    !is.na(data$value)
                ), ]

            # run user inputs
            results <- as.data.frame(
                user_preferences(
                    data = filteredDF,
                    weights = choice[1, ],
                    return_all = FALSE
                )
            )

            # onSuccess: increment page
            next_page <- counter() + 1
            counter(next_page)
        }

    })

}