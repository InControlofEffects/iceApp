#' Show Side Effects Error Message
#'
#' A JavaScript handler that shows the side effects box error message and
#' writes a new title
#'
#' @param message an error message to display
#' 
#' @importFrom shiny getDefaultReactiveDomain
#' @noRd
show_se_error <- function(message) {
    session <- getDefaultReactiveDomain()
    session$sendCustomMessage(
        type = "show_se_error",
        message = list(
            elem = "side-effects-error-box",
            message = message
        )
    )
}


#' Hide Side Effects Error Message
#'
#' Run a JavaScript handlers that hides the side effects error message
#'
#' @importFrom shiny getDefaultReactiveDomain
#' @noRd
hide_se_error <- function() {
    session <- getDefaultReactiveDomain()
    session$sendCustomMessage(
        type = "hide_se_error",
        message = list(
            elem = "side-effects-error-box"
        )
    )
}


#' Write Side Effects Results
#'
#' Send Medication results to the client
#'
#' @param data results to write
#' @param delay time to wait before writing the results
#'
#' @noRd
write_se_results <- function(data, delay = 200) {

    # write recommended medication #1
    browsertools::inner_text(
        elem = "#rec-rx-a-result-title",
        content =  data$rx_rec_a,
        delay = delay
    )

    # write recommended medication #2
    browsertools::inner_text(
        elem = "#rec-rx-b-result-title",
        content =  data$rx_rec_b,
        delay = delay
    )

    # write recommended medication #3
    browsertools::inner_text(
        elem = "#rec-rx-c-result-title",
        content =  data$rx_rec_c,
        delay = delay
    )

    # write avoid medication # 1
    browsertools::inner_text(
        elem = "#avoid-rx-a-result-title",
        content =  data$rx_avoid_a,
        delay = delay
    )

    # write avoid medication # 2
    browsertools::inner_text(
        elem = "#avoid-rx-b-result-title",
        content =  data$rx_avoid_b,
        delay = delay
    )

    # write avoid medication # 3
    browsertools::inner_text(
        elem = "#avoid-rx-c-result-title",
        content =  data$rx_avoid_c,
        delay = delay
    )
}


#' Validate Side Effects
#' 
#' Function used to validate and generate medication recommendations
#'
#' @param data user inputs
#'
#' @noRd
validate_side_effects <- function(data) {

    # if sum of selections is zero
    if (sum(data[1, ]) == 0) {

        # set response
        response <- list(
            ok = FALSE,
            error = list(
                msg = "No selections were made. Please select a side effect",
                log = "Side Effects Error: No options were selected"
            )
        )

    } else if (sum(data[1, ]) > 1) {

        # set error
        response <- list(
            ok = FALSE,
            error = list(
                msg = "Too many selections were made. Please select 1 option.",
                log = "Side Effects Error: selections were greater than 1."
            )
        )

    } else {

        # generate recommendations
        raw_results <- as.data.frame(
            iceData::user_preferences(
                data = iceData::meds,
                weights = data[1, ],
                return_all = FALSE
            )
        )

        # reduce results to desired elements
        results <- data.frame(
            rx_rec_a = raw_results[1, "name"],
            rx_rec_b = raw_results[2, "name"],
            rx_rec_c = raw_results[3, "name"],
            rx_avoid_a = raw_results[NROW(raw_results), "name"],
            rx_avoid_b = raw_results[NROW(raw_results) - 1, "name"],
            rx_avoid_c = raw_results[NROW(raw_results) - 2, "name"]
        )

        # build response
        response <- list(
            ok = TRUE,
            data = list(
                raw = raw_results,
                recs = results
            )
        )

    }

    # return response
    return(response)
}