#' Application Subpages
#'
#' Internal object that contains the HTML content for all subpages
#'
#' @importFrom shiny tags tagList
#' @noRd
pages <- list()

# define list attributes
attr(pages, "title") <- "In Control of Effects"

#'//////////////////////////////////////

# Instructions page 1
pages$instructions_a <- tags$article(
    id = "instructions-a",
    class = "page fadeIn instructions-page",
    `aria-labelledby` = "instructions-a-title",
    tags$h1(
        id = "instructions-a-title",
        "Welcome"
    ),
    tags$p(
        "The", tags$strong("In Control of Effects"), "app is",
        "designed to initiate a discussion between you and your",
        "psychiatrist regarding antipsychotic medications and the risk of",
        "side effects. This may be useful if there are side effects that",
        "you are unaware of or would like to avoid."
    ),
    tags$p(
        "Press next to continue."
    ),
    mod_navigation_ui(
        id = "instructions-a",
        buttons = "next"
    )
)

# set attributes of current page
attr(pages$instructions_a, "title") <- "Welcome!"

#'//////////////////////////////////////

# Instructions Page 2
pages$instructions_b <- tags$article(
    id = "instructions-b",
    class = "page fadeIn instructions-page",
    `aria-labelledby` = "how-to-use-this-app",
    tags$h1(
        id = "how-to-use-this-app",
        "How to use this app"
    ),
    tags$p(
        "To navigate pages in this app, press the next or previous button.",
        "You can also restart the app from the beginning by pressing the",
        "restart", rheroicons::outline$refresh(), "button located at the top",
        "of the screen. If you would like exit the app, click the sign out",
        rheroicons::outline$logout(), "button."
    ),
    tags$p(
        "Press next to continue"
    ),
    mod_navigation_ui(
        id = "instructions-b",
        buttons = c("previous", "next")
    )
)

# set attributes of page
attr(pages$instructions_b, "title") <- "How to use this app"

#'//////////////////////////////////////

# Instructions Page 3
pages$instructions_c <- tags$article(
    id = "instructions-c",
    class = "page fadeIn instructions-page",
    `aria-labelledby` = "how-to-select-side-effects",
    tags$h1(
        id = "how-to-select-side-effects",
        "How to select side effects"
    ),
    tags$p(
        "In a moment, you will be presented with a list of side effects.",
        "Select the side effect that you would like to avoid or the one",
        "that you definitely do not want. Tap or click the name of the",
        "side effect to select it. Tap or click another time to deselect it."
    ),
    tags$p(
        "You can also view more information about each side effect by tapping",
        "or clicking the open icon", rheroicons::outline$chevron_down(),
        ". When you have made your selection, press the submit button to view",
        "the results."
    ),
    mod_navigation_ui(
        id = "instructions-c",
        buttons = c("previous", "next")
    )
)

# set attributes of current page
attr(pages$instructions_c, "title") <- "How to select side effects"

#'//////////////////////////////////////

pages$instructions_d <- tags$article(
    id = "instructions-d",
    class = "page fadeIn instructions-page",
    `aria-labelledby` = "what-this-app-does-not-do",
    tags$h1(
        id = "what-this-app-does-not-do",
        "What this app does not do"
    ),
    tags$p(
        "It is important to note that the",
        tags$strong("In Control of Effects"), "app does not replace medical",
        "treatment or consultation with your psychiatrist. Any information",
        "produced by this tool should be discussed with your psychiatrist as",
        "this app does not take into account individual patient",
        "characteristics, pre-existing medical conditions, or medications you",
        "may already be taking. If you are concerned about side effects or",
        "anything else related to your medical care, consult your",
        "psychiatrist."
    ),
    tags$p("Press next to view the side effects."),
    mod_navigation_ui(
        id = "instructions-d",
        buttons = c("previous", "begin")
    )
)

# set attributes
attr(pages$instructions_d, "title") <- "What this app does not do"

#'//////////////////////////////////////

