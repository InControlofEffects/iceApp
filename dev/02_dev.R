#' ////////////////////////////////////////////////////////////////////////////
#' FILE: 02_dev.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-07-20
#' MODIFIED: 2020-08-03
#' PURPOSE: manage scripts, packages, files, data, etc.
#' STATUS: ongoing
#' PACKAGES: usethis; renv; golem
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////

# revn init
renv::init(settings = list(snapshot.type = "explicit"))
renv::snapshot()


# add packages
usethis::use_package("shiny", min_version = TRUE)
usethis::use_package("htmltools", min_version = TRUE)
usethis::use_package("browsertools", min_version = TRUE)
usethis::use_package("rheroicons", min_version = TRUE)
usethis::use_package("iceData", min_version = TRUE)
usethis::use_package("iceComponents", min_version = TRUE)
usethis::use_package("sodium", min_version = TRUE)

# add modules (to R/)
golem::add_module(name = "mod_login")
golem::add_module(name = "mod_medication_card")
golem::add_module(name = "mod_navigation")
golem::add_module(name = "mod_errors")

# add interal dataset
usethis::use_data_raw(name = "accounts")

## Tests ----
## Add one line by test you want to create
usethis::use_test("app")