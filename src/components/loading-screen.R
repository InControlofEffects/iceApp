#'//////////////////////////////////////////////////////////////////////////////
#' FILE: loading-screen.R
#' AUTHOR: David Ruvolo
#' CREATED: 08 June 2019
#' MODIFIED: 08 June 2019
#' PURPOSE: module for laoding screen
#' PACKAGES: shiny
#' STATUS: in.progress
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
loadingScreen <- function(){
    tags$div(id = "loading-screen",
        tags$div(class="message",
            tags$span(id="dot1", class="dots"),
            tags$span(id="dot2", class="dots"),
            tags$span(id="dot3", class="dots")
        )
    )
}