#' login UI Function
#'
#' @description A shiny Module.
#' @param id,input,output,session Internal parameters for {shiny}.
#' @importFrom shiny NS tagList
#' @noRd
mod_login_ui <- function(id, class) {
    ns <- NS(id)

    # process css
    css <- "form"
    if (!is.null(class)) css <- paste0("form ", class)

    # define html
    tagList(
        tags$form(
            id = ns("signin"),
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
            )
        ),
        tags$p(
            id = "return-link",
            "Or return to the ", tags$a(href = "#", "main"), "site."
        )
    )
}

#' login Server Function
#' @param data object containing the users dataset
#' @param logged reactive val that managages the "authorized" state of the app
#' @noRd
mod_login_server <- function(input, output, session, data, logged) {
    ns <- session$ns

    # reset signin form error messages
    reset_signin_errors <- function() {
        browsertools::inner_text("#signin-form-error-message", "")
        browsertools::hide_elem("#signin-form-error")
        browsertools::remove_css("#username", "invalid")
        browsertools::remove_css("#password", "invalid")
    }

    # send new message
    send_signin_error <- function(string) {
        browsertools::show_elem("#signin-form-error")
        browsertools::inner_text("#signin-form-error-message", string)
    }

    # on submit
    observeEvent(input$login, {

        # reset existing errors (if applicable)
        reset_signin_errors()

        # find user and passwords
        usr <- which(data$username == input$username)

        # if there is no match for user
        if (!length(user)) {
            send_signin_error("The username is incorrect")
            browsertools::add_css("#username", "invalid")
        } else if (input$username == "") {
            send_signin_error("Username is missing")
            browsertools::add_css("#username", "invalid")
        } else if (input$password == "") {
            send_signin_error("Password is missing")
            browsertools::add_css("#password", "invalid")
        } else if (input$password = "" && input$username = "") {
            send_signin_error("Username and password is missing")
            browsertools::add_css("#username", "invalid")
            browsertools::add_css("#password", "invalid")
        } else if (length(usr)) {
            if (sodium::password_verify(data$password[usr], input$password)) {
                shiny::updateTextInput(session, "username", value = "")
                shiny::updateTextInput(session, "password", value = "")
                logged(TRUE)
            } else {
                send_signin_error("The username or password is incorrect")
            }
        } else {
            send_signin_error("An error has occurred. Please try again.")
        }
    })
}

## To be copied in the UI
# mod_login_ui("login_ui_1")

## To be copied in the server
# callModule(mod_login_server, "login_ui_1")