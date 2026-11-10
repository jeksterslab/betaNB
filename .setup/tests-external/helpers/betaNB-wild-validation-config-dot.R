#' Validated Configuration for Reproducible External Results
#' @author Ivan Jacob Agaloos Pesigan
#' @param root Project directory.
#' @param n_rep Total replications per condition, including when sharded.
#' @param R Bootstrap draws per sampler.
#' @return Configuration including schema, source hashes and R version.
#' @examples
#' .WildValidationConfig(root = getwd(), n_rep = 2, R = 49)
#' @noRd
.WildValidationConfig <- function(root, n_rep = 1000L, R = 1999L) {
  stopifnot(
    length(x = n_rep) == 1, is.finite(x = n_rep),
    n_rep == floor(x = n_rep), n_rep >= 1, n_rep <= 1000000,
    length(x = R) == 1, is.finite(x = R), R == floor(x = R), R >= 20,
    R <= .Machine$integer.max
  )
  sigma_x <- 0.5^abs(x = outer(X = 1:3, Y = 1:3, FUN = "-"))
  b <- c(0.5, 0.3, 0.2)
  list(
    schema = 1L, n_rep = as.integer(x = n_rep), R = as.integer(x = R),
    alpha = 0.05, hc = "hc3", weights = "rademacher",
    types = c("pc", "bc", "bca"),
    samplers = c("pairs", "wild-fixed", "wild-random"),
    design = .WildValidationDesign(), sigma_x = sigma_x, b = b,
    truth = .WildValidationTruth(sigma_x = sigma_x, b = b),
    sources = .WildValidationSources(root = root),
    r_version = R.version.string,
    package_version = as.character(x = utils::packageVersion(pkg = "betaNB"))
  )
}
