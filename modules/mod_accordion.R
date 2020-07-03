#'////////////////////////////////////////////////////////////////////////////
#' FILE: mod_accordion.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-07-03
#' MODIFIED: 2020-07-03
#' PURPOSE: accordion input
#' STATUS: in.progress
#' PACKAGES: Shiny
#' COMMENTS: See custom input binding
#'////////////////////////////////////////////////////////////////////////////

#' mod_accordion_ui
#' Create an accordion element that allows you to open/close a "hidden"
#' section
#' @param id a unique id for this instance of the accordion component
#' @param title a title for the accordion component
#' @param content a Shiny Tag element or tagList
mod_accordion_ui <- function(id, title, content) {

    # define ID and groupID
    ns <- NS(id)
    groupID <- ns("accordion")

    # define UI
    tagList(
        tags$h3(
            id = ns("accordion-title"),
            class = "accordion-title",
            `data-group` = groupID,
            tags$button(
                id = ns("toggle"),
                class = "accordion-toggle",
                `data-group` = groupID,
                `aria-expanded` = "false",
                tags$span(title),
                rheroicons::outline$chevron_down(
                    class = "accordion-toggle-icon",
                    aria_hidden = TRUE
                )
            )
        ),
        tags$section(
            `aria-labelledby` = ns("accordion-title"),
            `data-group` = groupID,
            `aria-hidden` = "true",
            class = "accordion-section",
            content
        )
    )
}

#' mod_accordion_server
#' Backend for accordion component
#' @param id a unique ID of a specific instance of the accordion component
#' @param session_db an R6 object for logging data to the database
mod_accordion_server <- function(id, session_db) {
    moduleServer(
        id,
        function(input, output, session) {
            ns <- session$ns
            id <- gsub("-<environment>", "", ns(input)[[1]])
            observeEvent(input$toggle, {
                session_db$capture_click(
                    btn = paste0("accordion_", id),
                    desc = "accordion toggled"
                )
            })
        }
    )
}