#' ////////////////////////////////////////////////////////////////////////////
#' FILE: ui.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-27
#' MODIFIED: 2020-07-08
#' PURPOSE: Shiny UI
#' STATUS: in.progreess
#' PACKAGES: see global
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////
ui <- tagList(
    browsertools::use_browsertools(),
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
            href = "ice.min.css"
        ),
        tags$title("In Control of Effects")
    ),
    tags$a(
        class = "browsertools-hidden",
        href = "#main",
        "skip to main content"
    ),
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
                    role = "menu-item",
                    class = "menu-link",
                    tabindex = "0",
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
            ),
            tags$li(
                id = "item-restart-app",
                role = "none",
                class = "menu-item",
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
                class = "menu-item",
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
    tags$script(src = "ice.min.js")
)