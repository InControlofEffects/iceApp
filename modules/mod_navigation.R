#'////////////////////////////////////////////////////////////////////////////
#' FILE: mod_navigation.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-27
#' MODIFIED: 2020-07-10
#' PURPOSE: app application
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' mod_navigation_ui
#' Create a navigation component by naming buttons
#' @param id a unique ID for the component
#' @param buttons the buttons you like to render (previous, next, submit,
#'              restart, quit)
mod_navigation_ui <- function(id, buttons) {
    ns <- NS(id)

    # define buttons
    btns <- list(

        #' move back to previous page
        previous = tags$button(
            id = ns("previousPage"),
            class = "shiny-bound-input action-button default",
            rheroicons::outline$chevron_left(aria_hidden = TRUE),
            "Previous"
        ),

        #' move to next page
        "next" = tags$button(
            id = ns("nextPage"),
            class = "shiny-bound-input action-button primary",
            "Next",
            rheroicons::outline$chevron_right(aria_hidden = TRUE)
        ),

        #' move to next page, but for starting side effects selection
        begin = tags$button(
            id = ns("begin"),
            class = "shiny-bound-input action-button primary",
            "Begin",
            rheroicons::outline$chevron_right(aria_hidden = TRUE)
        ),

        #' submit side effects
        submit = tags$button(
            id = ns("submit"),
            class = "shiny-bound-input action-button primary",
            "Submit",
            rheroicons::solid$arrow_circle_right(aria_hidden = TRUE)
        ),

        #' Previous, but for revisting side effects page from results
        reselect = tags$button(
            id = ns("reselect"),
            class = "shiny-bound-input action-button default",
            rheroicons::outline$chevron_left(aria_hidden = TRUE),
            "Previous"
        ),

        #' next page, but for post-results
        done = tags$button(
            id = ns("done"),
            class = "shiny-bound-input action-button primary",
            "Done",
            rheroicons::solid$check_circle(aria_hidden = TRUE)
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

#' mod_nav_server
#' @param id a unique ID per module instance
#' @param counter a reactive counter that manages the page to render
#' @param session_db an R6 object that is used for saving data to the db
mod_nav_server <- function(id, counter, session_db) {
    moduleServer(
        id,
        function(input, output, session) {
            # onClick: previous page navigation button
            observeEvent(input$previousPage, {
                utils$fadePage()
                session_db$capture_click(
                    "navigation",
                    "previous button clicked"
                )
                counter(counter() - 1)
            })

            # onClick: next page navigation button
            observeEvent(input$nextPage, {
                utils$fadePage()
                session_db$capture_click("navigation", "next button clicked")
                counter(counter() + 1)
            })

            # onClick: done button click
            observeEvent(input$done, {
                utils$fadePage()
                session_db$capture_click(
                    "navigation",
                    "user clicked the final button"
                )
                counter(counter() + 1)
            })

            # onClick: begin
            observeEvent(input$begin, {
                utils$fadePage()
                session_db$capture_click(
                    "navigation",
                    "started side effects selection"
                )
                counter(counter() + 1)
            })

            # onClick: reselect side effects + update attempts
            observeEvent(input$reselect, {
                utils$fadePage()
                session_db$update_attempts()
                session_db$capture_click(
                    "navigation",
                    "restarting side effect selection"
                )
                counter(counter() - 1)
            })
        }
    )
}