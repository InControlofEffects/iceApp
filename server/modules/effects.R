#'//////////////////////////////////////////////////////////////////////////////
#' FILE: submit_effects.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-08-30
#' MODIFIED: 2020-06-04
#' PURPOSE: primary server code for handling side effect selection and results
#' PACKAGES: shiny
#' COMMENTS: uses server/utils/patientPrefs.R
#'//////////////////////////////////////////////////////////////////////////////
# ON SUBMIT RESULTS
observeEvent(input$submitEffects, {

    #' gather selections and order in alphabetical order by id
    selection <- data.frame(
        akathisia = ifelse(input$akathisia, 1, 0),
        anticholinergic = ifelse(input$anticholinergic, 1, 0),
        antiparkison = ifelse(input$antiparkison, 1, 0),
        prolactin = ifelse(input$prolactin, 1, 0),
        qtc = ifelse(input$qtc, 1, 0),
        sedation = ifelse(input$sedation, 1, 0),
        weight_gain = ifelse(input$weight_gain, 1, 0),
        stringsAsFactors = FALSE
    )

    # check the number of inputs and throw error message
    # if number of items greater than 1, otherwise, process
    # inputs and return results
    if (sum(selection[1, ]) == 0) {

        # throw error
        browsertools::scroll_to()
        browsertools::console_error(
            message = "Selection Error: no selections were detected."
        )
        browsertools::inner_text(
            elem = "#form-error",
            string = paste0(
                "No side effects were selected.",
                "You must select one side effect."
            )
        )

        # reset all input values to 0 & remove all css classes
        shiny::updateCheckboxInput(session, "weight", value = 0)
        shiny::updateCheckboxInput(session, "qtc", value = 0)
        shiny::updateCheckboxInput(session, "prolactin", value = 0)
        shiny::updateCheckboxInput(session, "extrapyram", value = 0)
        session$sendCustomMessage(type = "resetSideEffects", "event")

    } else if (sum(selection[1, ]) >= 2) {

        # throw error
        browsertools::scroll_to()
        browsertools::console_error(
            message = paste0(
                "Selection Error: too many side effects were selected.",
                "User is allowed one selection."
            )
        )
        browsertools::inner_text(
            elem = "#form-error",
            string = paste0(
                "Too many side effects were selected. ",
                "You can only select one side effect"
            )
        )

        # reset all input values to 0 and remove all css classes
        shiny::updateCheckboxInput(session, "weight", value = 0)
        shiny::updateCheckboxInput(session, "qtc", value = 0)
        shiny::updateCheckboxInput(session, "prolactin", value = 0)
        shiny::updateCheckboxInput(session, "extrapyram", value = 0)
        session$sendCustomMessage(type = "resetSideEffects", "event")


    } else {

        #'////////////////////////////////////////
        # process page navigation from side effects to results page

        # increment page number
        new_page_num <- page_num() + 1
        page_num(new_page_num)

        # load next page
        source(file = file_paths[page_num()], local = TRUE)
        output$current_page <- page

        # run function to update progress bar
        session$sendCustomMessage(
            type = "updateProgressBar",
            c(1, file_length, page_num())
        )

        #'////////////////////////////////////////

        # run user inputs through function
        results <- as.data.frame(
            user_preferences(
                data = antiPsychDF,
                weights = selection[1, ],
                return_all = FALSE
            )
        )

        #'////////////////////////////////////////
        # send via innerHTML(id) - top 3
        browsertools::inner_text(
            elem = "#results-label-rec-1",
            string = results[1, "name"],
            delay = 250
        )
        browsertools::inner_html(
            elem = "#results-label-rec-2",
            string = results[2, "name"],
            delay = 250
        )
        browsertools::inner_html(
            elem = "#results-label-rec-3",
            string = results[3, "name"],
            delay = 250
        )

        #'////////////////////////////////////////
        # send via innerHTML(id) - top 3 - rev order in worst score
        # (e.g., worst = highest num)
        browsertools::inner_html(
            elem = "#results-label-avoid-1",
            string = results[NROW(results), "name"],
            delay = 250
        )
        browsertools::inner_html(
            elem = "#results-label-avoid-2",
            string = results[NROW(results) - 1, "name"],
            delay = 250
        )
        browsertools::inner_html(
            elem = "#results-label-avoid-3",
            string = results[NROW(results) - 2, "name"],
            delay = 250
        )

        # reset view to top
        browsertools::scroll_to()
    }
}, ignoreInit = TRUE)
