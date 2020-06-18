#'//////////////////////////////////////////////////////////////////////////////
#' FILE: login-screen.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-08-27
#' MODIFIED: 2020-06-18
#' PURPOSE: login screen for shiny app
#' PACKAGES: see global R
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
# build page
loginScreen <- function() {
    tags$div(
        id = "signin-page",
        class = "full-width-page filled-page-background",
        tags$div(
            class = "inner-page",
            tags$form(
                id = "signin-form",
                class = "form",
                rheroicons::solid$user_circle(
                    aria_hidden = TRUE,
                    id = "signin-icon"
                ),
                tags$h2(
                    id = "signin-form-title",
                    "Welcome, please sign in"
                ),
                tags$div(
                    class = "error-box browsertools-hidden",
                    id = "signin-form-error",
                    role = "alert",
                    `aria-hidden` = "true",
                    rheroicons::outline$exclamation(aria_hidden = TRUE),
                    tags$span(
                        id = "signin-form-error-message",
                        class = "error-box-text"
                    )
                ),
                tags$label(`for` = "username", "Username"),
                tags$input(
                    type = "text",
                    id = "username",
                    class = "form-control shiny-bound-input"
                ),
                tags$div(
                    class = "error-box browsertools-hidden",
                    id = "signin-form-username-error",
                    role = "alert",
                    `aria-hidden` = "true",
                    rheroicons::outline$exclamation(aria_hidden = TRUE),
                    tags$span(
                        id = "signin-form-username-error-message",
                        class = "error-box-text"
                    )
                ),
                tags$label(`for` = "password", "Password"),
                tags$input(
                    type = "password",
                    id = "password",
                    class = "form-control shiny-bound-input"
                ),
                tags$div(
                    class = "error-box browsertools-hidden",
                    id = "signin-form-password-error",
                    role = "alert",
                    `aria-hidden` = "true",
                    rheroicons::outline$exclamation(aria_hidden = TRUE),
                    tags$span(
                        id = "signin-form-password-error-message",
                        class = "error-box-text"
                    )
                ),
                tags$button(
                    id = "login",
                    class = "action-button shiny-bound-input primary",
                    type = "submit",
                    "Sign In"
                )
            ),
            tags$p(
                id = "return-link",
                "Or return to the ",
                tags$a(
                    href = "#",
                    "main"
                ),
                "site."
            )
        )
    )
}