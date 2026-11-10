#' Wild Bootstrap Covariance Matrices
#'
#' Draws wild bootstrap samples
#' \eqn{y_i^{*} = \mathbf{x}_i^{\prime} \hat{\boldsymbol{\beta}} +
#' f(h_i) e_i v_i}
#' and returns the half-vectorized sample covariance matrix of
#' \eqn{\left( y^{*}, \mathbf{X} \right)} of each sample.
#' With `x = "fixed"`, the regressors are those of the data
#' in every sample.
#' With `x = "random"`, the rows
#' \eqn{\left( \mathbf{x}_i, f(h_i) e_i \right)}
#' are resampled with replacement together,
#' so the residual stays with its own regressors,
#' and then multiplied by \eqn{v_i}.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param lm_process List.
#'   Output of `.ProcessLM()`.
#' @param R Positive integer.
#'   Number of bootstrap samples.
#' @param weights Character string.
#'   See `.WildWeights()`.
#' @param hc Character string.
#'   See `.WildScale()`.
#' @param x Character string.
#'   `"random"` or `"fixed"`.
#' @param block Positive integer.
#'   Number of samples processed at a time (fixed regressors).
#' @return Returns an `R` by `k * (k + 1) / 2` numeric matrix,
#'   in the same layout as `.NBVechCovDraws()`.
#'
#' @family Beta Nonparametric Bootstrap Functions
#' @keywords betaNB wild internal
#' @noRd
.NBWildVechCovDraws <- function(lm_process,
                                R = 5000L,
                                weights = "rademacher",
                                hc = "hc3",
                                x = "random",
                                block = 1000L) {
  object <- lm_process$object
  n <- lm_process$n
  k <- lm_process$k
  scaled_e <- .WildScale(
    h = stats::hatvalues(model = object),
    k = k,
    df = lm_process$df,
    type = hc
  ) * unname(obj = stats::residuals(object = object))
  fitted_y <- unname(obj = stats::fitted(object = object))
  xmat <- unname(obj = lm_process$x[, -1, drop = FALSE])
  if (x == "fixed") {
    xc <- sweep(
      x = xmat,
      MARGIN = 2,
      STATS = colMeans(x = xmat)
    )
    vech_sxx <- .Vech(x = stats::cov(x = xmat))
    block <- max(
      1L,
      min(
        block,
        as.integer(x = 1e7 %/% n)
      )
    )
    starts <- seq(
      from = 1L,
      to = R,
      by = block
    )
    out <- lapply(
      X = starts,
      FUN = function(start) {
        size <- min(block, R - start + 1L)
        v <- matrix(
          data = .WildWeights(
            size = n * size,
            weights = weights
          ),
          nrow = n
        )
        ystar <- fitted_y + scaled_e * v
        yc <- sweep(
          x = ystar,
          MARGIN = 2,
          STATS = colMeans(x = ystar)
        )
        cbind(
          colSums(x = yc^2) / (n - 1),
          t(x = crossprod(x = xc, y = yc) / (n - 1)),
          matrix(
            data = vech_sxx,
            nrow = size,
            ncol = length(x = vech_sxx),
            byrow = TRUE
          )
        )
      }
    )
    out <- do.call(
      what = "rbind",
      args = out
    )
  } else {
    out <- t(
      x = vapply(
        X = seq_len(length.out = R),
        FUN = function(i) {
          idx <- sample.int(
            n = n,
            size = n,
            replace = TRUE
          )
          v <- .WildWeights(
            size = n,
            weights = weights
          )
          .Vech(
            x = stats::cov(
              x = cbind(
                fitted_y[idx] + scaled_e[idx] * v,
                xmat[idx, , drop = FALSE]
              )
            )
          )
        },
        FUN.VALUE = numeric(length = k * (k + 1) / 2)
      )
    )
  }
  out
}
