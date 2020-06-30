#'////////////////////////////////////////////////////////////////////////////
#' FILE: mod_navigation.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-27
#' MODIFIED: 2020-06-30
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
        previous = tags$button(
            id = ns("previousPage"),
            class = "shiny-bound-input action-button default",
            rheroicons::outline$chevron_left(aria_hidden = TRUE),
            "Previous"
        ),
        "next" = tags$button(
            id = ns("nextPage"),
            class = "shiny-bound-input action-button primary",
            "Next",
            rheroicons::outline$chevron_right(aria_hidden = TRUE)
        ),
        submit = tags$button(
            id = ns("submit"),
            class = "shiny-bound-input action-button primary",
            "Submit",
            rheroicons::outline$arrow_circle_right(aria_hidden = TRUE)
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
            "Quit",
            rheroicons::outline$logout(aria_hidden = TRUE)
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
#' @param input require shiny object
#' @param output require shiny object
#' @param session require shiny object
#' @param counter a reactive counter that manages the page to render
#' @param session_db an R6 object that is used for saving data to the db
mod_nav_server <- function(input, output, session, counter, session_db) {
    ns <- session$ns

    # page previous
    observeEvent(input$previousPage, {

        # make sure page is faded out
        utils$fadePage()

        # log click to the database
        session_db$capture_click("navigation", "previous button clicked")

        # increment counter
        new_count <- counter() - 1
        counter(new_count)
    })

    # next page
    observeEvent(input$nextPage, {

        # make sure page fades out
        utils$fadePage()

        # log click to database
        session_db$capture_click("navigation", "next button clicked")

        # increment page
        new_count <- counter() + 1
        counter(new_count)
    })

    # restart
    observeEvent(input$restartApp, {

        # fade page
        utils$fadePage()

        # log to database
        session_db$capture_click("navigation", "app restarted")

        # update counter
        counter(1)
    })
}