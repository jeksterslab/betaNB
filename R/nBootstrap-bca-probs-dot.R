#' Bias Corrected and Accelerated Probablities
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param z0 Numeric.
#' @param z1 Numeric vector
#'   with length equal to two times the length of alpha.
#' @param acceleration Numeric.
#' @return Returns a vector of prababilities.
#'
#' @family Confidence Intervals Functions
#' @keywords nBootstrap ci internal
#' @noRd
.BCAProbs <- function(z0,
                      z1,
                      acceleration) {
  return(
    stats::pnorm(
      q = z0 + (
        z0 + z1
      ) / (
        1 - acceleration * (z0 + z1)
      )
    )
  )
}
