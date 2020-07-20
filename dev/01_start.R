#'////////////////////////////////////////////////////////////////////////////
#' FILE: 01_start.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-07-20
#' MODIFIED: 2020-07-20
#' PURPOSE: package init
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

# define meta data
golem::fill_desc(
  pkg_name = "iceApp",
  pkg_title = "In Control of Effects Application",
  pkg_description = "A decision aid for the choice of antipsychotics.",
  author_first_name = "David",
  author_last_name = "Ruvolo",
  author_email = "davidruvolo51@gmail.com",
  repo_url = NULL
)

# Set {golem} options ----
golem::set_golem_options()

# Create Common Files
usethis::use_github_action_check_standard()
usethis::use_travis()
usethis::use_code_of_conduct()

# Init Testing Infrastructure
golem::use_recommended_tests()

# Add helper functions
golem::use_utils_ui()
golem::use_utils_server()
