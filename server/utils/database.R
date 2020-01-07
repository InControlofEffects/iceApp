#'//////////////////////////////////////////////////////////////////////////////
#' FILE: database.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-12-12
#' MODIFIED: 2019-12-12
#' PURPOSE: tools for connecting and saving data to a database
#' STATUS: in.progress
#' PACKAGES: DBI; RSQLite
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////

# ~ 0 ~
# modularize functions
database <- list()

# set connection
database$conn <- DBI::dbConnect(RSQLite::SQLite(), "server/database/side-effects.db")

#'////////////////////////////////////////

# ~ 1 ~
# save data function to a given table
database$save <- function(x, table){
    DBI::dbAppendTable(database$conn, name = table, value = x)
}