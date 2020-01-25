#'//////////////////////////////////////////////////////////////////////////////
#' FILE: card-medication.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-12-12
#' MODIFIED: 2020-01-25
#' PURPOSE: UI component for creating medication cards
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
card_medication <- function(id, title = NULL, css = NULL, icon = NULL) {

    # render default elements
    card <- tags$div(class = "card", id = paste0("card-", id))
    p <- tags$p(id = id, class = "card-label label-rec")

    # add text tot title element
    if (!is.null(title)) {
        p$children <- title
    }

    # add icon
    if (!is.null(icon)) {
        card$children <- list(icon, p)
    } else {
        card$children <- p
    }

    # apply css
    if (!is.null(css)) {
        card$attribs$class <- paste0(card$attribs$class, " ", css)
    }

    # return
    return(card)

}