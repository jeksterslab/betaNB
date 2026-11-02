#' R-Squared and Adjusted R-Squared of Draws
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param rsq Numeric matrix with one column.
#'   Draws of \eqn{R^2}.
#' @param lm_process List.
#'   Output of `.ProcessLM()`.
#' @return Returns a numeric matrix with columns `rsq` and `adj`.
#'
#' @family Beta Nonparametric Bootstrap Functions
#' @keywords betaNB internal
#' @noRd
.NBRSqAdj <- function(rsq,
                      lm_process) {
  rsq <- rsq[, 1]
  cbind(
    rsq = rsq,
    adj = 1 - (
      1 - rsq
    ) * (
      (
        lm_process$n - 1
      ) / lm_process$df
    )
  )
}
