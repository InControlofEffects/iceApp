#' Application subpages
#'
#' An object containing all application pages. This application works by
#' dynamically rendering pages into the application
#'
#' @import rheroicons
#' @noRd
pages <- list()


#' Instructions page 1
pages[[1]] <- mod_app_page_ui(
    id = "instructions-a",
    class = "instructions-page",
    html = tagList(
        tags$h1("How to use this app"),
        tags$p(
            "In a moment, you will be presented a list of side effects.",
            "Select the side effects that you definitely do not want",
            "or the ones that you would like to avoid.",
            "Tap or click the name of the side effect to select it. Click the",
            rheroicons::outline$chevron_down(),
            "icon to view more information about each side effect.",
            "When you are ready, press the submit button to view the results."
        ),
        mod_navigation_ui(
            id = "instructions-a",
            buttons = "next"
        )
    )
)

# Instructions Page 2
pages[[2]] <- mod_app_page_ui(
    id = "instructions-b",
    class = "instructions-page",
    html = tagList(
        tags$h1("How to use this app"),
        tags$p(
            "The results page will show a list of recommend medications",
            "and a list of medications to avoid.",
            "Recommended medications are less likely to cause the side",
            "effects that you selected whereas medications to avoid,",
            "will likely cause the side effects that you want to avoid.",
            "Tap or click the name of the medication for more information."
        ),
        mod_navigation_ui(
            id = "instructions-b",
            buttons = c("previous", "next")
        )
    )
)


# Instructions Page 3
pages[[3]] <- mod_app_page_ui(
    id = "instructions-c",
    class = "instructions-page",
    html = tagList(
        tags$h1("How to use this app"),
        tags$p(
            "If you are concerned about side effects",
            "or anything else related to your medical care,",
            "consult your healthcare provider.",
            "You can revisit these instructions at anytime by tapping the",
            rheroicons::outline$refresh(),
            "icon located at the top of the page."
        ),
        mod_navigation_ui(
            id = "instructions-c",
            buttons = c("previous", "next")
        )
    )
)

# Side Effects Page
pages[[4]] <- mod_app_page_ui(
    id = "side-effects",
    class = "card-page",
    html = tagList(
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
                mod_side_effect_card_ui(
                    id = "akathisia",
                    title = "Restlessness",
                    text = paste0(
                        "Antipsychotic medications can effect dopamine",
                        " levels in the brain, which may result in feelings",
                        " of restlessness or an inability to sit still."
                    )
                ),

                # side effect: anticholinergic >> dry mouth and constipation
                mod_side_effect_card_ui(
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

                # side effect: Antiparkinson >> Stiffness and tremors
                mod_side_effect_card_ui(
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
                mod_side_effect_card_ui(
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

                # side effects: qtc >> irregular heatbeat
                mod_side_effect_card_ui(
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
                mod_side_effect_card_ui(
                    id = "sedation",
                    title = "Feeling sleepy or drowsy",
                    text = paste0(
                        "Antipsychotic medications can effect a chemical in",
                        " the brain known as histamine. Low levels of",
                        " histamine can lead to feeling sleepy, tired or",
                        " drowsy."
                    )
                ),

                # side effects: weight change >> weight gain
                mod_side_effect_card_ui(
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
        mod_navigation_ui(id = "submitEffects", buttons = c("previous", "submit"))
    )
)


# Results Page
pages[[5]] <- mod_app_page_ui(
    id = "results",
    class = "results",
    html = tagList(
        tags$h1("Results"),
        tags$p(
            "Based on the selections you've made, here are the results. The",
            tags$strong("recommended"),
            "medication list have a low likelihood of causing the side",
            "effect that you selected. The",
            tags$strong("avoid"),
            "medication list have a high likelihood of causing of the",
            "side effect that you selected.",
            "Tap the button 'next' to finish the app."
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
            mod_medication_card_ui(id = "avoid-rx-b", type = "avoid")
        ),
        mod_navigation_ui(id = "results", buttons = c("previous", "next"))
    )
)

# Quit Page
pages[[6]] <- mod_app_page_ui(
    id = "quit",
    html = tagList(
        tags$h1("Before you go"),
        tags$p(
            "The In Control of Effects app is design to initiate a discussion",
            "between you and your psychiatrist regarding antipsychotic",
            "medications and the risk of side effects. This may be useful",
            "if there are side effects that you are unaware of or would ",
            "like to avoid."
        ),
        tags$p(
            "This app is an experimental clinical research tool that is a",
            "part of ongoing research led by researchers at the University",
            "of Oxford. This app does not replace medical treatment or",
            "consultation with any healthcare professional. Any information",
            "produced by this tool should be discussed with your psychiatrist",
            "as this app does not take into account individual patient",
            "characteristics, pre-existing medical conditions, any current",
            "medical treatment or medications you may already be taking."
        ),
        tags$p(
            "If you are concerned about side effects or anything else",
            "related to your medical care, consult your healthcare provider."
        ),
        mod_navigation_ui(id = "quit", buttons = c("restart", "quit"))
    )
)