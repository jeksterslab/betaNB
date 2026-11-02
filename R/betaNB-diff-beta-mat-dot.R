#' Differences of Standardized Regression Slopes of Draws
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param betastar Numeric matrix.
#'   Draws of the standardized regression slopes (rows).
#' @param lm_process List.
#'   Output of `.ProcessLM()`.
#' @return Returns a numeric matrix,
#'   one column per pair in `lm_process$dif_idx`.
#'
#' @family Beta Nonparametric Bootstrap Functions
#' @keywords betaNB internal
#' @noRd
.DiffBetaMat <- function(betastar,
                         lm_process) {
  idx <- lm_process$dif_idx
  out <- betastar[, idx[1, ], drop = FALSE] - betastar[, idx[2, ], drop = FALSE]
  colnames(out) <- names(lm_process$dif_betastar)
  out
}
