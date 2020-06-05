#'////////////////////////////////////////////////////////////////////////////
#' FILE: refresh_assets.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-04
#' MODIFIED: 2020-06-04
#' PURPOSE: refresh medication data and user_preferences script
#' STATUS: complete
#' PACKAGES: NA
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' ~ 0 ~
# remove current files
files <- list.files("server/assets", full.names = TRUE)
sapply(files, file.remove)

#' ~ 1 ~
#' clone files
file.copy("../ice-data/data/incontrolofeffects_rx.RDS", "server/assets/")
file.copy("../ice-data/scripts/user_preferences.R", "server/assets/")