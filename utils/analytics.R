#'////////////////////////////////////////////////////////////////////////////
#' FILE: utils_analytics.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-27
#' MODIFIED: 2020-07-14
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
#'      - Create new class: required for creating a new analytics object
#'              myobject <- analytics$new()
#'      - Capture some action: log an action to the database
#'            myobject$capture_action(
#'                event = "login",
#'                id = "app_login",
#'                desc = "user logged in"
#'            )
#'      - Capture Click: log a button click to the database
#'            myobject$capture_click(
#'                btn = "toggle001",
#'                desc = "user clicked toggle 001"
#'            )
#'      - Capture Error: log an error to the database
#'            myobject$capture_error(
#'              error = "form001_submit",
#'              message = "password was incorrect"
#'            )
#'      - Capture Login: log sign in behaviors to the database.
#'          Recieves user account type that is identified through the login
#'          module.
#'            myobject$capture_login(type = "user_account_type")
#'      - Capture Selections: log user selections to the database
#'          Data must be in wide format (1 row; each col is a side effect)
#'              myobject$capture_selections(data = selections)
#'      - Capture Results: save top avoid and recommended medications to the
#'          database. This may be useful for later features/analysis
#'              myobject$capture_results(data)
#'      - update attempts: log the number of times a user has restarted the
#'          application.
#'              myobject$update_attempts()
#'      - Disconnect (from database)
#'              myobject$disconnect()
#'////////////////////////////////////////////////////////////////////////////
analytics <- R6::R6Class(
    "ice_analytics",
    public = list(

        #' $new()
        #' Creates a new analytics object, including db connection
        #' @param mode current state of the application; dev, live, test, etc.
        #' @param user_type account type; admin, user, etc.
        #' @param log a logical value to disable all analytics
        initialize = function(mode = "dev", user_type = "unknown", log = TRUE) {

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

        #' $capture_action
        #' A generic function for saving a specific action to the database
        #' This may be useful for cases where an event occurs only once.
        #' @param event a category for the action
        #' @param id an id for the action
        #' @param desc a description of the action
        #' If logging a click or error, use `capture_click` or `capture_error`
        capture_action = function(event, id, desc) {
            if (private$.log) {
                private$.write_action(
                    event = event,
                    event_id = id,
                    event_desc = desc
                )
            }
        },

        #' $capture_click
        #' Log button clicks to the database
        #' @param btn the name or ID of the button clicked
        #' @param desc a description of the button
        capture_click = function(btn, desc) {
            if (private$.log) {
                private$.write_action(
                    event = "click",
                    event_id = btn,
                    event_desc = desc
                )
            }
        },

        #' $capture_error
        #' log an error to the database
        #' @param error a name/ID for the error
        #' @param message a description of the error or message
        capture_error = function(error, message) {
            if (private$.log) {
                private$.write_action(
                    event = "error",
                    event_id = error,
                    event_desc = message
                )
            }
        },

        #' $capture_login
        #' Capture event when user is logged in to the application
        #' @param type the account type of the signed-in user
        capture_login = function(type) {
            private$.user_type <- type
            if (private$.log) {

                # save action
                private$.write_action(
                    event = "session",
                    event_id = "login",
                    event_desc = "user logged in successfully as"
                )

                # update sessions table
                private$.update_usertype()
            }
        },

        #' $capture_selections
        #' Save user selections to the database
        #' @param selections a wide-format data object where each column is a
        #'       side effect and the corresponding value is 0 = not selected
        #'       and 1 = selected (the sum should always be 1)
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

        #' $update_attempts
        #' Increment the internal counter that tracks how many times the user
        #' has reselected side effects
        update_attempts = function() {
            if (private$.log) {
                private$.attempts <- private$.attempts + 1
                private$.write_session_info()
            }
        },

        #' $disconnect
        #' Close database connection
        disconnect = function() {
            if (private$.log) {
                private$.db_disconnect()
            }
        }
    ),

    #'//////////////////////////////////////

    #' Private Methods
    #' Define methods that interact with database
    private = list(

        #' set the name of the database and init variable
        #' that will receive the database connection
        .db_name = "data/ice.db",
        .db_conn = NA,

        #' @param id var that will receive the new user ID
        .id = NA,

        #' @param mode current mode of the app (i.e., dev, test, live)
        .mode = NA,

        #' @param time the time the session was started
        .time = NA,

        #' @param user_type account type of the signed in user
        .user_type = NA,

        #' @param attemps attempts internal counter for number of times the
        #'   user submitted side effects
        .attempts = 1,

        #' @param log a logical value to disable/enable database logging
        .log = TRUE,

        #' $.db_connect
        #' establish connection to the database. This requires the database
        #' name.
        .db_connect = function() {
            private$.db_conn <- DBI::dbConnect(
                drv = RSQLite::SQLite(),
                dbname = private$.db_name
            )
        },

        #' $.db_disconnect
        #' Disconnect for the application database
        .db_disconnect = function() {
            DBI::dbDisconnect(private$.db_conn)
        },

        #' $.new_id
        #' Create a randomly generated ID for the session
        #' @param length determine the length of the ID (default 32 characters)
        .new_id = function(length = 32) {
            d <- sample(x = c(0:9, letters), size = length, replace = TRUE)
            return(paste0(d, collapse = ""))
        },

        #' $.write_session_info
        #' When the sesssion is initiated, create a new session using user info
        #' and save to the database
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

        #' $.update_usertype
        #' Update the user type in the database using the accounts database
        .update_usertype = function() {

            # create query
            q <- paste0(
                "UPDATE sessions SET user_type = '",
                private$.user_type,
                "' WHERE id = '",
                private$.id,
                "'"
            )

            # execute
            DBI::dbExecute(private$.db_conn, q)
        },

        #' $.write_action
        #' Log a named action to the database other than clicks or errors
        #' @param event the type of action to log
        #' @param event_id an ID for the event
        #' @param event_desc a description of the event
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

        #' $.write_selections
        #' Save user selections to the database
        #' @param selections a wide-format data object where each column is a
        #'       side effect and the corresponding value is 0 = not selected
        #'       and 1 = selected (the sum should always be 1)
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

        #' $.write_results
        #' Save results to the database
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