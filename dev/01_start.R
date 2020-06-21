# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
########################################
#### CURRENT FILE: ON START SCRIPT #####
########################################

## Fill the DESCRIPTION ----
## Add meta data about your application
golem::fill_desc(
    pkg_name = "inControlofEffects",
    pkg_title = "In Control of Effects",
    pkg_description = "A patient-centered decision making tool for choice of antipsychotic medications",
    author_first_name = "David",
    author_last_name = "Ruvolo",
    author_email = "davidruvolo51@gmail.com",
    repo_url = "https://github.com/InControlofEffects/ice-app"
)

## Set {golem} options ----
golem::set_golem_options()

## Create Common Files ----
## See ?usethis for more information
usethis::use_mit_license(name = "dcruvolo")  # You can set another license here
usethis::use_readme_rmd(open = FALSE)
usethis::use_news_md(open = FALSE)