# Side Effects Page
pages$side_effects <- tags$article(
    id = "side-effects",
    class = "page fadeIn card-page page-extra-top-spacing",
    `aria-labelledby` = "which-side-effect-would-you-like-to-avoid",
    tags$h1(
        id = "which-side-effect-would-you-like-to-avoid",
        "Which side effect would you like to avoid?"
    ),
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
            # The order of the side effects by IDs is listed below.
            # - akathisia
            # - anticholinergic
            # - antiparkinson
            # - prolactic
            # - qtc
            # - sedation
            # - weight_gain
            #
            # However, side effects are arranged in alphabetical order
            # by the common name.
            # - Dry Mouth and Constipation
            # - Feeling Sleepy or Drowsy
            # - Irregular Heartbeat
            # - Restlessness
            # - Sexual Dysfunction
            # - Stiffness and Tremor
            # - Weight Gain
            # side effect: anticholinergic >> dry mouth and constipation
            mod_side_effect_ui(
                id = "anticholinergic",
                title = "Dry mouth and constipation",
                text = paste0(
                    "Antipsychotic medications can block acetylcholine",
                    " a type of chemical in the brain.",
                    " Blocking it can affect involuntary muscle",
                    " movements (for example the ones in the bladder and",
                    " the guts) and various bodily functions (for",
                    " example saliva production)."
                )
            ),
            # side effects: sedation >> feeling sleepy or drowsy
            mod_side_effect_ui(
                id = "sedation",
                title = "Feeling sleepy or drowsy",
                text = paste0(
                    "Antipsychotic medications can effect a chemical in",
                    " the brain known as histamine. Low levels of",
                    " histamine can lead to feeling sleepy, tired or",
                    " drowsy."
                )
            ),
            # side effects: qtc >> irregular heatbeat
            mod_side_effect_ui(
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
            # side effects: akathisia >> restlessness
            mod_side_effect_ui(
                id = "akathisia",
                title = "Restlessness",
                text = paste0(
                    "Antipsychotic medications can effect dopamine",
                    " levels in the brain, which may result in feelings",
                    " of restlessness or an inability to sit still."
                )
            ),
            # side effect: prolactin >> sexual dysfunction
            mod_side_effect_ui(
                id = "prolactin",
                title = "Sexual dysfunction",
                text = paste0(
                    "Antipsychotic medications increase a hormone called",
                    " prolactin. In women, prolactin plays an important",
                    " part in pregnancy and an increased level of",
                    " Prolactin may result in lactation. In men, higher",
                    " levels of prolactin can lead to difficulties",
                    " achieving or maintaining an erection. A high level",
                    " of prolactin is associated with a low sex drive",
                    " or difficulties performing sexually."
                )
            ),
            # side effect: Antiparkinson >> Stiffness and tremors
            mod_side_effect_ui(
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
            # side effects: weight change >> weight gain
            mod_side_effect_ui(
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
            `data-group` = "accordion-1",
            tags$button(
                id = "additional-options",
                class = "accordion-button shiny-bound-input action-button",
                `data-group` = "accordion-1",
                `aria-expanded` = "false",
                "Additional Options",
                rheroicons::outline$cog()
            )
        ),
        tags$section(
            id = "additional-options-fieldset",
            class = "accordion-section browsertools-hidden",
            `data-group` = "accordion-1",
            tags$fieldset(
                id = "licensed-countries",
                class = "checkbox-group",
                tags$legend("Limit results by country"),
                # Germany
                tags$div(
                    class = "checkbox-input",
                    tags$input(
                        id = "countries-germany",
                        name = "countries",
                        value = "Germany",
                        type = "checkbox",
                        checked = ""
                    ),
                    tags$label(
                        `for` = "countries-germany",
                        rheroicons::outline$check_circle(
                            aria_hidden = TRUE
                        ),
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
                        type = "checkbox",
                        checked = ""
                    ),
                    tags$label(
                        `for` = "countries-uk",
                        rheroicons::outline$check_circle(
                            aria_hidden = TRUE
                        ),
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
                        type = "checkbox",
                        checked = ""
                    ),
                    tags$label(
                        `for` = "countries-usa",
                        rheroicons::outline$check_circle(
                            aria_hidden = TRUE
                        ),
                        "United States"
                    )
                )
            )
        )
    ),
    mod_navigation_ui(id = "sideEffects", buttons = c("previous", "submit"))
)

# set attributes of current page
attr(pages$side_effects, "title") <- "Select Side Effects"

#'//////////////////////////////////////

# Results Page
pages$results <- tags$article(
    id = "results",
    class = "page fadeIn results page-extra-top-spacing",
    `aria-labelledby` = "results-title",
    tags$h1(
        id = "results-title",
        "Results"
    ),
    tags$p(
        "Based on the selections you've made, here are the results. The",
        tags$strong("recommended"),
        "medication list have a low likelihood of causing the side",
        "effect that you selected. The",
        tags$strong("avoid"),
        "medication list have a high likelihood of causing of the",
        "side effect that you selected."
    ),
    tags$div(
        class = "card-group medication-cards rx-recommended",
        tags$h2(id = "recRxTitle", "Recommended"),
        mod_medication_card_ui(id = "rec-rx-a", type = "recommended"),
        mod_medication_card_ui(id = "rec-rx-b", type = "recommended"),
        mod_medication_card_ui(id = "rec-rx-c", type = "recommended")
    ),
    tags$div(
        class = "card-group medication-cards rx-avoid",
        tags$h2(id = "avoidRxTitle", "Avoid"),
        mod_medication_card_ui(id = "avoid-rx-a", type = "avoid"),
        mod_medication_card_ui(id = "avoid-rx-b", type = "avoid"),
        mod_medication_card_ui(id = "avoid-rx-c", type = "avoid")
    ),
    mod_navigation_ui(id = "results", buttons = c("reselect", "done"))
)

# set attributes of current page
attr(pages$results, "title") <- "Results"

#'//////////////////////////////////////

# Quit Page
pages$quit <- tags$article(
    id = "quit",
    class = "page fadeIn page-extra-top-spacing",
    tags$h1(
        "Thank you for using the",
        tags$span("In Control of Effects"),
        "app!"
    ),
    tags$p(
        "The In Control of Effects app was designed to initiate a",
        "discussion between you and your psychiatrist regarding",
        "antipsychotic medications and the risk of side effects.",
        "If you are concerned about side effects or anything else",
        "related to your medical care, consult your healthcare provider."
    ),
    tags$p(
        "You may now close this window."
    )
)

# set attributes of current page
attr(pages$quit, "title") <- "Final Page"