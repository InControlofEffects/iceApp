#'////////////////////////////////////////////////////////////////////////////
#' FILE: utils_progress_bar.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-27
#' MODIFIED: 2020-07-14
#' PURPOSE: utils object
#' STATUS: single object with nested methods for use in the app
#' PACKAGES: NA
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' Define list
utils <- list()

#'//////////////////////////////////////

#' Function to update progress bar
utils$updateProgressBar <- function(elem = "bar", now, max) {
    session <- shiny::getDefaultReactiveDomain()
    session$sendCustomMessage(
        type = "updateProgressBar",
        message = list(
            elem = elem,
            now = now,
            max = max
        )
    )
}

# function to update document title
utils$set_document_title <- function(title) {
    stopifnot(is.character(title))
    session <- shiny::getDefaultReactiveDomain()
    session$sendCustomMessage(
        type = "set_document_title",
        message = list(
            title = title
        )
    )
}

#' Function to handle page fade In + out
utils$fadePage <- function() {
    session <- shiny::getDefaultReactiveDomain()
    session$sendCustomMessage(type = "fadePage", message = "")
}

#'//////////////////////////////////////

#' Utils for Side Effects Page
utils$side_effects <- list()

# show error message
utils$side_effects$show_error_message <- function(message) {
    browsertools::show_elem("#side-effects-error-box")
    browsertools::inner_text("#side-effects-error-message", message)
}

# hide error message
utils$side_effects$hide_error_message <- function() {
    browsertools::hide_elem("#side-effects-error-box")
    browsertools::inner_text("#side-effects-error-message", "")
}

# reset side effects functions
utils$side_effects$reset_side_effects <- function() {
    session <- shiny::getDefaultReactiveDomain()
    updateCheckboxInput(session, "akathisia-checked", value = 0)
    updateCheckboxInput(session, "anticholinergic-checked", value = 0)
    updateCheckboxInput(session, "antiparkinson-checked", value = 0)
    updateCheckboxInput(session, "prolactin-checked", value = 0)
    updateCheckboxInput(session, "qtc-checked", value = 0)
    updateCheckboxInput(session, "sedation-checked", value = 0)
    updateCheckboxInput(session, "weight_gain-checked", value = 0)
    session$sendCustomMessage("reset_side_effects", "")
}

# write site effects to UI
utils$side_effects$write_side_effects <- function(results, delay = 175) {
    browsertools::inner_text(
        elem = "#rec-rx-a-result-title",
        string = results$rx_rec_a,
        delay = delay
    )

    # write recommended medication #2
    browsertools::inner_text(
        elem = "#rec-rx-b-result-title",
        string = results$rx_rec_b,
        delay = delay
    )

    # write recommended medication #3
    browsertools::inner_text(
        elem = "#rec-rx-c-result-title",
        string = results$rx_rec_c,
        delay = delay
    )

    # write avoid medication # 1
    browsertools::inner_text(
        elem = "#avoid-rx-a-result-title",
        string = results$rx_avoid_a,
        delay = delay
    )

    # write avoid medication # 2
    browsertools::inner_text(
        elem = "#avoid-rx-b-result-title",
        string = results$rx_avoid_b,
        delay = delay
    )

    # write avoid medication # 3
    browsertools::inner_text(
        elem = "#avoid-rx-c-result-title",
        string = results$rx_avoid_c,
        delay = delay
    )
}