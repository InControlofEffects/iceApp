###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Add one line by package you want to add as dependency
usethis::use_package("tidyr")
usethis::use_package("sodium")
usethis::use_package("rheroicons")
usethis::use_package("browsertools")

## Add modules ----
## Create a module infrastructure in R/
golem::add_module(name = "app_page")
golem::add_module(name = "side_effect_card")
golem::add_module(name = "medication_card")
golem::add_module(name = "navigation")
golem::add_module(name = "page_renderer")
golem::add_module(name = "side_effects_submit")

## Add helper functions ----
## Creates ftc_* and utils_*
# golem::add_fct("helpers")
golem::add_utils("app_logo")
golem::add_utils("error_messages")
golem::add_utils("user_preferences")

## Add internal datasets ----
## If you have data in your package
usethis::use_data_raw(name = "incontrolofeffects_rx", open = FALSE)

## Tests ----
## Add one line by test you want to create
# usethis::use_test("app")


## Code coverage ----
## (You'll need GitHub there)
# usethis::use_github()
# usethis::use_travis()
# usethis::use_appveyor()

