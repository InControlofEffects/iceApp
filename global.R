#'//////////////////////////////////////////////////////////////////////////////
#' FILE: global.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-09-14
#' MODIFIED: 2020-01-07
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

#' SOURCE MODULES
source("src/components/elements/icons.R")
source("src/components/login-screen.R")
source("src/components/elements/page-navigation.R")
# source("modules/server/analytics.R")
# source("server/visualizations.R")