#' error_box
#'
#' @description Create Error Messages
#'
#' @param id a unique id for the error box
#' @param class pass css class names
#'
#' @importFrom shiny tags
#' @noRd
error_box <- function(id, class = NULL) {

    # generate markup
    el <- tags$div(
        id = id,
        class = "error-box",
        role = "alert",
        hidden = "",
        rheroicons::icons$exclamation(type = "outline", aria_hidden = TRUE),
        tags$span(
            id = paste0(id, "-error-message"),
            class = "error-box-text"
        )
    )

    # update class attribute
    if (!is.null(class)) {
        el$attribs$class <- paste0(
            el$attribs$class, " ", class
        )
    }

    # return
    return(el)
}


#' update_error_message_box
#'
#' @description update error box
#' @param id ID of error to update
#' @param error message to display
#' @importFrom shiny getDefaultReactiveDomain
#' @noRd
update_error_box <- function(id, error) {
    session <- getDefaultReactiveDomain()
    session$sendCustomMessage(
        type = "update_error_box",
        message = list(
            id = id,
            error = error
        )
    )
}

#' reset_error_box
#' @description reset an error box
#' @param id ID of the error element
#' @importFrom shiny getDefaultReactiveDomain
#' @noRd
reset_error_box <- function(id) {
    session <- getDefaultReactiveDomain()
    session$sendCustomMessage(
        type = "reset_error_box",
        message = list(id = id)
    )
}


#' error_text
#' @description Create error text
#' @param id a ID for the message
#' @param class optional CSS classes to include
#' @importFrom shiny tags
#' @noRd
error_text <- function(id, class = NULL) {
    el <- tags$span(id = id, class = "error-text")
    if (!is.null(class)) {
        el$attribs$class <- paste0(
            el$attribs$class, " ", class
        )
    }
    return(el)
}


#' update_error_text
#' @description update an error message text
#' @param id ID of the error element
#' @param error message to display
#' @importFrom shiny getDefaultReactiveDomain
#' @noRd
update_error_text <- function(id, error) {
    session <- getDefaultReactiveDomain()
    session$sendCustomMessage(
        type = "update_error_text",
        message = list(
            id = id,
            error = error
        )
    )
}

#' reset_error_text
#' @description reset an error text element
#' @param id Id of the error element
#' @importFrom shiny getDefaultReactiveDomain
#' @noRd
reset_error_text <- function(id) {
    session <- getDefaultReactiveDomain()
    session$sendCustomMessage(
        type = "reset_error_text",
        message = list(id = id)
    )
}