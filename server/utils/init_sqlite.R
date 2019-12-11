#'//////////////////////////////////////////////////////////////////////////////
#' FILE: init_sqlite.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-06-26
#' MODIFIED: 2019-06-26
#' PURPOSE: one-time only init sqlite db
#' PACKAGES: DBI; sqlite
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////

# pkgs
library(DBI)
library(RSQLite)

# set path of database and connect
dbPath <- "database/side-effects.sqlite"
db <- dbConnect(RSQLite::SQLite(), dbPath)

# create table: sessions
sessionNames <- c(
    "app_mode",
    "session_id",
    "session_date",
    "session_start_time"
)

dbCreateTable(conn = db, name = "sessions", fields = sessionNames)



