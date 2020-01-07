#'//////////////////////////////////////////////////////////////////////////////
#' FILE: index.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-08-29
#' MODIFIED: 2020-01-07
#' PURPOSE: generic R template for writing UI compents into based on Login status
#' PACKAGES: *see global*
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
# main app
app <- function(){
    tagList(
            
        # accessiblity link
        tags$a(class="screen-reader-content", "skip to main content", href="#main"),

        # navigation bar
        tags$nav(class="navbar",

            # site menu
            tags$ul(class="menu",

                # brand link - logo + application name
                tags$li(class="menu-item brand-item",
                    tags$a(class="menu-link", href="https://incontrolofeffects.com",
                        tags$img(class="logo", src="images/Logo.svg", alt="in control of effects"),
                        "In Control of Effects"
                    )
                ),

                # settings - restart application
                tags$li(class="menu-item",
                    tags$button(id="restart", class="action-button shiny-bound-input", title="Restart", `aria-label`="restart application", HTML(icons$restart))
                )
            )
        ),

        # progress bar
        tags$figure(class="progressBar",
            tags$figcaption(class="screen-reader-text", "Progress bar"),
            tags$div(id="bar", class="bar", role="progressbar", `aria-valuenow`="0", `aria-valuemin`="0", `aria-valuemax`="100", `aria-valuetext`="")
        ),
                
        # main output
        tags$main(class="main", id="main",
            uiOutput("currentPage")
        )
    )
}