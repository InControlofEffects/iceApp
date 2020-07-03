#'////////////////////////////////////////////////////////////////////////////
#' FILE: utils_analytics.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-27
#' MODIFIED: 2020-06-30
#' PURPOSE: methods for analytics
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: this class manages the analytics segment of the application.
#'      In the server, define a new object using `analytics$new()`. Then,
#'      use `myObject$log_action()` to send data to the database
#'
#'      Use tests/test_analytics.R to log data to the database
#'
#'      Usage
#'      1. Create new class
#'              myobject <- analytics$new()
#'      2. Capture some action
#'              myobject$capture_action(
#'                  event = "login",
#'                  id = "app_login",
#'                  desc = "user logged in"
#'              )
#'      3. Capture Click
#'              myobject$capture_click(
#'                  btn = "toggle001",
#'                  desc = "user clicked toggle 001"
#'              )
#'      4. Capture Error
#'              myobject$capture_error(
#'                  error = "form001_submit",
#'                  message = "password was incorrect"
#'              )
#'      5. Capture Selections (for saving user inputs)
#'              myobject$capture_selections(data)
#'      6. Capture Results (for saving medications results)
#'              myobject$capture_results(data)
#'      7. update attempts
#'              myobject$update_attempts()
#'      8. Disconnect (from database)
#'              myobject$disconnect()
#'////////////////////////////////////////////////////////////////////////////
analytics <- R6::R6Class(
    "ice_analytics",
    public = list(

        # $new()
        initialize = function(mode = "dev", user_type = "user", log = TRUE) {

            # send log status to private as other methods will need it
            private$.log <- log

            # only when connected
            if (log) {

                # display message
                browsertools::console_log("Logging Initiated")

                # define props
                private$.id <- private$.new_id()
                private$.mode <- mode
                private$.time <- Sys.time()
                private$.user_type <- user_type
                private$.log <- log

                # connect to database
                private$.db_connect()

                # write session info
                private$.write_session_info()
            }

            # if logging is disabled
            if (!log) {
                browsertools::console_warn(
                    "Logging is disabled for this session"
                )
            }
        },

        # capture action (a generic write function)
        capture_action = function(event, id, desc) {
            if (private$.log) {
                private$.write_action(
                    event = event,
                    event_id = id,
                    event_desc = desc
                )
            }
        },

        # log button clicks
        capture_click = function(btn, desc) {
            if (private$.log) {
                private$.write_action(
                    event = "click",
                    event_id = btn,
                    event_desc = desc
                )
            }
        },

        # log errors
        capture_error = function(error, message) {
            if (private$.log) {
                private$.write_action(
                    event = "error",
                    event_id = error,
                    event_desc = message
                )
            }
        },

        # log user selections
        capture_selections = function(selections) {
            if (private$.log) {
                private$.write_selections(data = selections)
            }
        },

        #' log results
        #' @param results returned object from the user preferences function
        capture_results = function(results) {
            if (private$.log) {
                private$.write_results(data = results)
            }
        },

        # update session attempts
        update_attempts = function() {
            if (private$.log) {
                private$.attempts <- private$.attempts + 1
                private$.write_session_info()
            }
        },

        # disconnect
        disconnect = function() {
            if (private$.log) {
                private$.db_disconnect()
            }
        }
    ),
    private = list(

        # set props
        .db_name = "data/ice.db",
        .db_conn = NA,
        .id = NA,
        .mode = NA,
        .time = NA,
        .user_type = NA,
        .attempts = 1,
        .log = TRUE,

        # connect to database
        .db_connect = function() {
            private$.db_conn <- DBI::dbConnect(
                drv = RSQLite::SQLite(),
                dbname = private$.db_name
            )
        },

        # disconnect
        .db_disconnect = function() {
            DBI::dbDisconnect(private$.db_conn)
        },

        # generate new ID
        .new_id = function(length = 32) {
            d <- sample(x = c(0:9, letters), size = length, replace = TRUE)
            return(paste0(d, collapse = ""))
        },

        # on Initial creation
        .write_session_info = function() {
            d <- data.frame(
                id = private$.id,
                mode = private$.mode,
                time = private$.time,
                user_type = private$.user_type,
                attempt = private$.attempts
            )
            DBI::dbAppendTable(private$.db_conn, name = "sessions", value = d)
        },

        # write action
        .write_action = function(event, event_id, event_desc) {

            # define object data to write into table
            d <- data.frame(
                id = private$.id,
                attempt = private$.attempts,
                time = Sys.time(),
                event = event,
                event_id = event_id,
                event_desc = event_desc
            )

            # append table
            DBI::dbAppendTable(private$.db_conn, name = "actions", value = d)
        },

        # write user selections
        .write_selections = function(data) {

            # bind private data to data
            d <- data
            d$id <- private$.id
            d$attempt <- private$.attempts
            d$time <- Sys.time()

            # reorder
            d <- d[, c(
                "id", "attempt", "time", "akathisia",
                "anticholinergic", "antiparkinson",
                "prolactin", "qtc", "sedation", "weight_gain"
            )]

            # write
            DBI::dbAppendTable(
                private$.db_conn,
                name = "selections",
                value = d
            )
        },

        # write results
        .write_results = function(data) {

            # bind private data to data
            d <- data
            d$id <- private$.id
            d$attempt <- private$.attempts

            # reorder
            d <- d[, c(
                "id", "attempt", "time",
                "rx_rec_a", "rx_rec_b", "rx_rec_c",
                "rx_avoid_a", "rx_avoid_b", "rx_avoid_c"
            )]

            # write data
            DBI::dbAppendTable(
                private$.db_conn,
                name = "results",
                value = d
            )

        }
    )
)