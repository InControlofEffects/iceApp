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

    # load dependencies for UI packages
    browsertools::use_browsertools(),

    # application <head>
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
    uiOutput("app"),
    tags$script(src = "iceapp.min.js")
)
