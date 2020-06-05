#'//////////////////////////////////////////////////////////////////////////////
#' FILE: instructions_3.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-08
#' MODIFIED: 2020-01-27
#' PURPOSE: 3rd page of instructions
#' PACKAGES: shiny
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
# BUILD
page <- renderUI({
    tags$section(class = "page",
        tags$h1("How to use this app"),
        tags$p(
            "If you are concerned about side effects",
            "or anything else related to your medical care,",
            "consult your healthcare provider.",
            "You can revisit these instructions at anytime by tapping the",
            HTML(icons$restartAlt),
            "icon located at the top of the page.",
            "If you are ready to begin,",
            "press the start button located at the bottom of the page."
        ),
        page_nav(buttons = c("previous", "start"))
    )
})