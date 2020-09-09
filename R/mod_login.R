#' Login Screen
#'
#' @description
#' This script provides two modules: the login UI and the login Server
#' The UI component renders form with the two input elements for username and
#' password. A back to main page link is also provided.
#'
#' The server logic runs only when the submit button is clicked. When clicked,
#' a series of server-side form validation is executed. If there are any
#' errors, a message is sent to the client and the error is added to the
#' database. When all errors are eliminated and the user has provided valid
#' credentials, then the app state is changed (i.e., logged in) and the state
#' is noted in the database.
#'
#' @param id a unique ID for this instance of the login UI
#' @param class a css class to include in the rendering of the of UI
#'
#' @importFrom shiny tags tag NS
#' @noRd
mod_login_ui <- function(id, class = NULL) {
    ns <- NS(id)

    # process css
    css <- "form login__form"
    if (!is.null(class)) css <- paste0("form ", class)

    # define html
    tagList(
        tags$form(
            id = ns("page"),
            class = css,
            tags$h1("Welcome"),
            tags$p(
                "Please sign in using the details provided to you by the",
                "study coordinator."
            ),
            iceComponents::input(
                inputId = ns("username"),
                label = "Username",
                type = "text",
                icon = rheroicons::rheroicon(name = "user_circle")
            ),
            iceComponents::input(
                inputId = ns("password"),
                label = "Password",
                type = "password",
                icon = rheroicons::rheroicon(name = "lock_closed")
            ),
            tags$button(
                id = ns("login"),
                class = "action-button shiny-bound-input primary",
                type = "submit",
                "Sign In"
            )
        )
    )
}

#' login Server Function
#'
#' @param id unique ID for an instance of a module
#' @param data an object containing the user accounts
#' @param logged a reactive object that manages the app logged in state
#' @param analytics a session specific analytics module
#'
#' @importFrom sodium password_verify
#' @noRd
mod_login_server <- function(id, data, logged, analytics) {
    moduleServer(
        id,
        function(input, output, session) {
            ns <- session$ns

            result <- reactiveValues(
                status = FALSE,
                username = NA,
                usertype = NA
            )

            # on submit
            observeEvent(input$login, {
                iceComponents::clear_input(inputId = "username")
                iceComponents::clear_input(inputId = "password")

                # save data
                analytics$save_click(
                    btn = "login",
                    description = "login form data submitted"
                )

                # find user and passwords
                usr <- which(data$username == input$username)

                # if there is no match for user
                if (input$username == "" & input$password == "") {

                    # send + log error
                    iceComponents::invalidate_input(
                        inputId = "username",
                        error = "Username is missing"
                    )

                    iceComponents::invalidate_input(
                        inputId = "password",
                        error = "Password is missing"
                    )

                    # log error
                    analytics$save_error(
                        error = "login_form",
                        message = "username and password is missing"
                    )

                } else if (input$username == "" & !input$password == "") {

                    # send + log error
                    iceComponents::invalidate_input(
                        inputId = "username",
                        error = "Username is missing"
                    )

                    analytics$save_error(
                        error = "login_form",
                        message = "username is missing"
                    )

                } else if (!input$username == "" & input$password == "") {

                    # send + log error
                    iceComponents::invalidate_input(
                        inputId = "password",
                        error = "Password is missing"
                    )

                    analytics$save_error(
                        error = "login_form",
                        message = "password is missing"
                    )

                } else if (!length(usr)) {

                    # send + log error
                    iceComponents::invalidate_input(
                        inputId = "username",
                        error = "Username is incorrect"
                    )

                    analytics$save_error(
                        error = "login_form",
                        message = "username is incorrect"
                    )

                } else if (length(usr)) {
                    if (
                        sodium::password_verify(
                            hash = data$password[usr],
                            password = input$password
                        )
                    ) {

                        # reset and log
                        iceComponents::reset_input(inputId = "username")
                        iceComponents::reset_input(inputId = "password")

                        analytics$save_login(
                            username = data$username[usr],
                            usertype = data$type[usr]
                        )

                        # change state
                        logged(TRUE)

                        result$status <- TRUE
                        result$username <- data$username[usr]
                        result$usertype <- data$type[usr]

                    } else {

                        # send + log error
                        iceComponents::invalidate_input(
                            inputId = "password",
                            error = "Password is incorrect"
                        )

                        analytics$save_error(
                            error = "login_form",
                            message = "password is incorrect"
                        )
                    }
                } else {

                    # send and log error
                    iceComponents::invalidate_input(
                        inputId = "username",
                        error = "Something went wrong"
                    )
                    iceComponents::invalidate_input(
                        inputId = "password",
                        error = "Something went wrong"
                    )
                    analytics$save_error(
                        error = "login_form",
                        message = "something went wrong"
                    )
                }
            })

            return(result)
        }
    )
}