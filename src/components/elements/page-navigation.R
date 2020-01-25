#'//////////////////////////////////////////////////////////////////////////////
#' FILE: page-navigation.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-09
#' MODIFIED: 2020-01-25
#' PURPOSE: module for page navigation buttons
#' PACKAGES: shiny
#' COMMENTS: 
#'          This "module" is for rendering the end of page navigation buttons.
#'          By default, the function returns the previous page button and the 
#'          next page button. Alternatively, you can substitute the next button
#'          for the submit button, the restart button, or the quit button/
#'//////////////////////////////////////////////////////////////////////////////

# define list of page navigation buttons
page_nav_btns <- list()

# PREVIOUS BUTTON
page_nav_btns$previous <- tags$button(
    id = "previousPage",
    class = "action-button shiny-bound-input default",
    HTML(icons$chevron$left),
    "Previous"
)

# NEXT BUTTON
page_nav_btns$`next` <- tags$button(
    id = "nextPage",
    class = "action-button shiny-bound-input primary",
    "Next",
    HTML(icons$chevron$right)
)

# START BUTTON
page_nav_btns$start <- tags$button(
    id = "start",
    class = "action-button shiny-bound-input primary",
    "Start",
    HTML(icons$chevron$right)
)

# SUBMIT BUTTON
page_nav_btns$submit <- tags$button(
    id = "submit",
    class = "action-button shiny-bound-input primary",
    "Submit",
    HTML(icons$chevron$right)
)

# RESTART BUTTON
page_nav_btns$restart <- tags$button(
    id = "restart",
    class = "action-button shiny-bound-input primary",
    HTML(icons$chevron$left),
    "Restart"
)

# QUIT BUTTON
page_nav_btns$quit <- tags$button(
    id = "quit",
    class = "action-button shiny-bound-input primary",
    "Quit",
    HTML(icons$chevron$right)
)

# SIGNIN BUTTON
page_nav_btns$submitEffects <- tags$button(
    id = "submitEffects",
    class = "action-button shiny-bound-input primary",
    "Submit"
)

# function for pageNavgiation component
pageNavigation <- function(buttons) {

    # validate buttons and find elements to render
    valid_btns <- match(buttons, names(page_nav_btns))

    # pull btns and render into single object as <li>
    btns <- lapply(1:length(valid_btns), function(index) {
        tags$li(
            class = "page-nav-item",
            page_nav_btns[valid_btns[index]]
        )
    })

    # return buttons as list
    out <- tags$ul(btns)
    out$attribs$`aria-label` <- "go to next or previous page"

    # add css
    if (length(valid_btns) == 1) {
        out$attribs$class <- "page-nav nav-single-button"
    } else {
        out$attribs$class <- "page-nav nav-two-buttons"
    }

    # return
    out
}