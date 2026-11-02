#' Effect Sizes of Bootstrap or Jackknife Covariance Matrices
#'
#' Computes the effect sizes of every row of `vechsigmacap` once, in C++,
#' with `.StrRegressionofVechSigmaMat()`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param vechsigmacap Numeric matrix.
#'   Each row is the half-vectorization of a sample covariance matrix
#'   of \eqn{\left( Y, \mathbf{X} \right)}.
#' @param lm_process List.
#'   Output of `.ProcessLM()`.
#' @return Returns a list of matrices
#'   `betastar`, `rsq`, `spcor`, and `pcorsq` (one row per row of
#'   `vechsigmacap`).
#'
#' @family Beta Nonparametric Bootstrap Functions
#' @keywords betaNB internal
#' @noRd
.NBES <- function(vechsigmacap,
                  lm_process) {
  es <- .StrRegressionofVechSigmaMat(
    vechsigmacap = vechsigmacap,
    k = lm_process$k
  )
  varnames <- lm_process$xnames
  colnames(es$betastar) <- varnames
  colnames(es$spcor) <- varnames
  colnames(es$pcorsq) <- varnames
  es$rsq <- matrix(
    data = es$rsq,
    ncol = 1
  )
  es
}
