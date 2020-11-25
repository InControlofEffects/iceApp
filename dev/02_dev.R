#' ////////////////////////////////////////////////////////////////////////////
#' FILE: 02_dev.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-07-20
#' MODIFIED: 2020-11-25
#' PURPOSE: manage scripts, packages, files, data, etc.
#' STATUS: ongoing
#' PACKAGES: usethis; golem
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////

# install packages from GitHub
remotes::install_github("davidruvolo51/browsertools@*release")
remotes::install_github("davidruvolo51/rheroicons@*release")
remotes::install_github("InControlofEffects/iceComponents@*release")
remotes::install_github("InControlofEffects/iceData@*release")
remotes::install_github("davidruvolo51/pkgbump@*release")

# add packages to DESCRIPTION
usethis::use_package("shiny", min_version = TRUE)
usethis::use_package("htmltools", min_version = TRUE)
usethis::use_package("browsertools", min_version = TRUE)
usethis::use_package("rheroicons", min_version = TRUE)
usethis::use_package("iceData", min_version = TRUE)
usethis::use_package("iceComponents", min_version = TRUE)
usethis::use_package("sodium", min_version = TRUE)


# version number management
pkgbump::set_pkgbump(
    files = c(
        "DESCRIPTION",
        "package.json",
        "R/app_server.R"
    )
)
pkgbump::pkgbump(version = "0.0.8")

#'//////////////////////////////////////

#' ~ 99 ~
#' Ignore Files
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