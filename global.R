#'//////////////////////////////////////////////////////////////////////////////
#' FILE: global.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-09-14
#' MODIFIED: 2018-11-24
#' VERSION: 1.2.0
#' PURPOSE: package, data, & utils loading
#' PACKAGES: shiny, shinyjs, stringi, tools, mongolite
#' DATA: data/antipsych_sideeffects.RDS - see analysis on formats for more info
#' NOTES: pkgs must be installed on server. see document on maintaining server 
#'//////////////////////////////////////////////////////////////////////////////
#' GLOBAL OPTIONS:
options(stringsAsFactors = F)

#' LOAD PACKAGES
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(stringi))
suppressPackageStartupMessages(library(tools))

#' SOURCE DATA
antiPsychDF <- readRDS("server/data/antipsych_sideEffects.RDS")

#' LOAD FUNCTIONS
# source("utils/utils.R", local = TRUE)
# source("utils/patientPrefs.R", local = TRUE)

#' LOAD USERS
access <- data.frame(
    username = c("active", "expired"),
    password = c("12345","12345"),
    authority= c("standard","standard"),
    created = c(as.Date("2019-08-27"), as.Date("2019-09-03")),
    expires = c(as.Date("2025-12-31"), as.Date("2019-01-01")),
    stringsAsFactors = FALSE
)

#' SOURCE MODULES
source("src/components/elements/icons.R")
source("src/components/login-screen.R")
source("src/components/elements/page-navigation.R")
# source("modules/server/analytics.R")
# source("server/visualizations.R")