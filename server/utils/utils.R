#'//////////////////////////////////////////////////////////////////////////////
#' FILE: utils.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-09-19
#' MODIFIED: 2019-06-26
#' PURPOSE: misc functions for shiny app
#' PACKAGES: stringi
#' NOTES:
#'//////////////////////////////////////////////////////////////////////////////

# DEFINE A FUNCTION THAT GENERATES A RANDOM ID
generateId <- function(length){
    id <- stringi::stri_rand_strings(n = 1, length = length)   
    as.character(id)
}


# DEFINE A FUNCTION THAT SAVES DATA INTO LOCAL DATABASE
saveData <- function(data, table) {
    # Connect to the database
    db <- dbConnect(SQLite(), dbPath)
    
    # Construct the update query by looping over the data fields
    query <- sprintf(
        "INSERT INTO %s (%s) VALUES ('%s')",
        table,
        paste(names(data), collapse = ", "),
        paste(data, collapse = "', '")
    )
    
    # Submit the update query and disconnect
    dbGetQuery(db, query)
    dbDisconnect(db)
}

# DEFINE A FUNCTION THAT CONVERTS INPUT IDs FOR SIDE EFFECTS to USER-FRIENDLY NAMES
recodeSideEffects <- function(string){

    # lower input element
    s <- tolower(string)

    # run switch
    out <- switch(
        s,
        "weight" = "weight gain",
        "qtc" = "irregular heartbeat",
        "prolactin" = "sexual dysfunction",
        "extrapyram" = "stiffness and tremor"
    )

    # return and ensure output is of character class
    as.character(out)
}