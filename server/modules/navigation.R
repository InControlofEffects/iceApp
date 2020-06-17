#'//////////////////////////////////////////////////////////////////////////////
#' FILE: page-navigation.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-26
#' MODIFIED: 2020-06-017
#' PURPOSE: handle primary page navigation
#' PACKAGES: shiny
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////

# ~ 1 ~
# NAVIGATION: PREVIOUS PAGE
observeEvent(input$previousPage, {

    # evaluate current page number
    new_page_num <- page_num() - 1
    page_num(new_page_num)

    # load previous page
    source(file = file_paths[page_num()], local = TRUE)
    output$current_page <- page

    # run function to update progress bar
    updateProgressBar(now = page_num())
    browsertools::scroll_to()

}, ignoreInit = TRUE)


# ~ 2 ~
# NAVIGATION: NEXT PAGE
observeEvent(input$nextPage, {

    # increment page number
    new_page_num <- page_num() + 1
    page_num(new_page_num)

    # load next page
    source(file = file_paths[page_num()], local = TRUE)
    output$current_page <- page

    # run function to update progress bar
    updateProgressBar(now = page_num())
    browsertools::scroll_to()

}, ignoreInit = TRUE)


# ~ 3 ~
# NAVIGATION: START BUTTON
observeEvent(input$start, {

    # increment page number
    new_page_num <- page_num() + 1
    page_num(new_page_num)

    # load next page
    source(file = file_paths[page_num()], local = TRUE)
    output$current_page <- page

    # run function to update progress bar
    updateProgressBar(now = page_num())
    browsertools::scroll_to()

}, ignoreInit = TRUE)

# ~ 4 ~
# NAVIGATION: APP RESTARTS
observeEvent(input$restart, {

    if (logged()) {
        # increment page number
        new_page_num <- 1
        page_num(new_page_num)

        # load next page
        source(file = file_paths[page_num()], local = TRUE)
        output$current_page <- page

        # run function to update progress bar
        updateProgressBar(now = page_num())
        browsertools::scroll_to()
    }

    if (!logged()) {
        output$current_page <- renderUI(loginScreen())
    }

}, ignoreInit = TRUE)