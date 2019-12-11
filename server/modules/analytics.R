#'//////////////////////////////////////////////////////////////////////////////
#' FILE: analytics.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-13
#' MODIFIED: 2019-06-13
#' PURPOSE: analytics tracking for app
#' PACKAGES: shiny
#' COMMENTS: analytics functions can be found in utils.R
#'//////////////////////////////////////////////////////////////////////////////


# DEFINE A FUNCTION THAT GENERATES A RANDOM ID
generateId <- function(length){
    id <- stringi::stri_rand_strings(n = 1, length = length)   
    as.character(id)
}

# ~ 0 ~
# INIT PRIMARY SESSION INFORMATION
analytics_primary <- data.frame(
    app_mode = "development",
    session_id = generateId(42),           # a random id for each session (for grouping attempts)
    session_date = Sys.Date(),            # the data the session was started (based on server location)
    session_start_time = Sys.time(),      # the time the session was started (based on server location)
    stringsAsFactors = FALSE
)

# save primary analytics in sessions table
# saveData(data = analytics_primary, table = "sessions")

#'////////////////////////////////////////

# ~ 1 ~
# INIT ALL ANALYTICS VARIABLES

# init analytics vars for attempts
session_attempt_id <- reactiveVal(id = generateId(4))
session_attempts <- reactiveVal(0)         # a counter for if the restart button was clicked

# define side effects information button counters
info_btn_clicks_weightgain <- reactiveVal(0)        # weight gain info btn opened/closed
info_btn_clicks_heartbeat <- reactiveVal(0)         # qtc info btn opened/closed
info_btn_clicks_sexdys <- reactiveVal(0)            # sex dysfunction info btn opened/closed
info_btn_clicks_extrapyram <- reactiveVal(0)        # extra pyram info btn opened/closed


#'////////////////////////////////////////

#' TRACK BUTTON CLICKS
#' increment side effects definition button clicks (update reactive values)
#' an odd number = left open; even number = open and closed

# NOTES: CHANGE THE INPUTS NAMES AS THESE REFLECT THE SIDE EFFECTS INPUTS NOT THE INFO BUTTON TOGGLES

# weight gain
observeEvent(input$weight, {
    new_weightgain_value <- info_btn_clicks_weightgain() + 1
    info_btn_clicks_weightgain(new_weightgain_value);
}, ignoreInit = TRUE)
    
# irregular heartbeat
observeEvent(input$qtc, {
    new_qtc_value <- info_btn_clicks_heartbeat() + 1 
    info_btn_clicks_heartbeat(new_qtc_value)
}, ignoreInit = TRUE)
    
# sexual dysfunction
observeEvent(input$prolactin, {
    new_prolactin_value <- info_btn_clicks_sexdys() + 1
    info_btn_clicks_sexdys(new_prolactin_value)
}, ignoreInit = TRUE)
    
# extra-pyramidal 
observeEvent(input$extrapyram, {
    new_extra_pyram_value <- info_btn_clicks_extrapyram() + 1
    info_btn_clicks_extrapyram(new_extra_pyram_value)
}, ignoreInit = TRUE)