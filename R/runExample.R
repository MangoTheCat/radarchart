
#' Run an example Shiny app
#'
#' The radarchart package contains a number of demo Shiny apps to illustrate how
#' to use the plots. The code is in \code{inst/shiny-examples/} and running this
#' function will allow quick access to the apps.
#'
#' @param example the name of the example. Choose from "basic" or "options".
#'
#' @export
#'
#' @examples
#' \dontrun{
#' runExample("basic")
#' }
runExampleApp <- function(example) {
  
  # Check for Shiny:
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("The package: \"shiny\" is needed to run these examples. Please install.",
         call. = FALSE)
  }
  
  # Check the input
  stopifnot(is.vector(example))
  stopifnot(is.character(example))
  stopifnot(length(example) == 1)
  
  # All directories in there assumed to be apps
  # Will this be OK for people with locked down systems?
  #availApps <- c("basic", "options")
  availApps <- dir(system.file("shiny-examples", package = "radarchart"))
  
  
  # Check the app exists
  if (!(example %in% availApps)) {
    stop("example must be one of: ", paste(availApps, collapse = ", "))
  }
  
  # Run it
  shiny::runApp(system.file("shiny-examples", example, package = "radarchart"))
}
