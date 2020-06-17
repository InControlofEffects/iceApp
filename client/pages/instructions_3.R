#'//////////////////////////////////////////////////////////////////////////////
#' FILE: instructions_3.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-08
#' MODIFIED: 2020-06-15
#' PURPOSE: 3rd page of instructions
#' PACKAGES: shiny; rheroicons
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
# BUILD
page <- renderUI({
    tags$section(
        id = "instructions-page-3",
        class = "page instructions-page",
        tags$h1("How to use this app"),
        tags$p(
            "If you are concerned about side effects",
            "or anything else related to your medical care,",
            "consult your healthcare provider.",
            "You can revisit these instructions at anytime by tapping the",
            rheroicons::outline$refresh(),
            "icon located at the top of the page."
        ),
        page_nav(buttons = c("previous", "next"))
    )
})