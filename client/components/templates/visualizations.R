#'//////////////////////////////////////////////////////////////////////////////
#' FILE: visualizations.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-26
#' MODIFIED: 2019-06-26
#' PURPOSE: ui page for visualizations
#' PACKAGES: shiny
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////

# define page
page <- renderUI({
    tags$section(class="page",

        # title
        tags$h1(id="results-title","Why is", tags$span(class="selected-medication"), "a", tags$span(class="selected-medication-cat")),

        # explanation
        tags$p("You selected", tags$span(id="selected-side-effects", class="text-bold"),"as the", tags$span(class="selected-side-effect-plural"), "that you want to avoid.", tags$strong(class="selected-medication"), "is a ", tags$span(class="selected-medication-cat"), "as it has a", tags$span(class="selected-medication-likelihood"), "likelihood of causing the", tags$span(class="selected-side-effect-plural"), "that you selected."),
        
        # brief methodology overview
        tags$p(" Using the", tags$span(class="selected-side-effect-plural"), "that you selected and data from clinical studies, we calculated new scores, and then ranked them by lowest score. Medications with lower scores and ranks are less likely to cause the", tags$span(class="selected-side-effect-plural"), "that you selected. Medications with higher scores and ranks are more likely to cause the", tags$span(class="selected-side-effect-plural"), "that you selected."),

        # describing scores and rankings
        tags$p(tags$strong(class="selected-medication"),"isn't the only", tags$span(class="selected-medication-cat"), "as there are other medications that have similar scores. These options are listed in the table below."),
        
        # rankings table - show results
        tags$figure(class="revealable-content",
            tableOutput("table_rx_rankings"),
            tags$button(id="toggle", class="secondary", "Show all")
        ),

        # script for expanding section
        tags$script(type="text/javascript",
            ' // select parent element and toggle classes
            var el = document.querySelector(".revealable-content");
            var toggle = document.getElementById("toggle");
            var counter = 0

            // set attributes for figure
            toggle.setAttribute("hidden", "");
            toggle.setAttribute("aria-expanded", false);

            // add event listener
            toggle.addEventListener("click", function(){
                if(counter === 0){
                    el.classList.add("revealable-expanded");
                    toggle.removeAttribute("hidden");
                    toggle.setAttribute("aria-expanded", true);
                    toggle.innerHTML = "Show less";
                    counter = 1;
                } else if(counter === 1) {
                    el.classList.remove("revealable-expanded");
                    toggle.setAttribute("hidden", "");
                    toggle.setAttribute("aria-expanded", true);
                    toggle.innerHTML = "Show all"
                    counter = 0;
                } else {
                    console.error("Critical error with counter. See file: visualisations.R for more information.")
                }
            });'
        ),

        # rankings table
        # tableOutput("table_selected_rx_effect_sizes"),

        # back button
        tags$div(class="page-button-wrapper", 
            tags$button(class="action-button shiny-bound-input default", id="return", HTML(icons$chevronLeft), "Back")
        )
    )
})