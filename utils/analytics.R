#'////////////////////////////////////////////////////////////////////////////
#' FILE: utils_analytics.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-27
#' MODIFIED: 2020-06-27
#' PURPOSE: methods for analytics
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: this class manages the analytics segment of the application.
#'      In the server, define a new object using `analytics$new()`. Then,
#'      use `myObject$log_action()` to send data to the database
#'////////////////////////////////////////////////////////////////////////////
analytics <- R6::R6Class(
    "analytics",
    # public
    public = list(
        session_id = NA,
        initialize = function() {
            self$session_id <- private$new_id()

            # log init to DB
            self$log_action(
                action = "session",
                value = "initialized",
                result = NA
            )
        },
        log_action = function(action, value, result) {
            d <- data.frame(
                id = self$session_id,
                time = Sys.time(),
                action = action,
                value = value,
                result = result
            )

            # log action to DB
            return(d)
        }
    ),
    # private methods
    private = list(
        new_id = function(length = 32) {
            d <- sample(x = c(0:9, letters), size = length, replace = TRUE)
            return(paste0(d, collapse = ""))
        }
    )
)