#'//////////////////////////////////////////////////////////////////////////////
#' FILE: _login.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-12-11
#' MODIFIED: 2019-12-11
#' PURPOSE: server code for processing login 
#' STATUS: working
#' PACKAGES: NA
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
observeEvent(input$login, {

    # get input data
    username <- isolate(input$username)
    password <- isolate(input$password)
    
    # reset error messages
    js$innerHTML("#error-form", "")
    js$innerHTML("#error-username", "")
    js$innerHTML("#error-password", "")
    js$removeCSS("#username", "invalid")
    js$removeCSS("#password", "invalid")
    
    # validate inputs and check credentials
    usr <- which(users$username == username)
    if( username == "" || password == ""){
        if( username == "" && password == ""){
            js$innerHTML("#error-form", "Error: No username and password was entered. These fields cannot be left blank.")
        } else if (username == "" && !(password == "") ){
                js$innerHTML("#error-username", "Error: Username is missing")
                js$addCSS("#username","invalid")
            } else if(!(username == "") && password == "") {
                js$innerHTML("#error-password","Error: Password is missing")
                js$addCSS("#password", "invalid")
            } else {
                js$innerHTML("#error-form", "Error: Something went wrong. Please enter your details again.")
            }
    } else if(length(usr)){
        pwd <- sodium::password_verify(users$password[usr], password)
        if(pwd){
            logged(TRUE)
        } else {
            js$innerHTML("#error-password", "Error: The password is incorrect")
            js$addCSS("#password", "invalid")
        }
    } else if(!length(usr)){
        js$innerHTML("#error-username", "Error: The username is incorrect")
        js$addCSS("#username", "invalid")
    } else {
        js$innerHTML("#error-form", "Error: Something went wrong. Please enter the details again. If you continue to have problems, contact the study coordinator.")
    }
})