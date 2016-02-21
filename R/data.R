#' Skills in a team
#'
#' A dataset containing the skills vectors for three people
#'
#' @format A data frame with 6 rows and 4 columns
#' \describe{
#'   \item{Label}{The axis label for chartJSRadar}
#'   \item{Aimee}{Vector of skills for Aimee}
#'   \item{Andy}{Vector of skills for Andy}
#'   \item{Rich}{Vector of skills for Rich}
#' }
#' @source Simulated
"skills"

#' Rotated version of skills data
#'
#' A dataset containing the skills vectors for three people but by row rather
#' than column. This data set is used to show how to rotate the data into a 
#' format accepted by \code{\link{chartJSRadar}}.
#'
#' @format A data frame with 6 rows and 4 columns
#' \describe{
#'   \item{Name}{Name of the team member}
#'   \item{Communicator}{Their Communicator score: 0-10}
#'   \item{Data Wangler}{Their Data Wangler score: 0-10}
#'   \item{Modeller}{Their Modeller score: 0-10}
#'   \item{Programmer}{Their Programmer score: 0-10}
#'   \item{Technologist}{Their Technologist score: 0-10}
#'   \item{Visualizer}{Their Visualizer score: 0-10}
#' }
#' @source Simulated
"skillsByName"