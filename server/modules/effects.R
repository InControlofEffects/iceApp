#'//////////////////////////////////////////////////////////////////////////////
#' FILE: submit_effects.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-08-30
#' MODIFIED: 2020-06-04
#' PURPOSE: primary server code for handling side effect selection and results
#' PACKAGES: shiny
#' COMMENTS: uses server/utils/patientPrefs.R
#'//////////////////////////////////////////////////////////////////////////////

#' ~ 0 ~
#' Functions for Communicating with Client via JS


# opening/closing definitions
toggle_definition <- function(id) {
    session$sendCustomMessage("toggle_definition", list(id = id))
}

# select card
select_effect <- function(id) {
    session$sendCustomMessage("select_effect", list(id = id))
}

# deselect card
deselect_effect <- function(id) {
    session$sendCustomMessage("deselect_effect", list(id = id))
}

# resetting side effects
reset_side_effects <- function() {
    shiny::updateCheckboxInput(session, "akathisia", value = 0)
    shiny::updateCheckboxInput(session, "anticholinergic", value = 0)
    shiny::updateCheckboxInput(session, "antiparkinson", value = 0)
    shiny::updateCheckboxInput(session, "extrapyram", value = 0)
    shiny::updateCheckboxInput(session, "prolactin", value = 0)
    shiny::updateCheckboxInput(session, "qtc", value = 0)
    shiny::updateCheckboxInput(session, "sedation", value = 0)
    shiny::updateCheckboxInput(session, "weight_gain", value = 0)
    session$sendCustomMessage(type = "reset_side_effects", "event")
}

# hide error message
hide_error_message <- function() {
    browsertools::inner_text("#side-effects-error-message", "")
    browsertools::hide_elem("#side-effects-error-box")
}

# show error message
show_error_message <- function(error) {
    browsertools::show_elem("#side-effects-error-box")
    browsertools::inner_text("#side-effects-error-message", error)
}

#'//////////////////////////////////////

#' ~ 1 ~
# Events for Akathisia Card

# make selection
observeEvent(input$akathisia, {
    if (input$akathisia) select_effect(id = "akathisia")
    if (!input$akathisia) deselect_effect(id = "akathisia")
}, ignoreInit = TRUE, ignoreNULL = TRUE)

# toggle definition + log event
observeEvent(input$`card-akathisia-btn`, {
    toggle_definition(id = "akathisia")
}, ignoreInit = TRUE)

#'//////////////////////////////////////

#' ~ 2 ~
# Events for Anticholinergic Card

# make selection
observeEvent(input$anticholinergic, {
    if (input$anticholinergic) select_effect(id = "anticholinergic")
    if (!input$anticholinergic) deselect_effect(id = "anticholinergic")
}, ignoreInit = TRUE, ignoreNULL = TRUE)


# toggle definition + log event
observeEvent(input$`card-anticholinergic-btn`, {
    toggle_definition(id = "anticholinergic")
}, ignoreInit = TRUE)

#'//////////////////////////////////////

#' ~ 3 ~
#' Events for Antiparkinson Card

# make selection
observeEvent(input$antiparkinson, {
    if (input$antiparkinson) select_effect(id = "antiparkinson")
    if (!input$antiparkinson) deselect_effect(id = "antiparkinson")
}, ignoreInit = TRUE, ignoreNULL = TRUE)

# toggle definition + log event
observeEvent(input$`card-antiparkinson-btn`, {
    toggle_definition(id = "antiparkinson")
}, ignoreInit = TRUE)

#'//////////////////////////////////////

#' ~ 4 ~
#' Events for Prolactin Card

# make selection
observeEvent(input$prolactin, {
    if (input$prolactin) select_effect(id = "prolactin")
    if (!input$prolactin) deselect_effect(id = "prolactin")
}, ignoreInit = TRUE, ignoreNULL = TRUE)

# toggle definition + log event
observeEvent(input$`card-prolactin-btn`, {
    toggle_definition(id = "prolactin")
}, ignoreInit = TRUE)

#'//////////////////////////////////////

#' ~ 5 ~
#' Events for QTC Card

# make selection
observeEvent(input$qtc, {
    if (input$qtc) select_effect(id = "qtc")
    if (!input$qtc) deselect_effect(id = "qtc")
}, ignoreInit = TRUE, ignoreNULL = TRUE)

# toggle definition + log event
observeEvent(input$`card-qtc-btn`, {
    toggle_definition(id = "qtc")
}, ignoreInit = TRUE)

#'//////////////////////////////////////

#' ~ 6 ~
#' Events for Sedation Card

