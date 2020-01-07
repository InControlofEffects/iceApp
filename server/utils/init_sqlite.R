#'//////////////////////////////////////////////////////////////////////////////
#' FILE: init_sqlite.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-26
#' MODIFIED: 2019-12-12
#' PURPOSE: one-time only init sqlite db
#' STATUS: in.progress
#' PACKAGES: DBI; sqlite
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////

# pkgs
# suppressPackageStartupMessages(library(DBI))
# suppressPackageStartupMessages(library(RSQLite))

# set db path
dbPath <- "server/database/side-effects.db"
db <- DBI::dbConnect(drv = RSQLite::SQLite(), dbname = dbPath)

#'////////////////////////////////////////

# ~ 1 ~
# create table: sessions
sessions <- data.frame(
    app_mode = NA,
    session_id = NA,
    session_date = NA,
    session_start_time = NA,
    session_user_type = NA,
    stringsAsFactors = FALSE
)


# create
DBI::dbCreateTable(conn = db, name = "sessions", fields = sessions)

#'////////////////////////////////////////

# ~ 2 ~
# create table: attempts
attempts <- data.frame(
    session_id = NA,
    session_attempt_id = NA,
    session_attempt = NA,
    session_date = NA,
    session_start_time = NA,
    stringsAsFactors = FALSE
)

# create
DBI::dbCreateTable(conn = db, name = "attempts", fields = attempts)

#'////////////////////////////////////////

# ~ 3 ~
# create table: selections
selections <- data.frame(
    session_id = NA,
    session_attempt_id = NA,
    se_weight = NA,
    se_qtc = NA,
    se_prolactin = NA,
    se_extrapyram = NA,
    result_rec_1 = NA,
    result_rec_2 = NA,
    result_rec_3 = NA,
    result_avoid_1 = NA,
    result_avoid_2 = NA,
    result_avoid_3 = NA,
    stringsAsFactors = FALSE
)

# create
DBI::dbCreateTable(conn = db, name = "selections", fields = selections)

#'////////////////////////////////////////

# ~ 4 ~
# create table: button clicks
buttons <- data.frame(
    session_id = NA,
    session_attempt_id = NA,
    button_type = NA,
    button_click_time = NA,
    stringsAsFactors = FALSE
)

# create 
DBI::dbCreateTable(conn = db, name = "buttons", fields = buttons)

#'////////////////////////////////////////

# CHECK
DBI::dbListTables(db)
DBI::dbListFields(db, "attempts")
DBI::dbListFields(db, "buttons")
DBI::dbListFields(db, "selections")
DBI::dbListFields(db, "sessions")


# DISCONNECT
DBI::dbDisconnect(db)
