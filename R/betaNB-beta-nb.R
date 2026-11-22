#' Estimate Standardized Regression Coefficients
#' and Generate the Corresponding Sampling Distribution
#' Using Nonparametric Bootstrapping
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @details The vector of standardized regression coefficients
#'   (\eqn{\boldsymbol{\hat{\beta}}})
#'   is estimated from bootstrap samples.
#'   Confidence intervals are the percentiles
#'   corresponding to \eqn{100(1 - \alpha)\%}
#'   of the sampling distribution of \eqn{\boldsymbol{\hat{\beta}}},
#'   where \eqn{\alpha} is the significance level.
#'
#' @details
#' Partition the covariance matrix of the outcome and the regressors as
#' \deqn{\boldsymbol{\Sigma} = \begin{pmatrix} \sigma^{2}_{y} &
#' \boldsymbol{\sigma}_{yx}^{\prime} \\ \boldsymbol{\sigma}_{yx} &
#' \boldsymbol{\Sigma}_{x} \end{pmatrix}.}
#' The regression slopes and the standardized regression slopes are
#' \deqn{\boldsymbol{\beta} = \boldsymbol{\Sigma}_{x}^{-1}
#' \boldsymbol{\sigma}_{yx}, \quad \beta^{\ast}_{j} = \beta_{j}
#' \frac{\sigma_{x_{j}}}{\sigma_{y}},}
#' where \eqn{\sigma_{x_{j}}} is the standard deviation of regressor \eqn{j}.
#' With `std_y = FALSE`, \eqn{\sigma_{y}} is replaced by one;
#' for a regressor left out of `std_x`, \eqn{\sigma_{x_{j}}} is replaced by one.
#' The estimates are computed from the data,
#' the draws \eqn{\hat{\boldsymbol{\beta}}^{\ast}_{b}} from each bootstrap
#' covariance matrix \eqn{\hat{\boldsymbol{\Sigma}}^{\ast}_{b}} (see [NB()]),
#' and `vcov` is the sample covariance matrix of the draws.
#'
#' @return Returns an object
#'   of class `betanb` which is a list with the following elements:
#'   \describe{
#'     \item{call}{Function call.}
#'     \item{args}{Function arguments.}
#'     \item{thetahatstar}{Sampling distribution of
#'       \eqn{\boldsymbol{\hat{\beta}}}.}
#'     \item{jackknife}{Jackknife estimates.}
#'     \item{vcov}{Sampling variance-covariance matrix of
#'       \eqn{\boldsymbol{\hat{\beta}}}.}
#'     \item{est}{Vector of estimated
#'       \eqn{\boldsymbol{\hat{\beta}}}.}
#'     \item{fun}{Function used ("BetaNB").}
#'   }
#'
#' @param object Object of class `nb`, that is,
#'   the output of the `NB()` function.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#' @param std_y Logical.
#'   Standardize \eqn{y}.
#'   With `std_y = FALSE`, \eqn{y} is left in its original units.
#' @param std_x Character vector or `NULL`.
#'   Names of the regressors to standardize.
#'   `NULL` (default) standardizes all regressors;
#'   `character(0)` standardizes none
#'   (for example, leave a dummy variable out to keep its 0-1 contrast).
#'   The standard deviations are taken from each bootstrap sample.
#'
#' @examples
#' # Data ---------------------------------------------------------------------
#' data("nas1982", package = "betaNB")
#'
#' # Fit Model in lm ----------------------------------------------------------
#' object <- stats::lm(
#'   formula = QUALITY ~ NARTIC + PCTGRT + PCTSUPP,
#'   data = nas1982
#' )
#'
#' # NB -----------------------------------------------------------------------
#' nb <- NB(
#'   object = object,
#'   R = 100, # use a large value e.g., 5000L for actual research
#'   seed = 0508
#' )
#'
#' # BetaNB -------------------------------------------------------------------
#' out <- BetaNB(object = nb, alpha = 0.05)
#'
#' ## Methods -----------------------------------------------------------------
#' print(x = out)
#' summary(object = out)
#' coef(object = out)
#' vcov(object = out)
#' confint(object = out, level = 0.95)
#'
#' @references
#' Efron, B., & Tibshirani, R. J. (1993).
#' *An introduction to the bootstrap*.
#' Chapman & Hall.
#' \doi{10.1201/9780429246593}
#'
#' @family Beta Nonparametric Bootstrap Functions
#' @keywords betaNB std
#' @export
BetaNB <- function(object,
                   alpha = c(0.05, 0.01, 0.001),
                   std_y = TRUE,
                   std_x = NULL) {
  stopifnot(
    inherits(
      x = object,
      what = "nb"
    )
  )
  fun <- "BetaNB"
  index <- .BetaStarSelectIndex(
    std_x = std_x,
    xnames = object$lm_process$xnames
  )
  est <- .BetaStarSelectLM(
    lm_process = object$lm_process,
    std_y = std_y,
    std_x = index
  )
  thetahatstar <- object$es$betastar
  jackknife <- object$es_jackknife$betastar
  if (!(std_y && all(index))) {
    thetahatstar <- .BetaStarSelectofVechSigmaMat(
      betastar = thetahatstar,
      vechsigmacap = object$thetahatstar,
      k = object$lm_process$k,
      std_y = std_y,
      std_x = index
    )
    jackknife <- .BetaStarSelectofVechSigmaMat(
      betastar = jackknife,
      vechsigmacap = object$jackknife,
      k = object$lm_process$k,
      std_y = std_y,
      std_x = index
    )
  }
  vcov <- stats::var(x = thetahatstar)
  colnames(x = vcov) <- rownames(x = vcov) <- names(x = est)
  out <- list(
    call = match.call(),
    args = list(
      object = object,
      alpha = alpha,
      std_y = std_y,
      std_x = std_x
    ),
    thetahatstar = thetahatstar,
    jackknife = jackknife,
    vcov = vcov,
    est = est,
    fun = fun
  )
  class(x = out) <- c(
    "betanb",
    class(x = out)
  )
  out
}
