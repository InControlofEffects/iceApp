#'//////////////////////////////////////////////////////////////////////////////
#' FILE: index.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-08-29
#' MODIFIED: 2020-01-27
#' PURPOSE: generic R template for rendering UI based on login status
#' PACKAGES: *see global*
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
# main app
app <- function() {
    tagList(
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
                        tags$img(
                            class = "logo",
                            src = "images/Logo.svg",
                            alt = "in control of effects"
                        ),
                        "In Control of Effects"
                    )
                ),
                tags$li(class = "menu-item",
                    tags$button(
                        id = "restart",
                        class = "action-button shiny-bound-input",
                        title = "Restart",
                        `aria-label` = "restart application",
                        HTML(icons$restart)
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
                `aria-valuemax` = "100",
                `aria-valuetext` = ""
            )
        ),
        tags$main(class = "main", id = "main",
            uiOutput("current_page")
        )
    )
}