#'//////////////////////////////////////////////////////////////////////////////
#' FILE: page-navigation.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-09
#' MODIFIED: 2020-01-27
#' PURPOSE: module for page navigation buttons
#' PACKAGES: shiny
#' COMMENTS:
#'          This "module" is for rendering the end of page navigation buttons.
#'          By default, the function returns the previous page button and the
#'          next page button. Alternatively, you can substitute the next button
#'          for the submit button, the restart button, or the quit button/
#'//////////////////////////////////////////////////////////////////////////////

# define list of page navigation buttons
navbtns <- list()

# PREVIOUS BUTTON
navbtns$previous <- tags$button(
    id = "previousPage",
    class = "action-button shiny-bound-input default",
    HTML(icons$chevron$left),
    "Previous"
)

# NEXT BUTTON
navbtns$`next` <- tags$button(
    id = "nextPage",
    class = "action-button shiny-bound-input primary",
    "Next",
    HTML(icons$chevron$right)
)

# START BUTTON
navbtns$start <- tags$button(
    id = "start",
    class = "action-button shiny-bound-input primary",
    "Start",
    HTML(icons$chevron$right)
)

# SUBMIT BUTTON
navbtns$submit <- tags$button(
    id = "submit",
    class = "action-button shiny-bound-input primary",
    "Submit",
    HTML(icons$chevron$right)
)

# RESTART BUTTON
navbtns$restart <- tags$button(
    id = "restart",
    class = "action-button shiny-bound-input primary",
    HTML(icons$chevron$left),
    "Restart"
)

# QUIT BUTTON
navbtns$quit <- tags$button(
    id = "quit",
    class = "action-button shiny-bound-input primary",
    "Quit",
    HTML(icons$chevron$right)
)

# SIGNIN BUTTON
navbtns$submitEffects <- tags$button(
    id = "submitEffects",
    class = "action-button shiny-bound-input primary",
    "Submit"
)

# function for pageNavgiation component
page_nav <- function(buttons) {

    # validate buttons and find elements to render
    valid_btns <- match(buttons, names(navbtns))

    # pull btns and render into single object as <li>
    btns <- lapply(seq_len(length(valid_btns)), function(index) {
        tags$li(
            class = "page-nav-item",
            navbtns[valid_btns[index]]
        )
    })

    # return buttons as list
    out <- tags$ul(btns)

    # add css
    if (length(valid_btns) == 1) {
        out$attribs$class <- "page-nav nav-single-button"
    } else {
        out$attribs$class <- "page-nav nav-two-buttons"
    }

    # return
    return(out)
}