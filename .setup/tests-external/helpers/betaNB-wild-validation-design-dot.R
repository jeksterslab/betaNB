#' External Wild Bootstrap Conditions
#' @author Ivan Jacob Agaloos Pesigan
#' @return Data frame of eight conditions with stable task IDs.
#' @examples
#' .WildValidationDesign()
#' @noRd
.WildValidationDesign <- function() {
  design <- expand.grid(
    n = c(100L, 250L), distribution = c("normal", "chisq3"),
    gamma = c(0, 4), stringsAsFactors = FALSE
  )
  design$taskid <- seq_len(length.out = nrow(x = design))
  design
}
