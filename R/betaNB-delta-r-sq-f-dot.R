#' Sample F Statistics for Single-Regressor Increments
#'
#' Uses the unadjusted increment and full-model residual mean square,
#' including when confidence intervals use adjusted increments.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param lm_process List. Output of `.ProcessLM()`.
#' @return Returns one F statistic per regressor, with numerator df one
#'   and denominator df `lm_process$df`.
#' @examples
#' fit <- stats::lm(formula = mpg ~ wt + hp, data = datasets::mtcars)
#' .DeltaRSqF(lm_process = .ProcessLM(object = fit))
#' @noRd
.DeltaRSqF <- function(lm_process) {
  lm_process$scor^2 / ((1 - lm_process$rsq[["rsq"]]) / lm_process$df)
}
