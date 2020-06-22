## code to prepare `incontrolofeffects_rx` dataset goes here
incontrolofeffects_rx <- readRDS("data-raw/incontrolofeffects_rx.RDS")
usethis::use_data(incontrolofeffects_rx, overwrite = TRUE)
