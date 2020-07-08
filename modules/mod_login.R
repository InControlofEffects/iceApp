#'////////////////////////////////////////////////////////////////////////////
#' FILE: mod_login.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-27
#' MODIFIED: 2020-07-03
#' PURPOSE: module for login page
#' STATUS: working
#' PACKAGES: NA
#' COMMENTS:
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
#'////////////////////////////////////////////////////////////////////////////

#' ui component
#' @param id a unique ID for this instance of the login UI
#' @param class a css class to include in the rendering of the of UI
mod_login_ui <- function(id, class) {
    ns <- NS(id)

    # process css
    css <- "form"
    if (!is.null(class)) css <- paste0("form ", class)

    # define html
    tagList(
        tags$form(
            id = ns("page"),
            class = css,
            rheroicons::solid$user_circle(
                id = "signin-icon",
                aria_hidden = TRUE
            ),
            tags$h2(
                id = "signin-form-title",
                "Welcome, please sign in"
            ),
            tags$div(
                id = ns("signin-error"),
                class = "error-box browsertools-hidden",
                role = "alert",
                `aria-hidden` = "true",
                rheroicons::outline$exclamation(aria_hidden = TRUE),
                tags$span(
                    id = ns("signin-error-message"),
                    class = "error-box-text"
                )
            ),
            tags$label(`for` = ns("username"), "Username"),
            browsertools::hidden(
                tags$span(
                    id = "username-status",
                    class = "error-text"
                )
            ),
            tags$input(
                id = ns("username"),
                type = "text",
                class = "form-control shiny-bound-input"
            ),
            tags$label(`for` = ns("password"), "Password"),
            browsertools::hidden(
                tags$span(
                    id = "password-status",
                    class = "error-text"
                )
            ),
            tags$input(
                id = ns("password"),
                type = "password",
                class = "form-control shiny-bound-input"
            ),
            tags$button(
                id = ns("login"),
                class = "action-button shiny-bound-input primary",
                type = "submit",
                "Sign In"
            ),
            tags$p(
                id = "return-link",
                "Or return to the ",
                tags$a(
                    href = "https://incontrolofeffects.com",
                    "main"
                ),
                "site."
            )
        )
    )
}

#' login Server Function
#' @param id unique ID for an instance of a module
#' @param data an object containing the user accounts
#' @param logged a reactive object that manages the app logged in state
#' @param session_db a R6 object used for sending data to the database
mod_login_server <- function(id, data, logged, session_db) {
    moduleServer(
        id,
        function(input, output, session) {
            ns <- session$ns

            # build object containing namespace IDs (for use in js)
            elems <- list(
                error_elem = paste0("#", ns("signin-error")),
                error_text = paste0("#", ns("signin-error-message")),
                user_input = paste0("#", ns("username")),
                pass_input = paste0("#", ns("password")),
                user_status = "#username-status",
                password_status = "#password-status"
            )

            # reset signin form error messages
            reset_signin_errors <- function() {
                browsertools::inner_text(elems$error_text, "")
                browsertools::hide_elem(elems$error_elem)
                browsertools::hide_elem(elems$user_status)
                browsertools::hide_elem(elems$password_status)
                browsertools::remove_css(elems$user_input, "invalid")
                browsertools::remove_css(elems$pass_input, "invalid")
            }

            # send new message
            send_signin_error <- function(string, status, status_text) {
                browsertools::show_elem(elems$error_elem)
                browsertools::inner_text(elems$error_text, string)

                # show status messages for individual inputs or all of them
                if (status == "both") {

                    # make sure status elements are visisble
                    browsertools::show_elem(elems$user_status)
                    browsertools::show_elem(elems$password_status)

                    # modify inner text
                    browsertools::inner_text(elems$user_status, status_text)
                    browsertools::inner_text(elems$password_status, status_text)

                    # add invalid css class
                    browsertools::add_css(elems$user_input, "invalid")
                    browsertools::add_css(elems$pass_input, "invalid")
                }

                # show username invalid elements
                if (status == "username") {
                    browsertools::show_elem(elems$user_status)
                    browsertools::inner_text(elems$user_status, status_text)
                    browsertools::add_css(elems$user_input, "invalid")
                }

                # show password invalid elements
                if (status == "password") {
                    browsertools::show_elem(elems$password_status)
                    browsertools::inner_text(elems$password_status, status_text)
                    browsertools::add_css(elems$pass_input, "invalid")
                }
            }

            # on submit
            observeEvent(input$login, {

                # log click
                session_db$capture_click(
                    btn = "login",
                    desc = "login button clicked"
                )

                # reset existing errors (if applicable)
                reset_signin_errors()

                # find user and passwords
                usr <- which(data$username == input$username)

                # if there is no match for user
                if (input$username == "" && input$password == "") {

                    # send + log error
                    e <- "Username and password is missing"
                    session_db$capture_error("login", tolower(e))
                    send_signin_error(e, "both", "Missing")

                } else if (input$username == "" && !(input$password == "")) {

                    # send + log error
                    e <- "Username is missing"
                    session_db$capture_error("login", tolower(e))
                    send_signin_error(e, "username", "Missing")

                } else if (!(input$username == "") && input$password == "") {

                    # send + log error
                    e <- "Password is missing"
                    session_db$capture_error("login", tolower(e))
                    send_signin_error(e, "password", "Missing")

                } else if (!length(usr)) {

                    # send + log error
                    e <- "The username is incorrect"
                    session_db$capture_error("login", tolower(e))
                    send_signin_error(e, "username", "Incorrect")

                } else if (length(usr)) {
                    if (
                        sodium::password_verify(
                            hash = data$password[usr],
                            password = input$password
                        )
                    ) {

                        # reset and log
                        shiny::updateTextInput(session, "username", value = "")
                        shiny::updateTextInput(session, "password", value = "")

                        # login + capture event
                        session_db$capture_action(
                            event = "session",
                            id = "login",
                            desc = "user logged in successfully"
                        )
                        logged(TRUE)

                    } else {

                        # send + log error
                        e <- "The username or password is incorrect"
                        session_db$capture_error("login", tolower(e))
                        send_signin_error(e, "both", "Incorrect")
                    }
                } else {

                    # send and log error
                    e <- "An error has occurred. Please try again."
                    session_db$capture_error("login", tolower(e))
                    send_signin_error(e, "both", "Error")
                }
            })
        }
    )
}