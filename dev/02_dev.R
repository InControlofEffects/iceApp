#' ////////////////////////////////////////////////////////////////////////////
#' FILE: 02_dev.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-07-20
#' MODIFIED: 2020-11-16
#' PURPOSE: manage scripts, packages, files, data, etc.
#' STATUS: ongoing
#' PACKAGES: usethis; renv; golem
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////

# revn init
renv::init(settings = list(snapshot.type = "explicit"))
renv::snapshot()
renv::restore()

# install packages from GitHub
remotes::install_github("davidruvolo51/browsertools")
remotes::install_github("davidruvolo51/rheroicons")
remotes::install_github("InControlofEffects/iceComponents")
remotes::install_github("InControlofEffects/iceData", auth_token = "")
remotes::install_github("davidruvolo51/pkgbump")

# add packages
usethis::use_package("shiny", min_version = TRUE)
usethis::use_package("htmltools", min_version = TRUE)
usethis::use_package("browsertools", min_version = TRUE)
usethis::use_package("rheroicons", min_version = TRUE)
usethis::use_package("iceData", min_version = TRUE)
usethis::use_package("iceComponents", min_version = TRUE)
usethis::use_package("sodium", min_version = TRUE)

# add modules (to R/)
golem::add_module(name = "login")
golem::add_module(name = "medication_card")
golem::add_module(name = "navigation")
golem::add_module(name = "errors")
golem::add_module(name = "validate_effects")

# add interal dataset
usethis::use_data_raw(name = "accounts")

## Tests ----
## Add one line by test you want to create
usethis::use_test("app")


#'//////////////////////////////////////

#' ~ 2 ~
# version number management
pkgbump::set_pkgbump(
    files = c(
        "DESCRIPTION",
        "package.json",
        "R/app_server.R"
    )
)

pkgbump::pkgbump(version = "0.0.6")


#'//////////////////////////////////////

#' ~ 3 ~
# clean up logs post dev
sapply(
    list.files("logs", pattern = "analytics_", full.names = TRUE),
    file.remove
)

#'//////////////////////////////////////

#' ~ 99 ~
#' Ignore Files

# use ignore files
gitignore <- c(
    "node_modules",
    ".Rproj.user",
    ".Rhistory",
    ".RData",
    ".Ruserdata",
    "renv/library/",
    "renv/python/",
    "renv/staging/"
)

usethis::use_git_ignore(gitignore)
usethis::use_build_ignore(
    files = c(
        gitignore,
        "config",
        "data-raw",
        "dev",
        "logs",
        "src",
        ".babelrc",
        "pkgbump.config.json",
        "app.R",
        "CODE_OF_CONDUCT.md",
        "iceApp.code-workspace",
        "incontrolofeffects.png",
        "package.json",
        "postcss.config.js",
        "webpack.config.js",
        "yarn.lock"
    )
)