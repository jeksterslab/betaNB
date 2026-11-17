#' betaNB: Nonparametric Bootstrap Confidence Intervals for Standardized
#' Regression Coefficients
#'
#' Generates nonparametric bootstrap confidence intervals
#' for standardized regression coefficients and other effect sizes
#' for models fitted by [stats::lm()]
#' (Efron & Tibshirani, 1993).
#'
#' @section Bootstrap:
#' [NB()] generates the bootstrap samples, either by resampling cases
#' (`type = "pairs"`) or by the wild bootstrap (`type = "wild"`).
#' The arguments `std_y` and `std_x` standardize only the outcome
#' or only the named regressors.
#'
#' @section Effect sizes:
#' [BetaNB()] (standardized regression coefficients),
#' [DiffBetaNB()] (differences of standardized slopes),
#' [RSqNB()] (R-squared and adjusted R-squared),
#' [SCorNB()] and [SCorSqNB()] (semipartial correlations),
#' [PCorNB()] (squared partial correlations),
#' [DeltaRSqNB()] (improvement in R-squared), and
#' [FSqNB()] (Cohen's f-squared and local f-squared).
#' Percentile (`"pc"`), bias-corrected (`"bc"`),
#' and bias-corrected and accelerated (`"bca"`) intervals are available.
#'
#' @section Methods:
#' The `coef()`, `vcov()`, `confint()`, `summary()`, and `print()` methods are
#' available for objects of class `betanb`.
#'
#' @references
#' Efron, B., & Tibshirani, R. J. (1993).
#' *An introduction to the bootstrap*.
#' Chapman & Hall.
#' \doi{10.1201/9780429246593}
#'
#' @aliases betaNB-package
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom Rcpp sourceCpp
#' @useDynLib betaNB, .registration = TRUE
## usethis namespace: end
NULL
