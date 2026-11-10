#' Confidence Intervals
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of
#'   estimates,
#'   standard errors,
#'   and
#'   confidence intervals.
#'
#' @param object Object of class `betanb`.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#' @param type Charater string.
#'   Confidence interval type, that is,
#'   `type = "pc"` for percentile;
#'   `type = "bc"` for bias corrected;
#'   `type = "bca"` for bias corrected and accelerated;
#'   `type = "mpc"` for modified percentile (Delta R-squared only).
#'
#' @family Beta Nonparametric Bootstrap Functions
#' @keywords betaNB ci internal
#' @noRd
.CI <- function(object,
                alpha = NULL,
                type = "pc") {
  if (is.null(x = alpha)) {
    alpha <- object$args$alpha
  }
  if (type == "mpc") {
    .MPCCIMat(object = object, alpha = alpha)
  } else {
    .CIMat(
      thetahatstar = object$thetahatstar,
      thetahat = object$est,
      alpha = alpha,
      type = type,
      jackknife = object$jackknife
    )
  }
}
