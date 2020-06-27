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
    "ice_analytics",
    public = list(

        # $new()
        initialize = function(mode = "dev", user_type = "user") {

            # define props
            private$.id <- private$.new_id()
            private$.mode <- mode
            private$.time <- Sys.time()
            private$.user_type <- user_type

            # connect to database
            private$.db_connect()

            # write session info
            private$.write_session_info()
        },

        # log button clicks
        capture_click = function(btn, desc) {
            private$.write_action(
                event = "click",
                event_id = btn,
                event_desc = desc
            )
        },

        # log errors
        capture_error = function(error, message) {
            private$.write_action(
                event = "error",
                event_id = error,
                event_desc = message
            )
        },

        # log user selections
        capture_selections = function(selections) {
            private$.write_selections(data = selections)
        },

        # update session attempts
        update_attempts = function() {
            private$.attempts <- private$.attempts + 1
            private$.write_session_info()
        },

        # disconnect
        disconnect = function() {
            private$.db_disconnect()
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
                "prolactic", "qtc", "sedation", "weight_gain"
            )]

            # write
            DBI::dbAppendTable(
                private$.db_conn,
                name = "selections",
                value = d
            )
        }
    )
)

#' Tests
client <- analytics$new()