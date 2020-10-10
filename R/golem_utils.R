#' Progressbar
#'
#' Create new Progress bar that will be used in the UI and Server
#'
#' @noRd
ice_progressbar <- iceComponents::progressbar(start = 0, min = 0, max = 7)

#' Generate ID
#'
#' Create a random string of letters and numbers
#'
#' @param n length of ID
#'
#' @noRd
random_id <- function(n) {
    paste0(sample(c(letters, LETTERS, 0:9), n, replace = TRUE), collapse = "")
}