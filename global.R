#'//////////////////////////////////////////////////////////////////////////////
#' FILE: global.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-09-14
#' MODIFIED: 2020-03-24
#' VERSION: 1.2.0
#' PURPOSE: package, data, & utils loading
#' PACKAGES: shiny, shinyjs, stringi, tools, mongolite
#' DATA: data/antipsych_sideeffects.RDS - see analysis on formats for more info
#' NOTES: pkgs must be installed on server. see document on maintaining server
#'//////////////////////////////////////////////////////////////////////////////
options(stringsAsFactors = F)

#' LOAD PACKAGES
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(stringi))
suppressPackageStartupMessages(library(tools))

#' SOURCE DATA
antiPsychDF <- readRDS("server/assets/incontrolofeffects_rx.RDS")

#' SOURCE MODULES
source("client/components/elements/icons.R")
source("client/components/login-screen.R")
source("client/components/elements/page-navigation.R")
# source("modules/server/analytics.R")
# source("server/visualizations.R")


# application options
opts <- list(

    # should login screen be rendered?
    logged = TRUE,

    # app mode: use "dev", "prod", "test"
    mode = "dev"
)