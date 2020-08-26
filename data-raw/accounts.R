#'////////////////////////////////////////////////////////////////////////////
#' FILE: accounts.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-08-12
#' MODIFIED: 2020-08-12
#' PURPOSE: code used to create accounts dataset
#' STATUS: working
#' PACKAGES: sodium
#' COMMENTS: Use this to provide "some" level of access rights. This isn't
#' the most secure method and I would recommend using something more robust.
#' The purpose of this approach is to "control" who can use the app.
#'////////////////////////////////////////////////////////////////////////////

#' create a sample account for demonstration purposes
#' Do not commit this to GH and do not save file
accounts <- data.frame(
    username = c("wallaby"),
    password = c("wall2200"), # sample password
    type = c("demo")
)

# encrypt password
accounts$password <- sapply(accounts$password, sodium::password_store)

# save
usethis::use_data(accounts, overwrite = TRUE, internal = TRUE)
