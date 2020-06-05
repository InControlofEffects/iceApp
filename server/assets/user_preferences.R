#'////////////////////////////////////////////////////////////////////////////
#' FILE: user_preferences.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-03
#' MODIFIED: 2020-06-05
#' PURPOSE: function for generating user preferences
#' STATUS: complete
#' PACKAGES: tidyr
#' COMMENTS: *see below*
#'////////////////////////////////////////////////////////////////////////////
#'
#' user_preferences()
#' A function that generates new scores per medications
#'
#' @param data`an object containing the medications and scores (post filtered)
#' @param weights an array of weights by side effect (1 = selected).
#'              The sum of the array should be 1 (as 1 selection is allowed)
#' @param return_all a logical argument that determines if the full dataset
#'              should be returned (i.e., individuals scores by medication).
#'              Otherwise, only the medication and final score will be
#'              returned (default).
#'
#' Data should be filtered for country and quality prior to running this
#' function. Results will be sorted from lowest score to highest. Lower scores
#' are indicative of medications that are suitable to the side effects that
#' the user would like to avoid.
#'
#' For testing, load the following dataset
#' df <- readRDS("data/incontrolofeffects_rx.RDS")
#'
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