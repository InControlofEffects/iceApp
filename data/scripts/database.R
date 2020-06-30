#'////////////////////////////////////////////////////////////////////////////
#' FILE: database.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-27
#' MODIFIED: 2020-06-30
#' PURPOSE: all database things
#' STATUS: in.progress
#' PACKAGES: DBI; RSQLite
#' COMMENTS: See utils analytics.R for corresponding function
#'////////////////////////////////////////////////////////////////////////////

# create db
db <- DBI::dbConnect(drv = RSQLite::SQLite(), dbname = "data/ice.db")


#'//////////////////////////////////////

#' ~ 999 ~
#' Create Side Effects Definitions
#' Store the Side Effect IDs to Common Name
side_effect_codes <- data.frame(
    effect_name = c(
        "akathisia",
        "anticholinergic",
        "antiparkinson",
        "prolactic",
        "qtc",
        "sedation",
        "weight_gain"
    ),
    public_name = c(
        "Dry Mouth and Constipation",
        "Feeling Sleepy or Drowsy",
        "Irregular Heartbeat",
        "Restlessness",
        "Sexual Dysfunction",
        "Stiffness and Tremor",
        "Weight Gain"
    )
)

# create
DBI::dbCreateTable(conn = db, name = "definitions", fields = side_effect_codes)
DBI::dbAppendTable(conn = db, name = "definitions", value = side_effect_codes)

#' test
#' DBI::dbFetch(DBI::dbSendQuery(db, "SELECT * FROM definitions"))


#'//////////////////////////////////////

#' ~ 0 ~
#' Create Sessions
#' The sessions table is used for storing records of all user sessions. Entries
#' are dependent on the account data (user type) and application mode.
#' @param id a unique randomized string for the session (see analytics.R)
#' @param mode the application mode (i.e, dev, prod, testing, etc)
#' @param time the time the session started (in relation to the server, !user)
#' @param user_type set in accounts.R, admin, test, dev, etc...
#' @param attempt a counter indicating the n trials the user has done
sessions <- data.frame(
    id = NA,
    mode = NA,
    time = NA,
    user_type = NA,
    attempt = NA
)

# create
DBI::dbCreateTable(conn = db, name = "sessions", fields = sessions)

#' Test
#' DBI::dbFetch(DBI::dbSendQuery(db, "Select * from sessions"))

#'//////////////////////////////////////

#' ~ 1 ~
#' Create Actions
#' The actions table is used for logging app analytics such as button clicks
#' and errors. Use R6 methods `capture_click` and `capture_error` for
#' standarizing data entry.
#' @param id session ID
#' @param attempt a counter indicating the n trials the user has done
#' @param time time of event
#' @param event event type (e.g., click, error)
#' @param event_id an ID for the event (e.g., "login_form")
#' @param event_desc a description for the event (e.g., "missing username")
actions <- data.frame(
    id = NA,
    attempt = NA,
    time = NA,
    event = NA,
    event_id = NA,
    event_desc = NA
)

# create
DBI::dbCreateTable(conn = db, name = "actions", fields = actions)


#'//////////////////////////////////////

#' ~ 2 ~
#' User Selections
#' This table is used to save all user selections across attemps. This will be
#' useful for validation of the algorithm and for future research.
#' @param id session ID
#' @param attempt current user attempt
#' @param time time selections were submitted
#' @param ... binary variables indicating if a side effect was selected (1:yes)
selections <- data.frame(
    id = NA,
    attempt = NA,
    time = NA,
    akathisia = NA,
    anticholinergic = NA,
    antiparkinson = NA,
    prolactin = NA,
    qtc = NA,
    sedation = NA,
    weight_gain = NA
)

# create
DBI::dbCreateTable(conn = db, name = "selections", fields = selections)

#'//////////////////////////////////////

#' ~ 3 ~
#' Medication Results
#' This table will be used to store the top three recommended medications and
#' the top three medications to avoid. Each row is a user attempt and the
#' returned medications in wide format
#' @param id session ID
#' @param attempt current user attempt
#' @param time time results were returned
#' @param rx_rec_a first recommended medication
#' @param rx_rec_b second recommended medication
#' @param rx_rec_c third recommended medication
#' @param rx_avoid_a first medication to avoid
#' @param rx_avoid_b second medication to avoid
#' @param rx_avoid_c third medication to avoid
results <- data.frame(
    id = NA,
    attempt = NA,
    time = NA,
    rx_rec_a = NA,
    rx_rec_b = NA,
    rx_rec_c = NA,
    rx_avoid_a = NA,
    rx_avoid_b = NA,
    rx_avoid_c = NA
)

# create
DBI::dbCreateTable(conn = db, name = "results", fields = results)

# check
DBI::dbListTables(db)


#'//////////////////////////////////////

#' disconnect
DBI::dbDisconnect(db)