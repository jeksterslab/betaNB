#' Bias-Correction Constant (Internal)
#'
#' Returns \eqn{\hat{z}_{0} = \Phi^{-1} \left(
#' \# \{ \hat{\theta}^{*} < \hat{\theta} \} / R \right)},
#' the bias-correction constant of the bias-corrected
#' and the bias-corrected and accelerated intervals,
#' from the \eqn{R} draws that are not missing.
#' No input checks.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param thetahatstar Numeric vector.
#'   Sampling distribution.
#' @param thetahat Numeric.
#'   Parameter estimate.
#'
#' @return Returns a numeric vector of length one.
#'
#' @examples
#' .Z0(thetahatstar = c(1:10, NA), thetahat = 3.5)
#'
#' @family Confidence Intervals Functions
#' @keywords nBootstrap ci internal
#' @noRd
.Z0 <- function(thetahatstar,
                thetahat) {
  # failed draws (NA) are dropped, as in the interval functions
  thetahatstar <- thetahatstar[!is.na(x = thetahatstar)]
  stats::qnorm(
    p = sum(
      thetahatstar < thetahat
    ) / length(x = thetahatstar)
  )
}
