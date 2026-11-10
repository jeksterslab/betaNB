#' Population Targets for the External Comparison
#' @author Ivan Jacob Agaloos Pesigan
#' @param sigma_x Predictor covariance matrix.
#' @param b Unstandardized population slopes; residual variance is one.
#' @return Data frame of targets and feasible endpoint bounds.
#' @examples
#' .WildValidationTruth(sigma_x = diag(x = 3), b = c(0.5, 0.3, 0.2))
#' @noRd
.WildValidationTruth <- function(sigma_x, b) {
  explained <- as.numeric(x = crossprod(x = b, y = sigma_x %*% b))
  var_y <- explained + 1
  p <- length(x = b)
  data.frame(
    effect = c(rep(x = "beta", times = p), rep(x = "sr", times = p), "rsq"),
    parameter = c(
      rep(x = paste0("x", seq_len(length.out = p)), times = 2),
      "rsq"
    ),
    truth = c(
      b / sqrt(x = var_y),
      b / sqrt(x = var_y * diag(x = solve(a = sigma_x))),
      explained / var_y
    ),
    minimum = c(rep(x = -Inf, times = p), rep(x = -1, times = p), 0),
    maximum = c(rep(x = Inf, times = p), rep(x = 1, times = p), 1)
  )
}
