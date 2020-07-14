#'////////////////////////////////////////////////////////////////////////////
#' FILE: mod_login.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-27
#' MODIFIED: 2020-07-14
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
            tag(
                `_tag_name` = "svg",
                list(
                    class = "logo",
                    width = "45",
                    height = "44",
                    viewBox = "0 0 45 44",
                    version = "1.1",
                    xmlns = "http://www.w3.org/2000/svg",
                    `xmlns:xlink` = "http://www.w3.org/1999/xlink",
                    `aria_hidden` = "true",
                    tag(
                        `_tag_name` = "g",
                        list(
                            stroke = "none",
                            `stroke-width` = "1",
                            fill = "none",
                            `fill-rule` = "evenodd",
                            tag(
                                `_tag_name` = "circle",
                                list(
                                    fill = "#4655A8",
                                    cx = "15",
                                    cy = "15",
                                    r = "15"
                                )
                            ),
                            tag(
                                `_tag_name` = "circle",
                                list(
                                    fill = "#C7CCE4",
                                    cx = "30",
                                    cy = "29",
                                    r = "15"
                                )
                            )
                        )
                    )
                )
            ),
            tags$legend(
                id = "signin-form-title",
                "Sign in"
            ),

            #'//////////////////////////////////////

            #' Username: label, input, error
            tags$label(`for` = ns("username"), "Username"),
            tags$span(
                id = "username-status",
                class = "error-text",
                role = "alert"
            ),
            tags$input(
                id = ns("username"),
                type = "text",
                class = "form-control shiny-bound-input",
                `aria-describedby` = "username-status"
            ),

            #'//////////////////////////////////////

            #' Password: label, input, error
            tags$label(`for` = ns("password"), "Password"),
            tags$span(
                id = "password-status",
                class = "error-text",
                role = "alert"
            ),
            tags$input(
                id = ns("password"),
                type = "password",
                class = "form-control shiny-bound-input",
                `aria-describedby` = "password-status"
            ),

            # form submit
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
                user_input = ns("username"),
                pass_input = ns("password")
            )

            # reset signin form error messages
            reset_form <- function(elem = "signin-form-page") {
                session$sendCustomMessage("reset_form", list(elem = elem))
            }

            # send new message
            show_error <- function(elem, error) {
                session$sendCustomMessage(
                    "show_error",
                    list(elem = elem, error = error)
                )
            }

            # on submit
            observeEvent(input$login, {

                # log click
                session_db$capture_click(
                    btn = "login",
                    desc = "login button clicked"
                )

                # reset existing errors (if applicable)
                reset_form()

                # find user and passwords
                usr <- which(data$username == input$username)

                # if there is no match for user
                if (input$username == "" && input$password == "") {

                    # send + log error
                    e <- "Username and password is missing"
                    session_db$capture_error("login", tolower(e))
                    show_error(elems$user_input, "ERROR: Username is missing")
                    show_error(elems$pass_input, "ERROR: Password is missing")

                } else if (input$username == "" && !(input$password == "")) {

                    # send + log error
                    e <- "Username is missing"
                    session_db$capture_error("login", tolower(e))
                    show_error(elems$user_input, "ERROR: Username is missing")

                } else if (!(input$username == "") && input$password == "") {

                    # send + log error
                    e <- "Password is missing"
                    session_db$capture_error("login", tolower(e))
                    show_error(elems$pass_input, "ERROR: Password is missing")

                } else if (!length(usr)) {

                    # send + log error
                    e <- "The username is incorrect"
                    session_db$capture_error("login", tolower(e))
                    show_error(elems$user_input, "ERROR: Username is incorrect")

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

                        # update user type in sessions table
                        type <- data$type[usr]
                        session_db$capture_login(type = type)

                        # change state
                        logged(TRUE)

                    } else {

                        # send + log error
                        e <- "The username or password is incorrect"
                        session_db$capture_error("login", tolower(e))
                        show_error(
                            elems$pass_input,
                            "ERROR: Password is incorrect"
                        )
                    }
                } else {

                    # send and log error
                    e <- "An error has occurred. Please try again."
                    session_db$capture_error("login", tolower(e))
                    show_error(elems$user_input, "ERROR: Something went wrong")
                    show_error(elems$pass_input, "ERROR: Something went wrong")
                }
            })
        }
    )
}