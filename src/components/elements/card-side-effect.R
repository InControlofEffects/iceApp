#'//////////////////////////////////////////////////////////////////////////////
#' FILE: card-side-effect.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-12-11
#' MODIFIED: 2019-12-12
#' PURPOSE: function to render a UI component for side effect selection
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
# BUILD FUNCTION
card_input <- function(id, title, text){
    tagList(
        tags$div(class="card", id=paste0("card-",id),

            # input element
            tags$label(class="card-input",
                tags$input(type="checkbox", class="checkboxes", id = id),
                tags$span(title)
            ),

            # definition toggle
            tags$button(
                class="action-button shiny-bound-input card-toggle", 
                `aria-expanded` = "false",
                HTML(icons$menuToggle)
            ),

            # collapsible definition
            tags$div(class="card-content", `hidden`="", tags$p(text))
        )
    )
}