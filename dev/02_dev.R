#' ////////////////////////////////////////////////////////////////////////////
#' FILE: 02_dev.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-07-20
#' MODIFIED: 2020-07-20
#' PURPOSE: manage scripts, packages, files, data, etc.
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////

# add packages
usethis::use_package("shiny")
usethis::use_package("browsertools")
usethis::use_package("rheroicons")
usethis::use_package("iceData")

# add modules (to R/)
golem::add_module(name = "mod_accordion")
golem::add_module(name = "mod_login")
golem::add_module(name = "mod_medication_card")
golem::add_module(name = "mod_navigation")
golem::add_module(name = "mod_side_effect_card")

# add interal dataset
usethis::use_data_raw(name = "accounts")

## Tests ----
## Add one line by test you want to create
usethis::use_test("app")