#'//////////////////////////////////////////////////////////////////////////////
#' FILE: submit_effects.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-08-30
#' MODIFIED: 2019-12-11
#' PURPOSE: primary server code for handling side effect selection and results
#' PACKAGES: shiny
#' COMMENTS: uses server/utils/patientPrefs.R
#'//////////////////////////////////////////////////////////////////////////////
# ON SUBMIT RESULTS
observeEvent(input$submitEffects, {

    # process input values for all side effect options; return as a wide data.frame
    selection <- data.frame(
        weight = ifelse(input$weight == "FALSE", 0, 1),
        qtc = ifelse(input$qtc == "FALSE", 0, 1),
        prolactin = ifelse(input$prolactin == "FALSE", 0, 1),
        extrapyram = ifelse(input$extrapyram == "FALSE", 0, 1),
        stringsAsFactors = FALSE
    )

    # check the number of inputs and throw error message if number of items greater than 1,
    # otherwise, process inputs and return results
    if (sum(selection[1, ]) == 0){

        # throw error
        js$innerHTML("#form-error", "No side effects were selected. You must select at least one side effect.")

        # reset all input values to 0 and remove all csis classes from input elements
        shiny::updateCheckboxInput(session, "weight", value = 0)
        shiny::updateCheckboxInput(session, "qtc", value = 0)
        shiny::updateCheckboxInput(session, "prolactin", value = 0)
        shiny::updateCheckboxInput(session, "extrapyram", value = 0)
        session$sendCustomMessage(type = "resetSideEffects", "event")

    } else if (sum(selection[1, ]) > 2) {

        # throw error
        js$innerHTML("#form-error", "Too many side effects were selected. You may select up to two side effects at a time.")

        # reset all input values to 0 and remove all css classes from input elements
        shiny::updateCheckboxInput(session, "weight", value = 0)
        shiny::updateCheckboxInput(session, "qtc", value = 0)
        shiny::updateCheckboxInput(session, "prolactin", value = 0)
        shiny::updateCheckboxInput(session, "extrapyram", value = 0)
        session$sendCustomMessage(type = "resetSideEffects", "event")


    } else {

        #'////////////////////////////////////////
        # process page navigation from side effects to results page

        # increment page number
        newPageNum <- pageNum() + 1
        pageNum(newPageNum)

        # load next page
        source(file = file_paths[pageNum()], local = TRUE)
        output$currentPage <- page

        # run function to update progress bar
        session$sendCustomMessage(type = "updateProgressBar", c(1, file_length, pageNum()))

        #'////////////////////////////////////////

        # run user inputs through function
        results <- patientPrefs(x = selection)

        # make new df with results based on user preferences + scores
        outputs <- reactive({
            data.frame(
                "drug" = names(results),
                "score" = results[1:31],
                stringsAsFactors = FALSE,
                row.names = 1:length(results)
            )
        })

        # send via innerHTML(id) - top 1
        js$innerHTML("#results-label-rec-1", toTitleCase(outputs()[1,1]), 50)
        js$innerHTML("#results-label-rec-2", toTitleCase(outputs()[2,1]), 50)
        js$innerHTML("#results-label-rec-3", toTitleCase(outputs()[3,1]), 50)

        # send via innerHTML(id) - top 1 - rev order in worst score (e.g., worst = highest num)
        js$innerHTML("#results-label-avoid-1", toTitleCase(outputs()[31, 1]), 50)
        js$innerHTML("#results-label-avoid-2", toTitleCase(outputs()[30, 1]), 50)
        js$innerHTML("#results-label-avoid-3", toTitleCase(outputs()[29, 1]), 50)

        # reset view to top
        js$scrollToTop()
    }
}, ignoreInit = TRUE)
