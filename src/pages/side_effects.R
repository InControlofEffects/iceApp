#' ////////////////////////////////////////////////////////////////////////////
#' FILE: side_effects.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-08
#' MODIFIED: 2020-03-24
#' PURPOSE: page for displaying side effects options
#' STATUS: working
#' PACKAGES: shiny
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
                class = "card", id = paste0("card-", id),
                # input element
                tags$label(
                    class = "card-input",
                    tags$input(
                        type = "checkbox",
                        class = "checkboxes",
                        id = id
                    ),
                    tags$span(title)
                ),
                # definition toggle
                tags$button(
                    class = "action-button shiny-bound-input card-toggle",
                    `aria-expanded` = "false",
                    HTML(icons$menuToggle)
                ),
                # collapsible definition
                tags$div(class = "card-content", `hidden` = "", tags$p(text))
            )
        )
    }

    # render
    page <- tags$section(
        class = "page",
        tags$h1("Which side effect would you like to avoid?"),
        tags$p(
            "Select up to two side effects. Press the more",
            HTML(icons$menuToggleAlt),
            "icon for more information."
        ),
        tags$span(class = "error-text", id = "form-error", role = "alert"),
        tags$form(
            class = "card-group side-effect-cards",
            `aria-label` = "select side effects",

            # side effects: weight change >> weight gain
            card_input(
                id = "weight",
                title = "Weight Gain",
                text = paste0(
                    "Some antipsychotic medications may lead you ",
                    "to put on weight through an increase in appetite ",
                    "and a recurring feeling of hunger."
                )
            ),

            # side effects: irregular heatbeat
            card_input(
                id = "qtc",
                title = "Irregular Heartbeat",
                text = paste0(
                    "Some antipsychotic medications can cause changes ",
                    "to the pace or rhythm of heartbeats. In some cases, ",
                    "this can lead to dizziness, shortness of breath, ",
                    "and palpitations (a brief period of a noticeable ",
                    "'fluttering' or a 'pounding' sensation of the heart)."
                )
            ),

            # side effects: sexual dysfunction
            card_input(
                id = "prolactin",
                title = "Sexual Dysfunction",
                text = paste0(
                    "Some medications increase a hormone called prolactin. ",
                    "In women, prolactin plays an important part in pregnancy",
                    " and an increased level of Prolactin may result in",
                    " lactation. In men, higher levels of prolactin can lead ",
                    "to difficulties achieving or maintaining an erection. ",
                    "A high level of prolactin is associated with a low sex",
                    " drive or difficulties performing sexually."
                )
            ),

            # side effects: stiffness and tremor
            card_input(
                id = "extrapyram",
                title = "Stiffness and Tremor",
                text = paste0(
                    "Antipsychotic medications act by blocking to a different",
                    " degree a chemical in the brain called dopamine. Low",
                    " levels of dopamine may result in difficulties with ",
                    "movement such as stiffness, tremor or sudden muscle",
                    " spasms. In some cases dopamine blockers can also ",
                    "cause brief periods of extreme feeling of",
                    " restlessness."
                )
            )
        ),
        page_nav(buttons = c("previous", "submitEffects")),
        tags$script(
            type = "text/javascript",
            "// call listeners for toggling definitions and focus events
            setTimeout(function() {
                utils.toggleDefinitions();
                utils.toggleSelection();
            }, 75);
        "
        )
    )
})
