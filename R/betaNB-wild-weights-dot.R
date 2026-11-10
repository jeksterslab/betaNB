#' Random Weights for the Wild Bootstrap
#'
#' Draws independent weights \eqn{v_i}
#' with \eqn{E(v) = 0} and \eqn{E(v^2) = 1}.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param size Integer.
#'   Number of weights.
#' @param weights Character string.
#'   `"rademacher"` (-1 or 1, each with probability 1/2),
#'   `"mammen"` (two-point distribution that also has
#'   third moment 1),
#'   `"webb"` (six-point distribution, each point with probability 1/6),
#'   or `"normal"` (standard normal).
#' @return Returns a numeric vector of length `size`.
#'
#' @family Beta Nonparametric Bootstrap Functions
#' @keywords betaNB wild internal
#' @noRd
.WildWeights <- function(size,
                         weights = "rademacher") {
  switch(
    EXPR = weights,
    rademacher = sample(
      x = c(-1, 1),
      size = size,
      replace = TRUE
    ),
    mammen = {
      s5 <- sqrt(x = 5)
      sample(
        x = c(-(s5 - 1) / 2, (s5 + 1) / 2),
        size = size,
        replace = TRUE,
        prob = c((s5 + 1) / (2 * s5), (s5 - 1) / (2 * s5))
      )
    },
    webb = sample(
      x = c(
        -sqrt(x = 1.5),
        -1,
        -sqrt(x = 0.5),
        sqrt(x = 0.5),
        1,
        sqrt(x = 1.5)
      ),
      size = size,
      replace = TRUE
    ),
    normal = stats::rnorm(n = size),
    stop("`weights` must be one of rademacher, mammen, webb, or normal.")
  )
}
