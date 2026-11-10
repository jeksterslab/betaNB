#' Scale of the Residuals for the Wild Bootstrap
#'
#' The factor \eqn{f(h_i)} that multiplies the residual \eqn{e_i}
#' in the wild bootstrap,
#' \eqn{y_i^{*} = \mathbf{x}_i^{\prime} \hat{\boldsymbol{\beta}} +
#' f(h_i) e_i v_i}.
#' It is the square root of the leverage adjustment
#' used for the heteroskedasticity-consistent
#' sampling covariance matrices
#' (the same definitions as `betaSandwich`).
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param h Numeric vector.
#'   Leverages (hat values).
#' @param k Integer.
#'   Number of columns of the model matrix,
#'   including the intercept.
#' @param df Integer.
#'   Residual degrees of freedom.
#' @param type Character string.
#'   `"hc0"`, `"hc1"`, `"hc2"`, `"hc3"`, `"hc4"`, `"hc4m"`, or `"hc5"`.
#' @param g1,g2 Numeric.
#'   Constants of `"hc4m"`.
#' @param constant Numeric.
#'   Constant of `"hc5"`, between 0 and 1.
#' @return Returns a numeric vector, one value for each observation.
#'
#' @family Beta Nonparametric Bootstrap Functions
#' @keywords betaNB wild internal
#' @noRd
.WildScale <- function(h,
                       k,
                       df,
                       type = "hc3",
                       g1 = 1,
                       g2 = 1.5,
                       constant = 0.7) {
  n <- length(x = h)
  if (type %in% c("hc2", "hc3", "hc4", "hc4m", "hc5")) {
    if (any(h >= 1 - sqrt(x = .Machine$double.eps))) {
      stop(
        paste0(
          "A leverage equals 1; `hc = \"", type, "\"` cannot be used."
        )
      )
    }
  }
  nh <- n * h / k
  q <- switch(
    EXPR = type,
    hc0 = rep(x = 1, times = n),
    hc1 = rep(x = n / df, times = n),
    hc2 = 1 / (1 - h),
    hc3 = 1 / (1 - h)^2,
    hc4 = 1 / (1 - h)^pmin(4, nh),
    hc4m = 1 / (1 - h)^(pmin(g1, nh) + pmin(g2, nh)),
    hc5 = 1 / sqrt(
      x = (1 - h)^pmin(nh, max(4, n * constant * max(h) / k))
    ),
    stop("`hc` must be one of hc0, hc1, hc2, hc3, hc4, hc4m, or hc5.")
  )
  sqrt(x = q)
}
