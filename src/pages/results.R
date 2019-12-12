#'//////////////////////////////////////////////////////////////////////////////
#' FILE: results.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-08
#' MODIFIED: 2019-12-12
#' PURPOSE: ui for results page
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS:
#'      This page uses the UI component card_medication. This component renders
#'      a card with an icon and title. This component is located the file
#'      src/components/elements/card-medicaiton.R and it is loaded in the server
#'//////////////////////////////////////////////////////////////////////////////
# BUILD
page <- renderUI({
    tags$section(class = "page",

        # content
        tags$h1("Results"),
        tags$p("Based on the selections you've made, here are the results. The", 
            tags$strong("recommended"),
            "medication list have a low likelihood of causing the side effect that you selected. The",
            tags$strong("avoid"),
            "medication list have a high likelihood of causing of the side effect that you selected.",
            "Tap the button 'next' to finish the app."
        ),
    
        # results: recommended
        tags$div(class="card-group medication-cards rx-recommended", `aria-labelledby`="recRxTitle",

            # groupt title
            tags$h2(id="recRxTitle","Recommended"),

            # results: recommended 1
            card_medication(
                id="results-label-rec-1",
                css = "card-rec",
                icon = HTML(icons$checkmark)
            ),

            # results: recommended 2
            card_medication(
                id="results-label-rec-2",
                css="card-rec",
                icon = HTML(icons$checkmark)
            ),

            # results: recommended 3
            card_medication(
                id="results-label-rec-3",
                css="card-rec",
                icon = HTML(icons$checkmark)
            )
        
        ),

        # results: avoid
        tags$div(class="card-group medication-cards rx-avoid", `aria-labelledby`="avoidRxTitle",

            # group title + content
            tags$h2(id="avoidRxTitle","Avoid"),

            # results: avoid 1
            card_medication(
                id="results-label-avoid-1",
                css="card-avoid",
                icon = HTML(icons$warning)
            ),
            
            # results: avoid 2
            card_medication(
                id="results-label-avoid-2",
                css = "card-avoid",
                icon = HTML(icons$warning)
            ),
            
            # results: avoid 3
            card_medication(
                id="results-label-avoid-3",
                css = "card-avoid",
                icon = HTML(icons$warning)
            )
        
        ),

        # render buttons
        pageNavigation(buttons = c("previous", "next"))
    )
})