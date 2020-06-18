#'//////////////////////////////////////////////////////////////////////////////
#' FILE: _login.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-12-11
#' MODIFIED: 2020-06-18
#' PURPOSE: server code for processing login
#' STATUS: working
#' PACKAGES: sodium, browsertools (custom)
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////

# reset signin form error messages
reset_signin_errors <- function() {
    browsertools::inner_text("#signin-form-error-message", "")
    browsertools::hide_elem("#signin-form-error")
    browsertools::remove_css("#username", "invalid")
    browsertools::remove_css("#password", "invalid")
}

# send new message
send_signin_error <- function(string) {
    browsertools::show_elem("#signin-form-error")
    browsertools::inner_text("#signin-form-error-message", string)
}

# onSubmit
observeEvent(input$login, {

    # get input data
    username <- isolate(input$username)
    password <- isolate(input$password)

    # reset error messages
    reset_signin_errors()

    # validate inputs and check credentials
    usr <- which(users$username == username)
    if (username == "" || password == "") {
        if (username == "" && password == "") {
            send_signin_error("No username or password entered")
        } else if (username == "" && !(password == "")) {
            send_signin_error("Username is missing")
            browsertools::add_css("#username", "invalid")

        } else if (!(username == "") && password == "") {
            send_signin_error("Password is missing")
            browsertools::add_css("#password", "invalid")
        } else {
            send_signin_error("Username or password is incorrect")
        }
    } else if (length(usr)) {
        pwd <- sodium::password_verify(users$password[usr], password)
        if (pwd) {
            logged(TRUE)
        } else {
            send_signin_error("Username or password is incorrect")
        }
    } else if (!length(usr)) {
        send_signin_error("The username or password is incorrect")
    } else {
        send_signin_error("Something went wrong. Please try again")
    }
})