#' Application Subpages
#'
#' Internal object that contains the HTML content for all subpages
#'
#' @noRd
pages <- list()

# define list attributes
attr(pages, "title") <- "In Control of Effects"


# Instructions page 1
pages$instructions_a <- iceComponents::page(
    inputId = "instructions-a",
    class = "fadeIn instructions-page",
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
    iceComponents::navigation(
        iceComponents::forward_btn()
    )
)

# set attributes of current page
attr(pages$instructions_a, "title") <- "Welcome!"



# Instructions Page 2
pages$instructions_b <- iceComponents::page(
    inputId = "instructions-b",
    class = "fadeIn instructions-page",
    `aria-labelledby` = "how-to-use-this-app",
    tags$h1(
        id = "how-to-use-this-app",
        "How to use this app"
    ),
    tags$p(
        "To navigate pages in this app, press the next or previous button.",
        "You can also restart the app from the beginning by pressing the",
        "restart", rheroicons::rheroicon(name = "refresh"),
        "button located at the top of the screen. If you would like to exit",
        "the app, click the sign out", rheroicons::rheroicon(name = "logout"),
        "button."
    ),
    tags$p(
        "Press next to continue"
    ),
    iceComponents::navigation(
        iceComponents::back_btn(),
        iceComponents::forward_btn()
    )
)

# set attributes of page
attr(pages$instructions_b, "title") <- "How to use this app"




# Instructions Page 3
pages$instructions_c <- iceComponents::page(
    inputId = "instructions-c",
    class = "fadeIn instructions-page",
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
        "or clicking the open icon",
        rheroicons::rheroicon(name = "chevron_down"),
        ". When you have made your selection, press the submit button to view",
        "the results."
    ),
    iceComponents::navigation(
        iceComponents::back_btn(),
        iceComponents::forward_btn()
    )
)

# set attributes of current page
attr(pages$instructions_c, "title") <- "How to select side effects"




pages$instructions_d <- iceComponents::page(
    inputId = "instructions-d",
    class = "fadeIn instructions-page",
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
    iceComponents::navigation(
        iceComponents::back_btn(),
        iceComponents::forward_btn(label = "Begin")
    )
)

# set attributes
attr(pages$instructions_d, "title") <- "What this app does not do"



# Side Effects Page
# The order of the side effects by IDs is listed below.
# - akathisia       : Restlessness
# - anticholinergic : Dry Mouth and Constipation
# - antiparkinson   : Stiffness and Tremor
# - prolactic       : Sexual Dysfunction
# - qtc             : Irregular Heartbeat
# - sedation        : Feeling Sleepy of Drowsy
# - weight_gain     : Weight Gain
pages$side_effects <- iceComponents::page(
    inputId = "side-effects",
    class = "fadeIn card-page page-extra-top-spacing",
    `aria-labelledby` = "which-side-effect-would-you-like-to-avoid",
    tags$h1(
        id = "which-side-effect-would-you-like-to-avoid",
        "Which side effect would you like to avoid?"
    ),
    tags$p(
        id = "side-effects-selection-title",
        "Click or tap the name of the side effect you would like to avoid."
    ),
    iceComponents::error_box(inputId = "side-effects-error"),
    tags$form(
        id = "side-effects-selection",
        class = "card-group side-effect-cards",
        `aria-labelledby` = "side-effects-selection-title",
        tags$fieldset(
            id = "sideEffects",
            side_effects_inputs_ui()  # markup generated in `golem_utils_ui`
        ),
        # accordion: additional options for side effects
        iceComponents::accordion(
            inputId = "settings",
            title = "Settings",
            content = iceComponents::checkbox_group(
                inputId = "countries-filter",
                title = "Limit Results by Country",
                caption = "The availability of medications may vary by country. You can limit the results to one or more countries.",
                choices = c("Germany", "United Kingdom", "United States"),
                values = c("Germany", "UK", "USA"),
                checked = TRUE
            )
        )
    ),
    iceComponents::navigation(
        iceComponents::back_btn(),
        iceComponents::forward_btn(inputId = "submit", label = "Submit")
    )
)

# set attributes of current page
attr(pages$side_effects, "title") <- "Select Side Effects"




# Results Page
pages$results <- iceComponents::page(
    inputId = "results",
    class = "fadeIn results page-extra-top-spacing",
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
    iceComponents::card_group(
        class = "medication-cards rx-recommended",
        tags$h2(id = "recRxTitle", "Recommended"),
        iceComponents::card(
            inputId = "rec-rx-a",
            text = "",
            icon_name = "check_circle",
            icon_type = "solid",
            class = "recommended"
        ),
        iceComponents::card(
            inputId = "rec-rx-b",
            text = "",
            icon_name = "check_circle",
            icon_type = "solid",
            class = "recommended"
        ),
        iceComponents::card(
            inputId = "rec-rx-c",
            text = "",
            icon_name = "check_circle",
            icon_type = "solid",
            class = "recommended"
        )
    ),
    iceComponents::card_group(
        class = "medication-cards rx-avoid",
        tags$h2(id = "avoidRxTitle", "Avoid"),
        iceComponents::card(
            inputId = "avoid-rx-a",
            text = "",
            icon_name = "exclamation",
            icon_type = "solid",
            class = "avoid"
        ),
        iceComponents::card(
            inputId = "avoid-rx-b",
            text = "",
            icon_name = "exclamation",
            icon_type = "solid",
            class = "avoid"
        ),
        iceComponents::card(
            inputId = "avoid-rx-c",
            text = "",
            icon_name = "exclamation",
            icon_type = "solid",
            class = "avoid"
        )
    ),
    iceComponents::navigation(
        iceComponents::back_btn(inputId = "reselect", label = "Reselect"),
        iceComponents::forward_btn(inputId = "done", label = "Done")
    )
)

# set attributes of current page
attr(pages$results, "title") <- "Results"





# Quit Page
pages$quit <- iceComponents::page(
    inputId = "quit",
    class = "fadeIn page-extra-top-spacing",
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
        "You may now close this window or return to", tags$a(
            href = "https://incontrolofeffects.com",
            "incontrolfofeffects.com"
        ), "."
    )
)

# set attributes of current page
attr(pages$quit, "title") <- "Final Page"