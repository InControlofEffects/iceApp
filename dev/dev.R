#'////////////////////////////////////////////////////////////////////////////
#' FILE: dev.R
#' AUTHOR: David Ruvolo
#' CREATED: 2021-04-10
#' MODIFIED: 2021-04-10
#' PURPOSE: workspace/package management
#' STATUS: in.progress
#' PACKAGES: usethis; devtools
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

# pkgs
# install.packages("usethis")
# install.packages("devtools")
# install.packages("remotes")
# install.packages("languageserver")
usethis::edit_r_environ() # add GITHUB_PAT

# remotes::install_github("davidruvolo51/browsertools@*release")
# remotes::install_github("InControlofEffects/iceComponents@*release")
# remotes::install_github("InControlofEffects/iceData@*release")
# install.packages("rheroicons")

usethis::use_package("config")
usethis::use_package("golem")
usethis::use_package("shiny", min_version = TRUE)
usethis::use_package("htmltools", min_version = TRUE)
usethis::use_package("browsertools", min_version = TRUE)
usethis::use_package("rheroicons")
usethis::use_package("iceData", min_version = TRUE)
usethis::use_package("sodium", min_version = TRUE)
usethis::use_package("iceComponents", min_version = TRUE)
usethis::use_package("processx")
usethis::use_package("pkgload")

#'//////////////////////////////////////

# run dev

options(golem.app.prod = FALSE, shiny.port = 8000, shiny.launch.browser = FALSE)

# Detach all loaded packages and clean your environment
golem::detach_all_attached()

# Document and reload your package
golem::document_and_reload()

# Run the application
run_app(
    use_analytics = FALSE,
    analytics_outdir = "logs/",
    users_db_path = "data-raw/demo_accounts.RDS"
)

#'//////////////////////////////////////

#' ~ 99 ~
#' Misc Config

# version number management
pkgbump::set_pkgbump(
    files = c(
        "DESCRIPTION",
        "package.json",
        "R/app_server.R"
    )
)
pkgbump::pkgbump(version = "0.0.8")

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