#' Adjust an Increment in R-Squared
#'
#' Computes the difference between adjusted full and reduced R-squared
#' when one regressor is removed. Rows of a matrix use the corresponding
#' full-model R-squared. Negative estimates are retained.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param delta_rsq Numeric vector or matrix of unadjusted increments.
#' @param rsq Numeric vector of full-model R-squared values.
#' @param n Numeric. Sample size, including for leave-one-out estimates.
#' @param p Numeric. Number of full-model regressors, excluding intercept.
#' @return Returns adjusted increments with the input dimensions and names.
#' @examples
#' .DeltaRSqAdj(delta_rsq = 0.01, rsq = 0.3, n = 100, p = 3)
#' @noRd
.DeltaRSqAdj <- function(delta_rsq,
                         rsq,
                         n,
                         p) {
  if (n <= p + 1) {
    stop(
      "Adjusted Delta R-squared requires positive residual ",
      "degrees of freedom."
    )
  }
  delta_rsq - p * (1 - rsq) / (n - p - 1) +
    (p - 1) * (1 - rsq + delta_rsq) / (n - p)
}
