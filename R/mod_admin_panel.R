#' admin panel
#'
#' UI for admin panel for managing user accounts
#'
#' @param id id for the module
#'
#' @noRd
mod_admin_panel_ui <- function(id) {
    ns <- ns("admin")

    tagList(
        tags$h2("Admin Panel"),
        tags$p(
            "Create new user accounts or manage existing ones.",
            "This page is under construction."
        ),
        tags$ul(
            class = "menu",
            tags$li(
                class = "menu-item",
                tags$button(
                    id = "add",
                    class = "shiny-bound-input action-button default",
                    rheroicons::icons$user_add(
                        type = "solid",
                        aria_hidden = TRUE
                    ),
                    "Add Account"
                )
            )
        )
    )

}


#' admin server core
#'
#' body of the module server
#'
#' @param input required shiny argument
#' @param output required shiny argument
#' @param session required shiny argument
#' @param data accounts dataset to render
#'
#' @noRd
# mod_admin_panel_server_core <- function(input, output, session, data) {
# }


#' admin panel server
#'
#' server module for admin panel core
#'
#' @param id an ID for the module
#' @param data accounts dataset to render
#'
#' @noRd
# mod_admin_panel_server <- function(id, data) {
#     moduleServer(
#         id,
#         mod_admin_panel_server_core
#     )
# }