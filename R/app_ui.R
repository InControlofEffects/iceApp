#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
    tagList(
        golem_helmet(),
        tags$a(
            class = "screen-reader-content",
            href = "#main",
            "skip to main content"
        ),
        tags$nav(
            class = "navbar",
            tags$ul(
                class = "menu",
                tags$li(
                    class = "menu-item brand-item",
                    tags$h1(
                        class = "menu-title",
                        appLogo(),
                        "In Control of Effects"
                    )
                ),
                tags$li(
                    class = "menu-item menu-toggle",
                    tags$button(
                        id = "menuToggle",
                        class = "action-button shiny-bound-input",
                        `aria-expanded` = "false",
                        tags$span("menu"),
                        rheroicons::outline$dots_vertical(aria_hidden = TRUE)
                    )
                )
            )
        ),
        tags$figure(
            id = "bar-container",
            class = "progressBar",
            tags$figcaption(class = "screen-reader-text", "Progress bar"),
            tags$div(
                id = "bar",
                class = "bar",
                role = "progressbar",
                `aria-valuenow` = "0",
                `aria-valuemin` = "0",
                `aria-valuemax` = "1",
                `aria-valuetext` = ""
            )
        ),
        tags$aside(
            id = "sidebar",
            class = "sidebar",
            `aria-labelledby` = "sidebar-title",
            `aria-hidden` = "true",
            tags$div(
                class = "sidebar-content",
                tags$span(
                    id = "sidebar-title",
                    class = "browsertools-hidden",
                    "application menu"
                ),
                tags$ul(
                    class = "menu",
                    tags$li(
                        class = "menu-item",
                        tags$button(
                            id = "restart",
                            class = "action-button shiny-bound-input",
                            rheroicons::outline$refresh(aria_hidden = TRUE),
                            tags$span("restart")
                        )
                    ),
                    tags$li(
                        class = "menu-item",
                        tags$button(
                            id = "logout",
                            class = "action-button shiny-bound-input",
                            rheroicons::outline$logout(aria_hidden = TRUE),
                            tags$span("sign out")
                        )
                    )
                ),
                tags$p(
                    "Return to",
                    tags$a(
                        id = "quit-link",
                        class = "shiny-bound-input action-link",
                        href = "https://incontrolofeffects.com",
                        "main site."
                    )
                )
            )
        ),
        tags$main(
            class = "main", id = "main",
            uiOutput("current_page")
        ),
        golem_footer()
    )
}

#' Define Shiny Helmet
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @importFrom browsertools use_browsertools
#' @noRd
golem_helmet <- function() {

    # set path
    add_resource_path("www", app_sys("app/www"))

    # define head
    tags$head(
        tags$meta(charset = "utf-8"),
        tags$meta(`http-quiv` = "x-ua-compatible", content = "ie=edge"),
        tags$meta(
            name = "viewport",
            content = "width=device-width, initial-scale=1"
        ),
        tags$meta(
            name = "description",
            content = "A decision aid for the choice of antipsychotics"
        ),
        tags$link(
            rel = "apple-touch-icon",
            sizes = "180x180",
            href = "www/apple-touch-icon.png"
        ),
        tags$link(
            rel = "icon",
            type = "image/png",
            sizes = "32x32",
            href = "www/favicon-32x32.png"
        ),
        tags$link(
            rel = "icon",
            type = "image/png",
            sizes = "16x16",
            href = "www/favicon-16x16.png"
        ),
        tags$link(
            rel = "manifest",
            href = "www/site.webmanifest"
        ),
        tags$link(
            rel = "stylesheet",
            type = "text/css",
            href = "www/ice.min.css"
        ),
        use_browsertools(),
        tags$title("In Control of Effects")
    )
}

#' Add Static Assets to Application
#'
#' This function loads all JS assets
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js
#' @noRd
golem_footer <- function() {

    # set path
    add_resource_path("www", app_sys("app/www"))

    # define resources
    tagList(
        tags$script(src = "www/ice.min.js")
    )
}