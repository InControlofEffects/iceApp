#' App logo
#'
#' @noRd
app__logo <- function() {
    tag(
        `_tag_name` = "svg",
        list(
            class = "logo",
            width = "45",
            height = "44",
            viewBox = "0 0 45 45",
            version = "1.1",
            xmlns = "http://www.w3.org/2000/svg",
            `xmlns:xlink` = "http://www.w3.org/1999/xlink",
            `aria-hidden` = "true",
            tag(
                `_tag_name` = "g",
                list(
                    stroke = "none",
                    `stroke-width` = "1",
                    fill = "none",
                    `fill-rule` = "evenodd",
                    tag(
                        `_tag_name` = "circle",
                        list(
                            fill = "#4655A8",
                            cx = "15",
                            cy = "15",
                            r = "15"
                        )
                    ),
                    tag(
                        `_tag_name` = "circle",
                        list(
                            fill = "#C7CCE4",
                            cx = "30",
                            cy = "29",
                            r = "15"
                        )
                    )
                )
            )
        )
    )
}


#' Previous Button
#'
#' Render a back button
#'
#' @param inputId a unique Id for the button (default `prevPage`)
#' @param label customize the button (default `Previous`)
#'
#' @noRd
back_btn <- function(inputId = "prevPage", label = "Previous") {
    tags$button(
        id = inputId,
        class = "shiny-bound-input action-button default",
        rheroicons::rheroicon(
            name = "chevron_left",
            type = "outline"
        ),
        label
    )
}


#' Next Button
#'
#' @param inputId a unique Id for the button (default `nextPage`)
#' @param label set the button label (default `Next`)
#'
#' @noRd
next_btn <- function(inputId = "nextPage", label = "Next") {
    tags$button(
        id = inputId,
        class = "shiny-bound-input action-button primary",
        label,
        rheroicons::rheroicon(
            name = "chevron_right",
            type = "outline"
        )
    )
}


#' Navigation Container
#'
#' @param ... buttons
#'
#' @noRd
page_nav <- function(...) {
    elems <- tagList(...)
    u <- tags$ul()
    sapply(seq_len(length(elems)), function(x) {
        u$children[[x]] <<- tags$li(class = "navigation-item", elems[[x]])
    })

    if (length(elems) == 1) {
        u$attribs$class <- "navigation-button-list single-button-list"
    }

    if (length(elems) > 1) {
        u$attribs$class <- "navigation-button-list multi-button-list"
    }

    tags$div(class = "navigation-wrapper", u)
}

page_nav(tags$p("text a"), tags$p("text b"), tags$p("text c"))