#' update progress bar
#'
#' Update the application's progress bar from the shiny server
#'
#' @param elem the ID of the progress bar element
#' @param now A numeric value representing the current state of the app
#' @param max A numeric value representing the max state of the app
#'
#' @importFrom shiny getDefaultReactiveDomain
#' @noRd
update_progress_bar <- function(elem = "appProgress", now, max) {
    session <- getDefaultReactiveDomain()
    session$sendCustomMessage(
        type = "update_progress_bar",
        message = list(
            elem = elem,
            now = now,
            max = max
        )
    )
}

#' Fade Current subpage
#'
#' A js handler that handles the fading of a subpage
#'
#' @noRd
fade_page <- function() {
    session <- getDefaultReactiveDomain()
    session$sendCustomMessage(
        type = "fade_page",
        message = ""
    )
}
