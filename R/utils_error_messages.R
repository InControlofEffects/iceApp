# show error message
show_error_message <- function(message) {
    browsertools::show_elem("#side-effects-error-box")
    browsertools::inner_text("#side-effects-error-message", message)
}

# hide error message
hide_error_message <- function() {
    browsertools::hide_elem("#side-effects-error-box")
    browsertools::inner_text("#side-effects-error-message", "")
}