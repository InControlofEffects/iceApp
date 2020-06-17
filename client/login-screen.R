#'//////////////////////////////////////////////////////////////////////////////
#' FILE: login-screen.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-08-27
#' MODIFIED: 2020-06-15
#' PURPOSE: login screen for shiny app
#' PACKAGES: see global R
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
# build page
loginScreen <- function() {
    tags$div(class = "signin-screen",

        # logo
        tags$a(
            class = "brandlink",
            href = "https://incontrolofeffects.com",
            # tags$img(class = "logo", src = "images/Logo.svg"),
            appLogo(),
            tags$span("In Control of Effects")
        ),

        # form
        tags$form(id = "loginForm", class = "form",

            # content
            tags$legend("Welcome, please sign in."),

            # error message if access credentials are incorrect
            tags$span(id = "error-form", class = "error-text", role = "alert"),

            # username
            tags$label(`for` = "username", "Username"),
            tags$input(
                type = "text",
                id = "username",
                class = "form-control shiny-bound-input"
            ),
            tags$span(
                id = "error-username",
                class = "error-text",
                role = "alert"
            ),

            # password
            tags$label(`for` = "password", "Password"),
            tags$input(
                type = "password",
                id = "password",
                class = "form-control shiny-bound-input"
            ),
            tags$span(
                id = "error-password",
                class = "error-text",
                role = "alert"
            ),

            # buttons
            tags$button(
                id = "login",
                class = "action-button shiny-bound-input primary",
                type = "submit",
                "Sign In"
            )
        )
    )
}