#' Analytics R6 class
#'
#' @noRd
analytics <- R6::R6Class(
    "Analytics",
    public = list(
        #' @description create a new analytics object
        #' @param version application version
        #' @param active If TRUE, data will be saved
        #' @param out_dir path to save log files
        initialize = function(version, active, out_dir) {

            if (!dir.exists(out_dir)) {
                dir.create(out_dir)
            }

            # set and create new analytics file
            path <- paste0(
                out_dir,
                "/analytics_",
                format(Sys.time(), "%y_%m_%d_%H%M%S"),
                ".json"
            )
            if (active) {
                file.create(path)
            }

            # set private data
            session <- shiny::getDefaultReactiveDomain()
            private$path <- path
            private$active <- active
            private$data$id <- session$token
            private$data$version <- version
            private$write_data()
        },

        #' @description save data for user login
        #' @param username account name
        #' @param usertype account type (dev defined)
        save_login = function(username, usertype) {
            private$data$client$username <- username
            private$data$client$usertype <- usertype
            private$data$meta$sign_in_count <- private$data$meta$sign_in_count + 1
            private$data$logged <- TRUE
            private$data$history[[length(private$data$history) + 1]] <- list(
                time = Sys.time(),
                id = "login",
                item = "user logged in",
                description = paste0(
                    "user signed in as '",
                    username,
                    "'"
                )
            )

            private$write_data()
        },

        #' @description save data on user logout
        save_logout = function() {
            # private$data$logged <- FALSE
            private$data$meta$sign_out_count <- private$data$meta$sign_out_count + 1
            private$data$history[[length(private$data$history) + 1]] <- list(
                time = Sys.time(),
                id = "logout",
                item = "user logout",
                description = "user logged out"
            )

            private$write_data()
        },

        #' @description save button clicks
        #' @param btn button id
        #' @param description note about button event
        save_click = function(btn, description) {
            private$data$history[[length(private$data$history) + 1]] <- list(
                time = Sys.time(),
                id = "btn_click",
                item = btn,
                description = description
            )

            private$write_data()
        },

        #' @description save side effects selections
        #' @param selections a dataframe containing user selections
        save_selections = function(selections) {
            t <- Sys.time()
            id <- random_id(n = 16)

            # update counter in meta
            private$data$meta$submits <- private$data$meta$submits + 1

            # log selections event + id in history
            private$data$history[[length(private$data$history) + 1]] <- list(
                time = Sys.time(),
                id = "selections",
                item = "side effect selections",
                description = id
            )

            # save selections
            private$data$selections[[length(private$data$selections) + 1]] <- list(
                time = t,
                id = id,
                data = selections
            )

            private$write_data()
        },

        #' @description save medication recommendations
        #' @param results a dataframe containing medication results
        save_results = function(results) {
            t <- Sys.time()
            id <- random_id(n = 16)

            # log results in history
            private$data$history[[length(private$data$history) + 1]] <- list(
                time = t,
                id = "results",
                item = "medication recommendations saved",
                description = id
            )

            # save results
            private$data$results[[length(private$data$results) + 1]] <- list(
                time = t,
                id = id,
                data = results
            )

            private$write_data()
        },

        #' @description save application errors
        #' @param error error ID
        #' @param message error displayed
        save_error = function(error, message) {
            private$data$meta$errors <- private$data$meta$errors + 1
            private$data$history[[length(private$data$history) + 1]] <- list(
                time = Sys.time(),
                id = "errors",
                item = error,
                description = message
            )

            private$write_data()
        },

        #' @description save data on app restart
        save_restart = function() {
            private$data$meta$restarts <- private$data$meta$restarts + 1
            private$data$history[[length(private$data$history) + 1]] <- list(
                time = Sys.time(),
                id = "session",
                item = "app_restart",
                description = "user has clicked the restart button"
            )

            private$write_data()
        },

        #' @description save data when onsessionended is triggered
        save_session_end = function() {
            private$data$timestamps$ended <- Sys.time()
            private$data$history[[length(private$data$history) + 1]] <- list(
                time = Sys.time(),
                id = "session",
                item = "onSessionEnded",
                description = "session has ended"
            )

            private$write_data()
        },

        #' @description print internal data to console
        print = function() {
            print(private$data)
        }

    ),
    private = list(
        path = NA,
        active = NA,
        data = list(

            # basic information
            name = "ice_analytics_module",
            version = NA,
            id = NA,

            # timestamps
            timestamps = list(
                started = Sys.time(),
                ended = NA
            ),

            # @param logged when TRUE, indicates that the user has logged in
            # at least once. If FALSE, then the user did not sign on (i.e., did)
            # ) did not have an account
            logged = FALSE,

            # user info
            client = list(
                username = NA,
                usertype = NA
            ),

            # summary data
            meta = list(
                errors = 0,
                restarts = 0,
                sign_in_count = 0,
                sign_out_count = 0,
                submits = 0
            ),

            # activity (i.e., session history)
            # all actions will be appended to to this list
            history = list(
                list(
                    time = Sys.time(),
                    id = "init",
                    item = "App Analytics",
                    description = "new session started"
                )
            ),
            selections = list(),
            results = list()
        ),

        # private method for saving data
        write_data = function() {
            if (private$active) {
                jsonlite::write_json(
                    x = private$data,
                    path = private$path,
                    pretty = TRUE,
                    auto_unbox = TRUE
                )
            }
        }
    )
)