# make selection
observeEvent(input$sedation, {
    if (input$sedation) select_effect(id = "sedation")
    if (!input$sedation) deselect_effect(id = "sedation")
}, ignoreInit = TRUE, ignoreNULL = TRUE)

# toggle definition + log event
observeEvent(input$`card-sedation-btn`, {
    toggle_definition(id = "sedation")
}, ignoreInit = TRUE)

#'//////////////////////////////////////

#' ~ 7 ~
#' Events for Weight Gain

# make selection
observeEvent(input$weight_gain, {
    if (input$weight_gain) select_effect(id = "weight_gain")
    if (!input$weight_gain) deselect_effect(id = "weight_gain")
}, ignoreInit = TRUE, ignoreNULL = TRUE)

# toggle definition + log event
observeEvent(input$`card-weight_gain-btn`, {
    toggle_definition(id = "weight_gain")
}, ignoreInit = TRUE, ignoreNULL = TRUE)

#'//////////////////////////////////////

#' additional options events
observeEvent(input$`additional-options`, {
    browsertools::toggle_elem(elem = "#additional-options-fieldset")
})


#'//////////////////////////////////////

# on submission
# observeEvent(input$submitEffects, {

#     # hide error
#     hide_error_message()

#     #' gather selections and order in alphabetical order by id
#     selection <- data.frame(
#         akathisia = ifelse(input$akathisia, 1, 0),
#         anticholinergic = ifelse(input$anticholinergic, 1, 0),
#         antiparkison = ifelse(input$antiparkinson, 1, 0),
#         prolactin = ifelse(input$prolactin, 1, 0),
#         qtc = ifelse(input$qtc, 1, 0),
#         sedation = ifelse(input$sedation, 1, 0),
#         weight_gain = ifelse(input$weight_gain, 1, 0),
#         stringsAsFactors = FALSE
#     )

#     # check the number of inputs and throw error message
#     # if number of items greater than 1, otherwise, process
#     # inputs and return results
#     if (sum(selection[1, ]) == 0) {

#         # throw error
#         browsertools::scroll_to()
#         browsertools::console_error(
#             message = "Selection Error: no selections were detected."
#         )
#         show_error_message(
#             paste0(
#                 "No selections were made.",
#                 " You must select one side effect"
#             )
#         )

#         # reset side effects
#         reset_side_effects()

#     } else if (sum(selection[1, ]) >= 2) {

#         # throw error
#         browsertools::scroll_to()
#         browsertools::console_error(
#             message = paste0(
#                 "Selection Error: too many side effects were selected.",
#                 "User is allowed one selection."
#             )
#         )
#         show_error_message(
#             paste0(
#                 "Too many side effects were selected. ",
#                 "You can only select one side effect."
#             )
#         )

#         # reset side effects
#         reset_side_effects()

#     } else {

#         #'////////////////////////////////////////
#         # process page navigation from side effects to results page

#         # increment page number
#         new_page_num <- page_num() + 1
#         page_num(new_page_num)

#         # load next page
#         output$current_page <- renderUI({
#             pages[[page_num()]]()
#         })

#         # run function to update progress bar
#         session$sendCustomMessage(
#             type = "updateProgressBar",
#             c(1, file_length, page_num())
#         )

#         #'////////////////////////////////////////

#         # run user inputs through function
#         results <- as.data.frame(
#             user_preferences(
#                 data = antiPsychDF,
#                 weights = selection[1, ],
#                 return_all = FALSE
#             )
#         )

#         #'////////////////////////////////////////
#         # send via innerHTML(id) - top 3
#         browsertools::inner_text(
#             elem = "#results-label-rec-1",
#             string = results[1, "name"],
#             delay = 250
#         )
#         browsertools::inner_html(
#             elem = "#results-label-rec-2",
#             string = results[2, "name"],
#             delay = 250
#         )
#         browsertools::inner_html(
#             elem = "#results-label-rec-3",
#             string = results[3, "name"],
#             delay = 250
#         )

#         #'////////////////////////////////////////
#         # send via innerHTML(id) - top 3 - rev order in worst score
#         # (e.g., worst = highest num)
#         browsertools::inner_html(
#             elem = "#results-label-avoid-1",
#             string = results[NROW(results), "name"],
#             delay = 250
#         )
#         browsertools::inner_html(
#             elem = "#results-label-avoid-2",
#             string = results[NROW(results) - 1, "name"],
#             delay = 250
#         )
#         browsertools::inner_html(
#             elem = "#results-label-avoid-3",
#             string = results[NROW(results) - 2, "name"],
#             delay = 250
#         )

#         # reset view to top
#         browsertools::scroll_to()
#     }
# }, ignoreInit = TRUE)
