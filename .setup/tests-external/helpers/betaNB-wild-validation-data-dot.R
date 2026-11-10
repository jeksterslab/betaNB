#' Generate Random Predictors Without Sample Standardization
#' @author Ivan Jacob Agaloos Pesigan
#' @param condition One row of the design.
#' @param config Validated comparison configuration.
#' @param seed Data stream seed.
#' @return Data frame; population residual variance is exactly one.
#' @examples
#' config <- .WildValidationConfig(root = getwd(), n_rep = 2, R = 49)
#' .WildValidationData(
#'   condition = config$design[1, ], config = config, seed = 1
#' )
#' @noRd
.WildValidationData <- function(condition, config, seed) {
  set.seed(seed = seed)
  n <- condition$n
  u <- if (condition$distribution == "normal") {
    stats::rnorm(n = n * 3)
  } else {
    (stats::rchisq(n = n * 3, df = 3) - 3) / sqrt(x = 6)
  }
  x <- matrix(data = u, nrow = n) %*% chol(x = config$sigma_x)
  colnames(x = x) <- paste0("x", 1:3)
  sigma2 <- (1 + condition$gamma * x[, 1]^2) / (1 + condition$gamma)
  y <- as.vector(x = x %*% config$b) +
    sqrt(x = sigma2) * stats::rnorm(n = n)
  data.frame(y = y, x)
}
