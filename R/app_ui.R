#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
    tagList(
        golem_helmet(),
        iceComponents::set_doc_attribs(),
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
                    tags$a(
                        class = "menu-link",
                        href = "https://incontrolofeffects.com",
                        app__logo(),
                        "In Control of Effects"
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
                        rheroicons::rheroicon(
                            name = "refresh",
                            type = "outline",
                            class = "menu-button-icon"
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
                        rheroicons::rheroicon(
                            name = "logout",
                            type = "outline",
                            class = "menu-button-icon"
                        ),
                        tags$span(
                            class = "menu-button-label",
                            "Sign out"
                        )
                    )
                )
            )
        ),
        browsertools::hidden(
            appProgress$bar(
                inputId = "appProgress",
                fill = "#4755a9",
                fixed = TRUE,
                text = "page {value} of {max}",
                yOffset = "56px"
            )
        ),
        iceComponents::container(
            uiOutput("current_page")
        ),
        tags$div(
            id = "selection-error",
            class = "status-box",
            rheroicons::rheroicon(name = "x_circle"),
            tags$p("Oops, only one selection allowed.")
        ),
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
            href = "www/incontrolofeffectsapp.min.css"
        ),
        tags$title("In Control of Effects"),

        # load dependencies
        iceComponents::use_iceComponents(),
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
        tags$script(src = "www/incontrolofeffectsapp.min.js")
    )

}