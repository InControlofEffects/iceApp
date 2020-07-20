#'////////////////////////////////////////////////////////////////////////////
#' FILE: global.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-09-14
#' MODIFIED: 2020-06-27
#' PURPOSE: global R file
#' STATUS: working
#' PACKAGES: see below
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' pkgs
suppressPackageStartupMessages(library(shiny))

#' SOURCE DATA
accounts <- readRDS("data/accounts.RDS")
incontrolofeffects_rx <- readRDS("data/incontrolofeffects_rx.RDS")

#' MODULES
source("modules/mod_login.R")
source("modules/mod_medication_card.R")
source("modules/mod_side_effect_card.R")

#' UTILS
source("utils/analytics.R")
source("utils/user_preferences.R")
source("utils/utils.R")

# PAGES
source("components/app_pages.R")