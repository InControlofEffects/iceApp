#'////////////////////////////////////////////////////////////////////////////
#' FILE: utils_user_preferences.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-27
#' MODIFIED: 2020-06-27
#' PURPOSE: user preferences function
#' STATUS: working
#' PACKAGES: NA
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////
user_preferences <- function(data, weights, return_all = FALSE) {

    #' validate
    if (sum(weights) != 1) stop("the sum of weights must be equal to 1")

    #' new_prefs
    #' Define a new function that builds a object which new scores
    #' will be writen into or reshapes the dataset with the current
    #' values.
    #' @param data input dataset
    #' @param blank logical arg that either zeros out or keeps values
    new_prefs <- function(data, blank = TRUE) {

        #' select columns
        a <- data[, c("id", "name", "side_effect", "value")]

        #' When blank
        if (blank) a$value <- 0

        #' transform
        b <- tidyr::pivot_wider(
                a,
                id_cols = c("id", "name"),
                names_from = "side_effect",
                values_from = "value"
            )

        #' when !blank
        if (!blank) b[, c("id", "name")] <- NULL

        #' add blank score column

        #' return
        return(b)
    }

    #' Define Side Effects
    side_effects <- c(
        "akathisia",
        "anticholinergic",
        "antiparkinson",
        "prolactin",
        "qtc",
        "sedation",
        "weight_gain"
    )

    #' Create Required Objects (weights, preferences, and input data)
    user_weights <- as.numeric(weights)
    user_prefs <- new_prefs(data = data, blank = TRUE)
    ref_data <- new_prefs(data = data, blank = FALSE)

    #' Build a new score per city (i.e., weighted mean)
    #' Alternatively, we could use the weighted.mean function, but I want to
    #' keep the new scores in case we want to use them later. I am also leaving
    #' the function open in case we want to allow for multiple selections.
    for (i in seq_len(NROW(ref_data))) {
        scores <- (ref_data[i, ] * user_weights)
        user_prefs[i, side_effects] <- rbind(scores)
        user_prefs[i, "score"] <- sum(scores, na.rm = TRUE) / sum(user_weights)
    }

    #' Sort data
    user_prefs <- user_prefs[order(user_prefs$score, decreasing = FALSE), ]

    #' Return limited columns of interest
    if (!return_all) user_prefs <- user_prefs[, c("id", "name", "score")]

    #' Return
    return(user_prefs)
}

#' Tests
#' user_preferences(data = df, weights = c(0, 0, 0, 0, 0, 0, 0))
#' user_preferences(data = df, weights = c(1, 0, 0, 0, 0, 0, 0))
#' user_preferences(data = df, weights = c(0, 1, 0, 0, 0, 0, 0))
#' user_preferences(data = df, weights = c(0, 0, 1, 0, 0, 0, 0))
#' user_preferences(data = df, weights = c(0, 0, 0, 1, 0, 0, 0))
#' user_preferences(data = df, weights = c(0, 0, 0, 0, 1, 0, 0))
#' user_preferences(data = df, weights = c(0, 0, 0, 0, 0, 1, 0))
#' user_preferences(data = df, weights = c(0, 0, 0, 0, 0, 0, 1))
#' user_preferences(data = df, weights = c(2, 0, 0, 0, 0, 1, 0))
#' user_preferences(data = df, weights = c(0, 0, 0, 0, 0, 1, 0), return_all = TRUE)