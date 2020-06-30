#' ////////////////////////////////////////////////////////////////////////////
#' FILE: test_analytics.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-06-30
#' MODIFIED: 2020-06-30
#' PURPOSE: generate random data and send to database
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////


#' source class
source("utils/analytics.R")

medications <- readRDS("data/incontrolofeffects_rx.RDS")


#' ~ 0 ~
#' Define Simulations
#' Create a list of methods that can be used for simulating a typical app
#' session
simulations <- list()


#' //////////////////////////////////////

#' function to simulate logging of button clicks
#' @param object an analytics object
#' @param n number of times to repeat
simulations$clicks <- function(object, n = 5) {
    lapply(seq_len(n), function(i) {

        # either button or toggle
        type <- sample(x = c("button", "toggle", "submit"), size = 1)
        event <- paste0(type, "-", i)
        object$capture_click(event, paste0("user clicked ", type))

        Sys.sleep(runif(1, 0.5, 2))
    })
}

#' //////////////////////////////////////

# funtion to simulate random action
simulations$actions <- function(object, n = 5) {
    lapply(seq_len(n), function(i) {
        id <- paste0(sample(c(0:9, letters), size = 6, replace = TRUE), collapse = "")
        action <- paste0("action_", id)
        object$capture_action(
            event = "simulated_action",
            id = action,
            desc = "an action has occurred"
        )
        Sys.sleep(runif(1, 0.5, 2))
    })
}

#' //////////////////////////////////////

#' function to simulate user selections
simulations$selections <- function(object) {

    # create data.frame
    d <- data.frame(
        akathisia = 0,
        anticholinergic = 0,
        antiparkinson = 0,
        prolactin = 0,
        qtc = 0,
        sedation = 0,
        weight_gain = 0
    )

    # randomly set one column to 1
    d[1, sample(c(1:length(d)), size = 1)] <- 1

    # save selections
    object$capture_selections(d)
}

#' //////////////////////////////////////

#' function to simulate results
simulations$results <- function(object) {
    # get unique medications
    meds <- unique(medications$name)

    # create data.frame
    sample_meds <- sample(meds, 6)
    d <- data.frame(
        time = Sys.time(),
        rx_rec_a = sample_meds[1],
        rx_rec_b = sample_meds[2],
        rx_rec_c = sample_meds[3],
        rx_avoid_a = sample_meds[4],
        rx_avoid_b = sample_meds[5],
        rx_avoid_c = sample_meds[6]
    )
    object$capture_results(d)
}


#'//////////////////////////////////////

# primary simulations function
simulations$run <- function(object, trials = 2, n = 2) {
    # print
    cat("Simulation:\n  Starting", trials, "iterations\n  Running...\n  ")
    start <- Sys.time()

    # run
    lapply(seq_len(trials), function(index) {
        iStart <- Sys.time()

        # run events
        simulations$clicks(object, n = n)
        simulations$actions(object, n = n)
        simulations$selections(object)
        simulations$results(object)

        # increment attempts
        object$update_attempts()

        # pause
        iEnd <- Sys.time()
        cat("Completed Trial", index, "(", round((iEnd-iStart)[[1]], 2),"s)\n  ")
        Sys.sleep(runif(1, 0.5, 2))
    })

    # print
    end <- Sys.time()
    cat("Finished in", round((end - start)[[1]], 2), "seconds")

}


#'//////////////////////////////////////

#' run
testSession <- analytics$new()
simulations$run(testSession, trials = 2, n = 5)