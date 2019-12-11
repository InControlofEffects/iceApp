#'//////////////////////////////////////////////////////////////////////////////
#' FILE: side_effects.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-08
#' MODIFIED: 2019-12-11
#' PURPOSE: page for displaying side effects options
#' PACKAGES: shiny
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
# build page
page <- renderUI({
    tags$section(class = "page",
                 
        # content
        tags$h1("Which side effect would you like to avoid?"),
        tags$p("Select up to two side effects. Press the more", HTML(icons$menuToggleAlt), "icon for more information."),
                 
        # error message
        tags$span(class="error-text",id="form-error", role="alert"),
                 
        # create card wrappers
        tags$form(class="card-group side-effect-cards", `aria-label`="select side effects",
                       
            # side effects: weight change >> weight gain
            tags$div(class="card",
                tags$label(class="card-input",
                    tags$input(type="checkbox", class="checkboxes", id="weight"),
                    tags$span("Weight Gain")
                ),
                 tags$button(class="action-button shiny-bound-input card-toggle", "aria-expanded"="false",
                    HTML(icons$menuToggle)
                 ),
                tags$div(class="card-content", "hidden"="",
                    tags$p("Some antipsychotic medications may lead you to put on weight through an increase in appetite and a recurring feeling of hunger.")
                )
            ),
                           
            # side effects: irregular heatbeat
            tags$div(class="card",
                tags$label(class="card-input",
                    tags$input(type="checkbox", class="checkboxes", id="qtc"),
                    tags$span("Irregular Heartbeat")
                ),
                tags$button(class="action-button shiny-bound-input card-toggle", "aria-expanded"="false",
                    HTML(icons$menuToggle)
                ),
                tags$div(class="card-content", "hidden"="",
                    tags$p("Some antipsychotic medications can cause changes to the pace or rhythm of heartbeats. In some cases, this can lead to dizziness, shortness of breath, and palpitations (a brief period of a noticeable 'fluttering' or a 'pounding' sensation of the heart).")
                )
            ),
                           
            # side effects: sexual dysfunction
            tags$div(class="card",
                tags$label(class="card-input",
                    tags$input(type="checkbox", class="checkboxes", id="prolactin"),
                    tags$span("Sexual Dysfunction")
                ),
                tags$button(class="action-button shiny-bound-input card-toggle", "aria-expanded"="false",
                    HTML(icons$menuToggle)
                ),
                tags$div(class="card-content", "hidden"="",
                    tags$p("Some medications increase a hormone called prolactin. In women, prolactin plays an important part in pregnancy and an increased level of Prolactin may result in lactation. In men, higher levels of prolactin can lead to difficulties achieving or maintaining an erection. A high level of prolactin is associated with a low sex drive or difficulties performing sexually.")
                )
            ),
                           
            # side effects: stiffness and tremor
            tags$div(class="card",
                tags$label(class="card-input",
                    tags$input(type="checkbox", class="checkboxes", id="extrapyram"),
                    tags$span("Stiffness and Tremor")
                ),
                tags$button(class="action-button shiny-bound-input card-toggle", "aria-expanded"="false",
                    HTML(icons$menuToggle)
                ),
                tags$div(class="card-content", "hidden"="",
                    tags$p("Antipsychotic medications act by blocking to a different degree a chemical in the brain called dopamine. Low levels of dopamine may result in difficulties with movement such as stiffness, tremor or sudden muscle spasms. In some cases dopamine blockers can also cause brief periods of extreme feeling of restlessness.")
                )
            )
                       
        ), # end side effects group
                 
        # render buttons
        pageNavigation(buttons = c("previous","submitEffects")),
                 
        # add script
        tags$script(type="text/javascript", 
            "// call listeners for toggling definitions and focus events
            setTimeout(function(){
                utils.toggleDefinitions();
                utils.toggleSelection();
            }, 75);
        ")
    )
})
