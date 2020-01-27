#'//////////////////////////////////////////////////////////////////////////////
#' FILE: page-navigation.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-26
#' MODIFIED: 2020-01-27
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
    session$sendCustomMessage(
        type = "updateProgressBar", c(-1, file_length, page_num())
    )
    shinytools::scroll_to_top()

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
    session$sendCustomMessage(
        type = "updateProgressBar", c(1, file_length, page_num())
    )
    shinytools::scroll_to_top()

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
    session$sendCustomMessage(
        type = "updateProgressBar", c(1, file_length, page_num())
    )
    shinytools::scroll_to_top()

}, ignoreInit = TRUE)

# ~ 4 ~
# NAVIGATION: APP RESTARTS
observeEvent(input$restart, {

    # increment page number
    new_page_num <- 1
    page_num(new_page_num)

    # load next page
    source(file = file_paths[page_num()], local = TRUE)
    output$current_page <- page

    # run function to update progress bar
    session$sendCustomMessage(
        type = "updateProgressBar", c(0, file_length, page_num())
    )
    shinytools::scroll_to_top()

}, ignoreInit = TRUE)