#'//////////////////////////////////////////////////////////////////////////////
#' FILE: loading-screen.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-08
#' MODIFIED: 2020-01-25
#' PURPOSE: module for laoding screen
#' PACKAGES: shiny
#' STATUS: in.progress
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
loadingScreen <- function() {
    tags$div(id = "loading-screen",
        tags$div(class = "message",
            tags$span(id = "dot1", class = "dots"),
            tags$span(id = "dot2", class = "dots"),
            tags$span(id = "dot3", class = "dots")
        )
    )
}