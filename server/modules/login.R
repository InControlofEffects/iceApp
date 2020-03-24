#'//////////////////////////////////////////////////////////////////////////////
#' FILE: _login.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-12-11
#' MODIFIED: 2020-03-24
#' PURPOSE: server code for processing login
#' STATUS: working
#' PACKAGES: sodium, browsertools (custom)
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
observeEvent(input$login, {

    # get input data
    username <- isolate(input$username)
    password <- isolate(input$password)

    # reset error messages
    browsertools::inner_html("#error-form", "")
    browsertools::inner_html("#error-username", "")
    browsertools::inner_html("#error-password", "")
    browsertools::remove_css("#username", "invalid")
    browsertools::remove_css("#password", "invalid")

    # validate inputs and check credentials
    usr <- which(users$username == username)
    if (username == "" || password == "") {
        if (username == "" && password == "") {

            # throw error
            browsertools::inner_html(
                elem = "#error-form",
                string = "Error: No username and password was entered."
            )
        } else if (username == "" && !(password == "")) {

                # throw error
                browsertools::inner_html(
                    elem = "#error-username",
                    string = "Error: Username is missing"
                )

                # add invalid class
                browsertools::add_css(
                    elem = "#username",
                    css = "invalid"
                )
            } else if (!(username == "") && password == "") {
                # throw error
                browsertools::inner_html(
                    elem = "#error-password",
                    string = "Error: Password is missing"
                )

                # add invalid class
                browsertools::add_css(
                    elem = "#password",
                    css = "invalid"
                )
            } else {
                # throw error
                browsertools::inner_html(
                    elem = "#error-form",
                    string = "Error: The password or username is incorrect"
                )
            }
    } else if (length(usr)) {

        # verify password
        pwd <- sodium::password_verify(users$password[usr], password)
        if (pwd) {

            # state is TRUE
            logged(TRUE)

        } else {

            # throw error
            browsertools::inner_html(
                elem = "#error-password",
                string = "Error: The password is incorrect"
            )

            # add invalid class
            browsertools::add_css(
                elem = "#password",
                css = "invalid"
            )
        }
    } else if (!length(usr)) {

        # throw error
        browsertools::inner_html(
            elem = "#error-username",
            string = "Error: The username is incorrect"
        )

        # add class
        browsertools::add_css(
            elem = "#username",
            css = "invalid"
        )

    } else {

        # throw error
        browsertools::inner_html(
            elem = "#error-form",
            string = paste0(
                "Error: Something went wrong. Please enter the details again.",
                "If you continue to have problems, contact the study",
                "coordinator."
            )
        )
    }
})