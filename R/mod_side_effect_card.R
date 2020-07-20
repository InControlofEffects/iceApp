#'////////////////////////////////////////////////////////////////////////////
#' FILE: mod_side_effect_card.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-27
#' MODIFIED: 2020-07-03
#' PURPOSE: side effects card component + server module
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' mode_side_effect_ui
#' Create an accordion component with collapsible content
#' @param id a unique ID for the component
#' @param title a title for the card
#' @param text content to be placed inside the collapsible section
mod_side_effect_ui <- function(id, title, text) {
  ns <- NS(id)
  tags$div(
        id = ns("sideEffects"),
        class = "card side-effects",
        tags$label(
            class = "card-input",
            tags$input(
                type = "checkbox",
                class = "checkboxes",
                id = ns("checked")
            ),
            tags$span(title)
        ),
        tags$button(
            class = "action-button shiny-bound-input card-toggle",
            id = ns("toggle"),
            `aria-expanded` = "false",
            rheroicons::outline$chevron_down()
        ),
        tags$section(
            id = ns("content"),
            class = "card-content",
            `aria-hidden` = "true",
            tags$p(text)
        )
    )
}
    
#' mod_se_server
#' @param id unique ID for this module
#' @param session_db an R6 object used for sending data to the db
mod_se_server <- function(id, session_db) {
    moduleServer(
        id,
        function(input, output, session) {

            # parse module ID
            ns <- session$ns
            id <- gsub(
                pattern = "-<environment>",
                replacement = "",
                x = ns(input)[[1]]
            )

            # toggle classes when checkbox selected
            observeEvent(input$checked, {
                if (input$checked) {
                    # add selected css class
                    browsertools::add_css(
                        elem = paste0("#", id, "-sideEffects"),
                        css = "selected"
                    )
                    # log selection (log selections, but do worry about
                    # deselection at this point as there are unwanted
                    # side effects using reactive values that reset inputs
                    # For now, log user selections as these can be compared
                    # with the final selected input
                    session_db$capture_action(
                        event = "side_effect_selection",
                        id = id,
                        desc = "user selected side effect"
                    )
                } else {
                    # remove selected css class
                    browsertools::remove_css(
                        elem = paste0("#", id, "-sideEffects"),
                        css = "selected"
                    )
                    # log removal: keep this here until there is a solution
                    #' session_db$capture_action(
                    #'     event = "side_effect_selection",
                    #'     id = id,
                    #'     desc = "user deselected side effect"
                    #' )
                }
            })

             # toggle expandable content
            isOpen <- reactiveVal(FALSE)
            observeEvent(input$toggle, {

                # toggle class
                browsertools::toggle_css(
                    elem = paste0("#", id, "-toggle"),
                    css = "rotated"
                )

                # toggle hidden content
                browsertools::toggle_css(
                    elem = paste0("#", id, "-content"),
                    css = "expanded"
                )

                # toggle hidden aria
                if (isOpen()) {
                    browsertools::set_element_attribute(
                        elem = paste0("#", id, "-content"),
                        attr = "aria-hidden",
                        value = "true"
                    )
                    browsertools::set_element_attribute(
                        elem = paste0("#", id, "-toggle"),
                        attr = "aria-expanded",
                        value = "false"
                    )
                    isOpen(FALSE)
                } else {
                    browsertools::remove_element_attribute(
                        elem = paste0("#", id, "-content"),
                        attr = "aria-hidden"
                    )
                    browsertools::set_element_attribute(
                        elem = paste0("#", id, "-toggle"),
                        attr = "aria-expanded",
                        value = "true"
                    )
                    isOpen(TRUE)
                }

                # log action
                session_db$capture_action(
                    event = "side_effect_definition",
                    id  = id,
                    desc = "user toggled definition"
                )
            }, ignoreInit = TRUE)
        }
    )
}