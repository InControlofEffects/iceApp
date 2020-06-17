#'//////////////////////////////////////////////////////////////////////////////
#' FILE: ui.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-09-09
#' MODIFIED: 2020-06-04
#' PURPOSE: client for in control of effects application
#' STATUS: in.progress
#' PACKAGES: see global
#' COMMENTS: the UI is rendered server-side
#'//////////////////////////////////////////////////////////////////////////////
# UI
ui <- tagList(
    browsertools::use_browsertools(),
    singleton(
        tags$head(lang = "en",
            tags$meta(charset = "utf-8"),
            tags$meta(`http-equiv` = "X-UA-Compatible", content = "IE=edge"),
            tags$meta(
                name = "viewport",
                content = "width=device-width, initial-scale=1"
            ),
            tags$link(
                rel = "apple-touch-icon",
                sizes = "180x180",
                href = "apple-touch-icon.png"
            ),
            tags$link(
                rel = "icon",
                type = "image/png",
                sizes = "32x32",
                href = "favicon-32x32.png"
            ),
            tags$link(
                rel = "icon",
                type = "image/png",
                sizes = "16x16",
                href = "favicon-16x16.png"
            ),
            tags$link(
                rel = "manifest",
                href = "site.webmanifest"
            ),
            tags$link(
                rel = "stylesheet",
                type = "text/css",
                href = "iceapp.min.css"
            ),
            tags$title("In Control of Effects")
        )
    ),
    tags$a(
        class = "screen-reader-content",
        href = "#main",
        "skip to main content"
    ),
    tags$nav(class = "navbar",
        tags$ul(class = "menu",
            tags$li(class = "menu-item brand-item",
                tags$a(
                    class = "menu-link",
                    href = "https://incontrolofeffects.com",
                    appLogo(),
                    "In Control of Effects"
                )
            ),
            tags$li(class = "menu-item",
                tags$button(
                    id = "restart",
                    class = "action-button shiny-bound-input",
                    title = "Restart",
                    tags$span(
                        class = "screen-reader-text",
                        "restart the application"
                    ),
                    rheroicons::outline$refresh(aria_hidden = TRUE)
                )
            )
        )
    ),
    tags$figure(class = "progressBar",
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
    tags$main(class = "main", id = "main",
        uiOutput("current_page")
    ),
    tags$script(src = "iceapp.min.js")
)
