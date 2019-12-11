#'//////////////////////////////////////////////////////////////////////////////
#' FILE: instructions_1.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-08
#' MODIFIED: 2019-12-11
#' PURPOSE: page 1 instructions 
#' PACKAGES: shiny
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
# BUILD
page <- renderUI({
    tags$section(class = "page",
        
        # content
        tags$h1("How to use this app"),
        tags$p("In a moment, you will be presented a list of side effects. Select the side effects that you definitely do not want or the ones that you would like to avoid. Tap or click the name of the side effect to select it. Click the",HTML(icons$menuToggle), "icon to view more information about each side effect. When you are ready, press the submit button to view the results."),
        
        # render buttons
        pageNavigation(buttons = "next")
    )
})