#' Analytics R6 class
#'
#' @noRd
session_analytics <- R6::R6Class(
    "Analytics",
    public = list(
        initialize = function(version, session = shiny::getDefaultReactiveDomain()) {

            # set and create new analytics file
            path <- paste0(
                "logs/analytics_",
                format(Sys.time(), "%y_%m_%d_%H%M%S"),
                ".json"
            )
            file.create(path)

            # set private data
            private$.data$session_id <- session$token
            private$.data$version <- version
            private$.path <- path
            private$.write_data()
        },

        # method: save state when user is logged in
        save_login = function(username, usertype) {
            private$.data$client$username <- username
            private$.data$client$usertype <- usertype
            private$.data$meta$sign_in_count <- private$.data$meta$sign_in_count + 1
            private$.data$logged <- TRUE
            private$.data$data[[length(private$.data$data) + 1]] <- list(
                time = Sys.time(),
                id = "login",
                item = "user logged in",
                description = paste0(
                    "user signed in as '",
                    username,
                    "'"
                )
            )

            private$.write_data()
        },

        # method: save logout
        save_logout = function() {
            # private$.data$logged <- FALSE
            private$.data$meta$sign_out_count <- private$.data$meta$sign_out_count + 1
            private$.data$data[[length(private$.data$data) + 1]] <- list(
                time = Sys.time(),
                id = "logout",
                item = "user logout",
                description = "user logged out"
            )

            private$.write_data()
        },

        # method: save button clicks
        save_click = function(btn, description) {
            private$.data$data[[length(private$.data$data) + 1]] <- list(
                time = Sys.time(),
                id = "btn_click",
                item = btn,
                description = description
            )

            private$.write_data()
        },

        # method: save side effects selections (regardless of error)
        save_selections = function(selections) {
            private$.data$meta$se_submissions <- private$.data$meta$se_submissions + 1 
            private$.data$data[[length(private$.data$data) + 1]] <- list(
                time = Sys.time(),
                id = "selections",
                item = "side effect selections",
                description = selections
            )

            private$.write_data()
        },

        # method: save medication recommendations
        save_results = function(results) {
            private$.data$data[[length(private$.data$data) + 1]] <- list(
                time = Sys.time(),
                id = "results",
                item = "medication recommendations",
                description = results
            )

            private$.write_data()
        },

        # method: save application errors
        save_error = function(error, message) {
            private$.data$meta$errors <- private$.data$meta$errors + 1
            private$.data$data[[length(private$.data$data) + 1]] <- list(
                time = Sys.time(),
                id = "errors",
                item = error,
                description = message
            )

            private$.write_data()
        },

        # method: on app restart
        save_restart = function() {
            private$.data$meta$restarts <- private$.data$meta$restarts + 1
            private$.data$data[[length(private$.data$data) + 1]] <- list(
                time = Sys.time(),
                id = "session",
                item = "app_restart",
                description = "user has clicked the restart button"
            )

            private$.write_data()
        },

        # method: when `session$onSessionEndend` is triggered
        save_session_end = function() {
            private$.data$ended <- Sys.time()
            private$.data$data[[length(private$.data$data) + 1]] <- list(
                time = Sys.time(),
                id = "session",
                item = "onSessionEnded",
                description = "session has ended"
            )

            private$.write_data()
        },

        # method: print internal data to console
        print = function() {
            print(private$.data)
        }

    ),

    # private methods
    private = list(
        .path = NA,
        .data = list(

            # basic information
            name = "iceApp",
            version = NA,
            session_id = NA,
            started = Sys.time(),
            ended = NA,

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
                se_submissions = 0
            ),

            # activity (i.e., session history)
            # all actions will be appended to to this list
            data = list(
                list(
                    time = Sys.time(),
                    id = "init",
                    item = "Analytics Module",
                    description = "new session started"
                )
            )
        ),

        # private method for saving data
        .write_data = function(data = private$.data, path = private$.path) {
            jsonlite::write_json(
                x = data,
                path = path,
                pretty = TRUE,
                auto_unbox = TRUE
            )
        }
    )
)