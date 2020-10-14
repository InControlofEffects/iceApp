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


#' Side Effect Inputs
#'
#' Accordion inputs are generated from `iceData::side_effects`
#'
#' @noRd
side_effects_inputs_ui <- function() {

    # sort reference data by `common_name`
    se_data <- iceData::side_effects[order(iceData::side_effects$common_name), ]

    # generate UI
    tagList(
        lapply(
            seq_len(length(se_data$id)),
            function(d) {
                iceComponents::accordion_input(
                    inputId = se_data$id[d],
                    title = se_data$common_name[d],
                    content = tags$p(se_data$def[d]),
                    class = "accordion__style__a side-effect-accordion"
                )
            }
        )
    )
}