#' mod_navigation_ui
#'
#' Create a navigation component by naming buttons
#'
#' @param id a unique ID for the component
#' @param buttons the buttons you like to render (previous, next, submit, etc.)
#'
#' @importFrom shiny tags
#'
#' @noRd
mod_navigation_ui <- function(id, buttons) {
    ns <- NS(id)

    # define buttons
    btns <- list()

    # move back to previous page
    btns$previous <- tags$button(
        id = ns("previousPage"),
        class = "shiny-bound-input action-button default",
        rheroicons::rheroicon(
            name = "chevron_left",
            type = "outline"
        ),
        "Previous"
    )

    # move to next page
    btns$`next` <- tags$button(
        id = ns("nextPage"),
        class = "shiny-bound-input action-button primary",
        "Next",
        rheroicons::rheroicon(
            name = "chevron_right",
            type = "outline"
        )
    )

    # move to next page, but for starting side effects selection
    btns$begin <- tags$button(
        id = ns("begin"),
        class = "shiny-bound-input action-button primary",
        "Begin",
        rheroicons::rheroicon(
            name = "chevron_right",
            type = "outline"
        )
    )

    # submit side effects
    btns$submit <- tags$button(
        id = ns("submit"),
        class = "shiny-bound-input action-button primary",
        "Submit",
        rheroicons::rheroicon(
            name = "chevron_right",
            type = "solid"
        )
    )

    # Previous, but for revisting side effects page from results
    btns$reselect <- tags$button(
        id = ns("reselect"),
        class = "shiny-bound-input action-button default",
        rheroicons::rheroicon(
            name = "chevron_left",
            type = "outline"
        ),
        "Previous"
    )

    # next page, but for post-results
    btns$done <- tags$button(
        id = ns("done"),
        class = "shiny-bound-input action-button primary",
        "Done",
        rheroicons::rheroicon(
            name = "chevron_right",
            type = "solid"
        )
    )

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
    parent <- tags$div(id = ns("nav"), class = "navigation-wrapper", el)
    return(parent)

}

#' mod_nav_server
#'
#' @param id a unique ID per module instance
#' @param counter a reactive counter that manages the page to render
#' @param analytics an R6 class for managing application analytics
#'
#' @noRd
mod_nav_server <- function(id, counter, analytics) {
    moduleServer(
        id,
        function(input, output, session) {
            # onClick: previous page navigation button
            observeEvent(input$previousPage, {
                fade_page()
                counter(counter() - 1)
                analytics$save_click(
                    btn = "previous_page",
                    description = paste0(
                        "navigated to 'previous' ",
                        "(page ", counter(), ")"
                    )
                )
            })

            # onClick: next page navigation button
            observeEvent(input$nextPage, {
                fade_page()
                counter(counter() + 1)
                analytics$save_click(
                    btn = "next_page",
                    description = paste0(
                        "navigated to 'next' ",
                        "(page ", counter(), ")"
                    )
                )
            })

            # onClick: done button click
            observeEvent(input$done, {
                fade_page()
                counter(counter() + 1)
                analytics$save_click(
                    btn = "done_page",
                    description = paste0(
                        "navigated to 'done' ",
                        "(page ", counter(), ")"
                    )
                )
            })

            # onClick: begin
            observeEvent(input$begin, {
                fade_page()
                counter(counter() + 1)
                analytics$save_click(
                    btn = "begin_page",
                    description = paste0(
                        "navigated to 'side effects' ",
                        "(page ", counter(), ")"
                    )
                )
            })

            # onClick: reselect side effects + update attempts
            observeEvent(input$reselect, {
                fade_page()
                counter(counter() - 1)
                analytics$save_click(
                    btn = "previous_page",
                    description = paste0(
                        "navigated back to 'side effects' ",
                        "(page ", counter(), ")"
                    )
                )
            })
        }
    )
}