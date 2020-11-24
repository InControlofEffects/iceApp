#'////////////////////////////////////////////////////////////////////////////
#' FILE: accounts.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-08-12
#' MODIFIED: 2020-11-24
#' PURPOSE: code used to create sample accounts dataset
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
saveRDS(accounts, "data-raw/demo_accounts.RDS")
