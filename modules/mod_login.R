#'////////////////////////////////////////////////////////////////////////////
#' FILE: mod_login.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-27
#' MODIFIED: 2020-06-27
#' PURPOSE: module for login page
#' STATUS: working
#' PACKAGES: NA
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

# ui component
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
            tags$input(
                id = ns("username"),
                type = "text",
                class = "form-control shiny-bound-input"
            ),
            tags$label(`for` = ns("password"), "Password"),
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
                "Or return to the ", tags$a(href = "#", "main"), "site."
            )
        )
    )
}

#' login Server Function
mod_login_server <- function(input, output, session, data, logged, session_data) {
    ns <- session$ns

    # build object containing namespace IDs (for use in js)
    elems <- list(
        error_elem = paste0("#", ns("signin-error")),
        error_text = paste0("#", ns("signin-error-message")),
        user_input = paste0("#", ns("username")),
        pass_input = paste0("#", ns("password"))
    )

    # reset signin form error messages
    reset_signin_errors <- function() {
        browsertools::inner_text(elems$error_text, "")
        browsertools::hide_elem(elems$error_elem)
        browsertools::remove_css(elems$user_input, "invalid")
        browsertools::remove_css(elems$pass_input, "invalid")
    }

    # send new message
    send_signin_error <- function(string) {
        browsertools::show_elem(elems$error_elem)
        browsertools::inner_text(elems$error_text, string)
    }

    # on submit
    observeEvent(input$login, {

        # log click

        # reset existing errors (if applicable)
        reset_signin_errors()

        # find user and passwords
        usr <- which(data$username == input$username)

        # if there is no match for user
        if (input$username == "" && input$password == "") {

            # send + log error
            send_signin_error("Username and password is missing")

        } else if (input$username == "" && !(input$password == "")) {

            # send + log error
            send_signin_error("Username is missing")
            browsertools::add_css(elems$user_input, "invalid")

        } else if (!(input$username == "") && input$password == "") {

            # send + log error
            send_signin_error("Password is missing")
            browsertools::add_css(elems$pass_input, "invalid")

        } else if (!length(usr)) {

            # send + log error
            send_signin_error("The username is incorrect")
            browsertools::add_css(elems$user_input, "invalid")

        } else if (length(usr)) {
            if (sodium::password_verify(data$password[usr], input$password)) {

                # reset + log
                shiny::updateTextInput(session, "username", value = "")
                shiny::updateTextInput(session, "password", value = "")

                # login
                logged(TRUE)

            } else {

                # send + log error
                send_signin_error("The username or password is incorrect")
            }
        } else {

            # send and log error
            send_signin_error("An error has occurred. Please try again.")
        }
    })
}