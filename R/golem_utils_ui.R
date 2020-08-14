#' App logo
#'
#' @param ... attributes to be passed down to the SVG element
#'
#' @noRd
app__logo <- function(...) {
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