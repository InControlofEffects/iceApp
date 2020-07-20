#' Show Error Message
#'
#' A JavaScript handler that shows the side effects box error message and
#' writes a new title
#'
#' @param session required shiny object
#' @param message an error message to display
#' @noRd
show_error <- function(session, message) {
    session$sendCustomMessage(
        type = "show_error",
        message = list(
            elem = "#side-effects-error-box",
            message = message
        )
    )
}


#' Hide Side Effects Error Message
#'
#' Run a JavaScript handlers that hides the side effects error message
#'
#' @param session required shiny object
#'
#' @noRd
hide_error <- function() {
    session$sendCustomMessage(
        type = "hide_error",
        message = list(
            elem = "#side-effects-error-box"
        )
    )
}


#' Write side effects
#'
#' Send Medication results to the client
#'
#' @param session required shiny object
#' @param data results to write
#' @param delay time to wait before writing the results
#'
#' @noRd
write_side_effects <- function(session, data, delay = 200) {
    session$sendCustomMessage(
        type = "write_side_effects",
        message = list(
            data = data,
            delay = delay
        )
    )
}

#' Reset Side Effects
#'
#' Reset side effects input to their default state (i.e., unchecked)
#'
#' @param session required shiny object
#'
#' @noRd
reset_side_effects <- function() {
    updateCheckboxInput(session, "akathisia-checked", value = 0)
    updateCheckboxInput(session, "anticholinergic-checked", value = 0)
    updateCheckboxInput(session, "antiparkinson-checked", value = 0)
    updateCheckboxInput(session, "prolactin-checked", value = 0)
    updateCheckboxInput(session, "qtc-checked", value = 0)
    updateCheckboxInput(session, "sedation-checked", value = 0)
    updateCheckboxInput(session, "weight_gain-checked", value = 0)
    session$sendCustomMessage("reset_side_effects", "")
}