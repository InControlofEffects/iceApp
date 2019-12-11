#'//////////////////////////////////////////////////////////////////////////////
#' FILE: instructions_2.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-08
#' MODIFIED: 2019-12-11
#' PURPOSE: second page of instructions
#' PACKAGES: shiny
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
# BUILD
page <- renderUI({
    tags$section(class="page",

        # content
        tags$h1("How to use this app"),
        tags$p("The results page will show a list of recommend medications and a list of medications to avoid. Recommended medications are less likely to cause the side effects that you selected whereas medications to avoid, will likely cause the side effects that you want to avoid. Tap or click the name of the medication for more information."),

        # render buttons
        pageNavigation(buttons = c("previous", "next"))
    )
})