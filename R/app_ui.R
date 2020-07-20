#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
    tagList(
        golem_helmet(),
        tags$nav(
            class = "navbar",
            `aria-label` = "in control of effects",
            tags$ul(
                class = "menu",
                role = "menu",
                tags$li(
                    id = "item-brand-link",
                    role = "none",
                    class = "menu-item",
                    tags$h1(
                        role = "menu-item",
                        tags$a(
                            class = "menu-link",
                            href = "https://incontrolofeffects.com",
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
                            "In Control of Effects"
                        )
                    )
                ),
                tags$li(
                    id = "item-restart-app",
                    role = "none",
                    class = "menu-item item-hidden",
                    tags$button(
                        role = "menuitem",
                        id = "appRestart",
                        class = "action-button shiny-bound-input menu-button",
                        rheroicons::outline$refresh(
                            class = "menu-button-icon",
                            aria_hidden = TRUE
                        ),
                        tags$span(
                            class = "menu-button-label",
                            "Restart"
                        )
                    )
                ),
                tags$li(
                    id = "item-signout-app",
                    role = "none",
                    class = "menu-item item-hidden",
                    tags$button(
                        id = "appSignout",
                        role = "menuitem",
                        class = "action-button shiny-bound-input menu-button",
                        rheroicons::outline$logout(
                            class = "menu-button-icon",
                            aria_hidden = TRUE
                        ),
                        tags$span(
                            class = "menu-button-label",
                            "Sign out"
                        )
                    )
                )
            )
        ),
        tags$figure(
            id = "bar-container",
            class = "progressBar",
            tags$figcaption(class = "browsertools-hidden", "Progress bar"),
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
        tags$main(class = "main", id = "main", uiOutput("current_page")),
        golem_js_assets()
    )
}

#' Define the header content for the application
#'
#' This function is internally used to declare document meta content and to
#' load static assets.
#'
#' @import shiny
#' @importFrom golem add_resource_path
#' @importFrom browsertools use_browsertools
#' @noRd
golem_helmet <- function() {

    # set resource path
    add_resource_path(
        "www", app_sys("app/www")
    )

    # define meta content
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
        tags$title("In Control of Effects"),
        browsertools::use_browsertools()
    )
}

#' Add Static Assets
#'
#' This is an internal function used to load static assets (i.e., external
#' JavaScript)
#'
#' @import shiny
#' @importFrom golem add_resource_path
#' @noRd
golem_js_assets <- function() {

    # define system path of static files
    add_resource_path(
        "www", app_sys("app/www")
    )

    # load static assets
    tagList(
        tags$script(src = "www/ice.min.js")
    )

}