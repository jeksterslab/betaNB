#' Acceleration
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param jackknife Numeric vector.
#'   Jackknife estimates.
#'
#' @return Returns a numeric vector of length one.
#'
#' @family Confidence Intervals Functions
#' @keywords nBootstrap ci internal
#' @noRd
.Acceleration <- function(jackknife) {
  parenthesis <- mean(jackknife) - jackknife
  numerator <- sum(parenthesis^3)
  denominator <- 6 * ((sum(parenthesis^2))^(3 / 2))
  return(
    numerator / denominator
  )
}
