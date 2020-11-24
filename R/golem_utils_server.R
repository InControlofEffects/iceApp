#' Write Side Effects Results
#'
#' Send Medication results to the client
#'
#' @param data results to write
#'
#' @noRd
write_se_results <- function(data) {
    iceComponents::update_card(inputId = "rec-rx-a", text = data$rx_rec_a)
    iceComponents::update_card(inputId = "rec-rx-b", text = data$rx_rec_b)
    iceComponents::update_card(inputId = "rec-rx-c", text = data$rx_rec_c)
    iceComponents::update_card(inputId = "avoid-rx-a", text = data$rx_avoid_a)
    iceComponents::update_card(inputId = "avoid-rx-b", text = data$rx_avoid_b)
    iceComponents::update_card(inputId = "avoid-rx-c", text = data$rx_avoid_c)
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