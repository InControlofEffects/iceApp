#' Analytics R6 class
#'
#' @noRd
session_analytics <- R6::R6Class(
    "Analytics",
    public = list(
        initialize = function() {

            # set and create new analytics file
            path <- paste0(
                "logs/analytics_",
                format(Sys.time(), "%y_%m_%d_%H%M%S"),
                ".json"
            )
            file.create(path)

            # set internal public variables
            private$.path <- path
        },

        # save state when user is logged in
        save_login = function(username, usertype) {
            private$.data$username <- username
            private$.data$usertype <- usertype
            private$.data$logged <- TRUE
            private$.data$data[[length(private$.data$data) + 1]] <- list(
                time = Sys.time(),
                id = "login",
                item = "user logged in",
                description = paste0("the user is now signed in as ", username)
            )

            private$.write_data()
        },

        # save logout
        save_logout = function() {
            private$.data$logged <- FALSE
            private$.data$data[[length(private$.data$data) + 1]] <- list(
                time = Sys.time(),
                id = "logout",
                item = "user logout",
                description = "the user is now logged out"
            )

            private$.write_data()
        },

        # log button clicks
        save_click = function(btn, description) {
            private$.data$data[[length(private$.data$data) + 1]] <- list(
                time = Sys.time(),
                id = "btn_click",
                item = btn,
                description = description
            )

            private$.write_data()
        },

        # log user selections
        save_selections = function(selections) {
            private$.data$data[[length(private$.data$data) + 1]] <- list(
                time = Sys.time(),
                id = "selections",
                item = "side effect selections",
                description = selections
            )

            private$.write_data()
        },

        # log results
        save_results = function(results) {
            private$.data$data[[length(private$.data$data) + 1]] <- list(
                time = Sys.time(),
                id = "results",
                item = "medication recommendations",
                description = results
            )

            private$.write_data()
        },

        # log errors
        save_error = function(error, message) {
            private$.data$data[[length(private$.data$data) + 1]] <- list(
                time = Sys.time(),
                id = "errors",
                item = error,
                description = message
            )

            private$.write_data()
        },

        # on session end
        save_session_end = function() {
            private$.data$data[[length(private$.data$data) + 1]] <- list(
                time = Sys.time(),
                id = "session",
                item = "session ended",
                description = "the app has stopped"
            )

            private$.write_data()
        },

        # print data
        print = function(data = private$.data) {
            print(data)
        }

    ),
    private = list(
        .path = NA,
        .data = list(
            name = "iceApp_analytics",
            description = "analytics for the In Control of Effects webapp",
            username = NA,
            usertype = NA,
            logged = FALSE,
            data = list(
                list(
                    time = Sys.time(),
                    id = "init",
                    item = "Analytics Module",
                    description = "new session started"
                )
            )
        ),
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