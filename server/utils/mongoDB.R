#' MONGO DB
library(mongolite)
options(mongodb = list(
    "host" = "ds121965.mlab.com:21965",
    "username" = "iceAdmin",
    "password" = "4fGhddUZr6{iiajXjony*M3Z"
))

databaseName <- "ice_resp_db"
collectionName <- "user_data"

# saveData <- function(data) {
#     # Connect to the database
#     db <- mongo(collection = collectionName,
#                 url = sprintf(
#                     "mongodb://%s:%s@%s/%s",
#                     options()$mongodb$username,
#                     options()$mongodb$password,
#                     options()$mongodb$host,
#                     databaseName))
#     # Insert the data into the mongo collection as a data.frame
#     data <- as.data.frame((data))
#     db$insert(data)
# }

loadData <- function() {
    # Connect to the database
    db <- mongo(collection = collectionName,
                url = sprintf(
                    "mongodb://%s:%s@%s/%s",
                    options()$mongodb$username,
                    options()$mongodb$password,
                    options()$mongodb$host,
                    databaseName))
    # Read all the entries
    data <- db$find()
    data
}

iceRESPS <- loadData()

