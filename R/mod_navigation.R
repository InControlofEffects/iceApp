#' navigation UI Function
#'
#' @description A shiny Module.
#' @param id,input,output,session Internal parameters for {shiny}.
#' @importFrom shiny NS tags
#' @importFrom rheroicons outline
#' @importFrom browsertools hidden
#' @noRd
mod_navigation_ui <- function(id, buttons) {
    ns <- NS(id)

    # define buttons
    btns <- list(
        previous = tags$button(
            id = ns("previousPage"),
            class = "shiny-bound-input action-button default",
            outline$chevron_left(aria_hidden = TRUE),
            "Previous"
        ),
        "next" = tags$button(
            id = ns("nextPage"),
            class = "shiny-bound-input action-button primary",
            "Next",
            outline$chevron_right(aria_hidden = TRUE)
        ),
        submit = tags$button(
            id = ns("submitEffects"),
            class = "shiny-bound-input action-button primary",
            "Submit",
            outline$arrow_circle_right(aria_hidden = TRUE)
        ),
        restart = tags$button(
            id = ns("restartApp"),
            class = "shiny-bound-input action-button primary",
            "Restart",
            rheroicons::outline$refresh(aria_hidden = TRUE)
        ),
        quit = tags$button(
            id = ns("quitApp"),
            class = "shiny-bound-input action-button primary",
            rheroicons::outline$logout(aria_hidden = TRUE),
            "Quit"
        )
    )

    # define wrapper
    parent <- tags$div(id = ns("nav"), class = "navigation-wrapper")

    # validate and add buttons
    valid <- match(buttons, names(btns))
    btns <- lapply(seq_len(length(valid)), function(i) {
        tags$li(class = "navigation-item", btns[valid[i]])
    })
    el <- tags$ul(btns)

    # add class
    if (length(valid) == 1) {
        el$attribs$class <- "navigation-button-list single-button-list"
    } else {
        el$attribs$class <- "navigation-button-list multi-button-list"
    }

    # return
    parent$children <- el
    return(parent)

}

#' navigation Server Function
#' @importFrom browsertools show_elem hide_elem
#' @noRd
mod_navigation_server <- function(input, output, session, counter) {
    ns <- session$ns

    # page previous
    observeEvent(input$previousPage, {
        new_count <- counter() - 1
        counter(new_count)
    })

    # next page
    observeEvent(input$nextPage, {
        new_count <- counter() + 1
        counter(new_count)
    })

    # restart
    observeEvent(input$restartApp, {
        counter(1)
    })
}