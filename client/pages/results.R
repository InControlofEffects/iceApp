#'//////////////////////////////////////////////////////////////////////////////
#' FILE: results.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-08
#' MODIFIED: 2020-06-15
#' PURPOSE: ui for results page
#' STATUS: working
#' PACKAGES: shiny; rheroicons
#' COMMENTS:
#'      This page uses the UI component card_medication. This component renders
#'      a card with an icon and title. This component is located the file
#'      src/components/elements/card-medicaiton.R and it is loaded in the server
#'//////////////////////////////////////////////////////////////////////////////
page <- renderUI({

    # function component for results cards
    card_medication <- function(id, title = NULL, css = NULL, icon = NULL) {
        card <- tags$div(class = "card", id = paste0("card-", id))
        p <- tags$p(id = id, class = "card-label label-rec")

        # add elems
        if (!is.null(title)) p$children <- title
        if (!is.null(icon)) card$children <- list(icon, p)
        if (is.null(icon)) card$children <- p

        # apply css
        if (!is.null(css)) {
            card$attribs$class <- paste0(card$attribs$class, " ", css)
        }
        return(card)
    }

    # render
    page <- tags$section(
        id = "results-page",
        class = "page",
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

        # results: recommended
        tags$div(
            class = "card-group medication-cards rx-recommended",
            `aria-labelledby` = "recRxTitle",

            # groupt title
            tags$h2(id = "recRxTitle", "Recommended"),

            # results: recommended 1
            card_medication(
                id = "results-label-rec-1",
                css = "card-rec",
                icon = rheroicons::solid$check()
            ),

            # results: recommended 2
            card_medication(
                id = "results-label-rec-2",
                css = "card-rec",
                icon = rheroicons::solid$check()
            ),

            # results: recommended 3
            card_medication(
                id = "results-label-rec-3",
                css = "card-rec",
                icon = rheroicons::solid$check()
            )
        ),

        # results: avoid
        tags$div(
            class = "card-group medication-cards rx-avoid",
            `aria-labelledby` = "avoidRxTitle",

            # group title + content
            tags$h2(id = "avoidRxTitle", "Avoid"),

            # results: avoid 1
            card_medication(
                id = "results-label-avoid-1",
                css = "card-avoid",
                icon = rheroicons::solid$exclamation()
            ),

            # results: avoid 2
            card_medication(
                id = "results-label-avoid-2",
                css = "card-avoid",
                icon = rheroicons::solid$exclamation()
            ),

            # results: avoid 3
            card_medication(
                id = "results-label-avoid-3",
                css = "card-avoid",
                icon = rheroicons::solid$exclamation()
            )
        ),
        page_nav(buttons = c("previous", "next"))
    )
})