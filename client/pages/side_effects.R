#' ////////////////////////////////////////////////////////////////////////////
#' FILE: side_effects.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-08
#' MODIFIED: 2020-06-15
#' PURPOSE: page for displaying side effects options
#' STATUS: working
#' PACKAGES: shiny; rheroicons
#' COMMENTS:
#'      This page uses the UI component `card_input` to standardize the UI. This
#'      function can be found here: src/components/elements/card-side-effect.R
#'      This makes adding new content much easier. This component is loaded in
#'      In the server.
#' ////////////////////////////////////////////////////////////////////////////
# functional component for side effects page
page <- renderUI({
    # functional component for card input
    card_input <- function(id, title, text) {
        tagList(
            tags$div(
                class = "card",
                id = paste0("card-", id),
                `data-group` = id,
                # input element
                tags$label(
                    class = "card-input",
                    `data-group` = id,
                    tags$input(
                        type = "checkbox",
                        class = "checkboxes",
                        id = id,
                        `data-group` = id,
                    ),
                    tags$span(title)
                ),
                # definition toggle
                tags$button(
                    class = "action-button shiny-bound-input card-toggle",
                    id = paste0("card-", id, "-btn"),
                    `data-group` = id,
                    `aria-expanded` = "false",
                    rheroicons::outline$chevron_down()
                ),
                # collapsible definition
                tags$div(
                    class = "card-content",
                    `aria-hidden` = "true",
                    `data-group` = id,
                    tags$p(text)
                )
            )
        )
    }

    # render
    tags$section(
        id = "side-effects-page",
        class = "page",
        tags$h1("Which side effect would you like to avoid?"),
        tags$p(
            id = "side-effects-selection-title",
            "Click or tap the name of the side effect you would like to avoid."
        ),
        tags$div(
            class = "error-box browsertools-hidden",
            id = "side-effects-error-box",
            role = "alert",
            `aria-hidden` = "true",
            rheroicons::outline$exclamation(aria_hidden = TRUE),
            tags$span(
                id = "side-effects-error-message",
                class = "error-box-text"
            )
        ),
        tags$form(
            id = "side-effects-selection",
            class = "card-group side-effect-cards",
            `aria-labelledby` = "side-effects-selection-title",
            tags$fieldset(
                class = "filled-fieldset",

                # side effects: akathisia >> restlessness
                card_input(
                    id = "akathisia",
                    title = "Restlessness",
                    text = paste0(
                        "tbd"
                    )
                ),

                # side effect: anticholinergic >> dry mouth and constipation
                card_input(
                    id = "anticholinergic",
                    title = "Dry mouth and constipation",
                    text = paste0(
                        "tbd"
                    )
                ),

                # side effect: Antiparkinson >> Stiffness and tremors
                card_input(
                    id = "antiparkinson",
                    title = "Stiffness and tremor",
                    text = paste0(
                        "Antipsychotic medications act by blocking, to a",
                        " different degree, a chemical in the brain called",
                        " dopamine. Low levels of dopamine may result in",
                        " difficulties with movement such as stiffness,",
                        " tremors or sudden muscle spasms."
                    )
                ),

                # side effect: prolactin >> sexual dysfunction
                card_input(
                    id = "prolactin",
                    title = "Sexual dysfunction",
                    text = paste0(
                        "Some medications increase a hormone called",
                        " prolactin. In women, prolactin plays an important",
                        " part in pregnancy and an increased level of",
                        " Prolactin may result in lactation. In men, higher",
                        " levels of prolactin can lead to difficulties",
                        " achieving or maintaining an erection. A high level",
                        " of prolactin is associated with a low sex drive",
                        " or difficulties performing sexually."
                    )
                ),

                # side effects: qtc >> irregular heatbeat
                card_input(
                    id = "qtc",
                    title = "Irregular heartbeat",
                    text = paste0(
                        "Some antipsychotic medications can cause changes ",
                        "to the pace or rhythm of heartbeats. In some cases, ",
                        "this can lead to dizziness, shortness of breath, ",
                        "and palpitations (a brief period of a noticeable ",
                        "'fluttering' or a 'pounding' sensation of the heart)."
                    )
                ),

                # side effects: sedation >> ?
                card_input(
                    id = "sedation",
                    title = "Feeling tired or drowsy",
                    text = paste0(
                        "tbd"
                    )
                ),

                # side effects: weight change >> weight gain
                card_input(
                    id = "weight_gain",
                    title = "Weight gain",
                    text = paste0(
                        "Some antipsychotic medications may lead you ",
                        "to put on weight through an increase in appetite ",
                        "and a recurring feeling of hunger."
                    )
                )
            ),

            # additional options
            tags$h3(
                id = "additional-options-title",
                class = "accordion-title",
                `data-group` = "accordion",
                tags$button(
                    id = "additional-options",
                    class = "accordion-button shiny-bound-input action-button",
                    `data-group` = "accordion",
                    `aria-expanded` = "false",
                    "Additional Options",
                    rheroicons::outline$cog()
                )
            ),
            tags$div(
                id = "additional-options-fieldset",
                class = "accordion-section browsertools-hidden",
                `data-group` = "accordion",
                tags$fieldset(
                    id = "licensed-countries",
                    class = "",
                    tags$legend("Limit results by country"),

                    # Germany
                    tags$div(
                        class = "checkbox-input",
                        tags$input(
                            id = "countries-germany",
                            name = "countries",
                            value = "Germany",
                            type = "checkbox"
                        ),
                        rheroicons::outline$check(),
                        tags$label(
                            `for` = "countries-germany",
                            "Germany"
                        )
                    ),

                    # United Kingdom
                    tags$div(
                        class = "checkbox-input",
                        tags$input(
                            id = "countries-uk",
                            name = "countries",
                            value = "UK",
                            type = "checkbox"
                        ),
                        rheroicons::outline$check(),
                        tags$label(
                            `for` = "countries-uk",
                            "United Kingdom"
                        )
                    ),

                    # USA
                    tags$div(
                        class = "checkbox-input",
                        tags$input(
                            id = "countries-usa",
                            name = "countries",
                            value = "UK",
                            type = "checkbox"
                        ),
                        rheroicons::outline$check(),
                        tags$label(
                            `for` = "countries-usa",
                            "United States"
                        )
                    )
                )
            )
        ),
        page_nav(buttons = c("previous", "submitEffects"))
    )
})
