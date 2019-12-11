#'//////////////////////////////////////////////////////////////////////////////
#' FILE: results.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-08
#' MODIFIED: 2019-06-08
#' PURPOSE: ui for results page
#' PACKAGES: shiny
#' COMMENTS: NA
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
            "Click or tap a result to view more information about a medication. Otherwise, tap the button 'next' to finish the app."
        ),
    
        # results: recommended
        tags$div(class="card-group medication-cards rx-recommended", `aria-label`="recommended medications",

            # groupt title
            tags$h2("Recommended"),

            # results: recommended 1
            # tags$button(class="action-button shiny-bound-input card", id="rxRec1",
            tags$div(class="action-button shiny-bound-input card", id="rxRec1",
                HTML(icons$checkmark),
                tags$p(id="results-label-rec-1", class="card-label label-rec")
            ),
            # results: recommended 2
            # tags$button(class="action-button shiny-bound-input card", id="rxRec2",
            tags$div(class="action-button shiny-bound-input card", id="rxRec2",
                HTML(icons$checkmark),
                tags$p(id="results-label-rec-2", class="card-label label-rec")
            ),
            # results: recommended 3
            # tags$button(class="action-button shiny-bound-input card", id="rxRec3",
            tags$div(class="action-button shiny-bound-input card", id="rxRec3",
                HTML(icons$checkmark),
                tags$p(id="results-label-rec-3", class="card-label label-rec")
            )
        
        ),

        # results: avoid
        tags$div(class="card-group medication-cards rx-avoid", `aria-label`="medications to avoid",

            # group title + content
            tags$h2("Avoid"),

            # results: avoid 1
            # tags$button(class="action-button shiny-bound-input card", id="rxAvoid1",
            tags$div(class="action-button shiny-bound-input card", id="rxAvoid1",
                HTML(icons$warning),
                tags$p(id="results-label-avoid-1", class="card-label label-avoid")
            ),
            
            # results: avoid 2
            # tags$button(class="action-button shiny-bound-input card", id="rxAvoid2",
            tags$div(class="action-button shiny-bound-input card", id="rxAvoid2",
                HTML(icons$warning),
                tags$p(id="results-label-avoid-2", class="card-label label-avoid")
            ),
            
            # results: avoid 3
            # tags$button(class="action-button shiny-bound-input card", id="rxAvoid3",
            tags$div(class="action-button shiny-bound-input card", id="rxAvoid3",
                HTML(icons$warning),
                tags$p(id="results-label-avoid-3", class="card-label label-avoid")
            )
        
        ),

        # render buttons
        pageNavigation(buttons = c("previous", "next"))
    )
})