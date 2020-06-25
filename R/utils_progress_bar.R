# Function to update progress bar
updateProgressBar <- function(elem = "bar", now, max = length(pages)) {
    session <- shiny::getDefaultReactiveDomain()
    session$sendCustomMessage(
        type = "updateProgressBar",
        message = list(
            elem = elem,
            now = now,
            max = max
        )
    )
}