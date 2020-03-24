#'////////////////////////////////////////////////////////////////////////////
#' FILE: quit.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-08
#' MODIFIED: 2020-03-24
#' PURPOSE: function component for quit page
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////
page <- renderUI({
    tags$section(
        class = "page",
        tags$h1("Before you go"),
        tags$p(
            "The In Control of Effects app is design to initiate a discussion",
            "between you and your psychiatrist regarding antipsychotic",
            "medications and the risk of side effects. This may be useful",
            "if there are side effects that you are unaware of or would ",
            "like to avoid."
        ),
        tags$p(
            "This app is an experimental clinical research tool that is a",
            "part of ongoing research led by researchers at the University",
            "of Oxford. This app does not replace medical treatment or",
            "consultation with any healthcare professional. Any information",
            "produced by this tool should be discussed with your psychiatrist",
            "as this app does not take into account individual patient",
            "characteristics, pre-existing medical conditions, any current",
            "medical treatment or medications you may already be taking."
        ),
        tags$p(
            "If you are concerned about side effects or anything else",
            "related to your medical care, consult your healthcare provider."
        )
    )
})