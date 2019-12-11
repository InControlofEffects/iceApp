#'//////////////////////////////////////////////////////////////////////////////
#' FILE: page-navigation.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-26
#' MODIFIED: 2019-12-11
#' PURPOSE: handle primary page navigation
#' PACKAGES: shiny
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////

# ~ 1 ~
# NAVIGATION: PREVIOUS PAGE
observeEvent(input$previousPage, {

    # evaluate current page number
    newPageNum <- pageNum() - 1
    pageNum(newPageNum)

    # load previous page
    source(file = file_paths[pageNum()], local = TRUE)
    output$currentPage <- page

    # run function to update progress bar
    session$sendCustomMessage(type = "updateProgressBar", c(-1, file_length, pageNum()))
    js$scrollToTop()

}, ignoreInit = TRUE)


# ~ 2 ~
# NAVIGATION: NEXT PAGE
observeEvent(input$nextPage, {

    # increment page number
    newPageNum <- pageNum() + 1
    pageNum(newPageNum)

    # load next page
    source(file = file_paths[pageNum()], local = TRUE)
    output$currentPage <- page

    # run function to update progress bar
    session$sendCustomMessage(type = "updateProgressBar", c(1, file_length, pageNum()))
    js$scrollToTop()

}, ignoreInit = TRUE)


# ~ 3 ~
# NAVIGATION: START BUTTON
observeEvent(input$start, {

    # increment page number
    newPageNum <- pageNum() + 1
    pageNum(newPageNum)

    # load next page
    source(file = file_paths[pageNum()], local = TRUE)
    output$currentPage <- page

    # run function to update progress bar
    session$sendCustomMessage(type = "updateProgressBar", c(1, file_length, pageNum()))
    js$scrollToTop()

}, ignoreInit = TRUE)

# ~ 4 ~
# NAVIGATION: APP RESTARTS
observeEvent(input$restart, {

    # increment page number
    newPageNum <- 1
    pageNum(newPageNum)

    # load next page
    source(file = file_paths[pageNum()], local = TRUE)
    output$currentPage <- page

    # run function to update progress bar
    session$sendCustomMessage(type = "updateProgressBar", c(0, file_length, pageNum()))
    js$scrollToTop()

}, ignoreInit = TRUE)