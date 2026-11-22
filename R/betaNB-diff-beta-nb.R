#' Estimate Differences of Standardized Regression Coefficients
#' and Generate the Corresponding Sampling Distribution
#' Using Nonparametric Bootstrapping
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @details The vector of differences of standardized regression slopes
#'   is estimated from bootstrap samples.
#'   Confidence intervals are the percentiles
#'   corresponding to \eqn{100(1 - \alpha)\%}
#'   of the sampling distribution of the differences,
#'   where \eqn{\alpha} is the significance level.
#'
#' @details
#' For every pair of regressors \eqn{j < l},
#' the difference of the standardized regression slopes (see [BetaNB()]) is
#' \deqn{\Delta \beta^{\ast}_{jl} = \beta^{\ast}_{j} - \beta^{\ast}_{l},}
#' computed from the data for the estimate
#' and from each bootstrap sample (see [NB()]) for the draws.
#'
#' @return Returns an object
#'   of class `betanb` which is a list with the following elements:
#'   \describe{
#'     \item{call}{Function call.}
#'     \item{args}{Function arguments.}
#'     \item{thetahatstar}{Sampling distribution of
#'       differences of standardized regression slopes.}
#'     \item{vcov}{Sampling variance-covariance matrix of
#'       differences of standardized regression slopes.}
#'     \item{est}{Vector of estimated
#'       differences of standardized regression slopes.}
#'     \item{fun}{Function used ("DiffBetaNB").}
#'   }
#'
#' @inheritParams BetaNB
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
#' # DiffBetaNB ---------------------------------------------------------------
#' out <- DiffBetaNB(object = nb, alpha = 0.05)
#'
#' ## Methods -----------------------------------------------------------------
#' print(x = out)
#' summary(object = out)
#' coef(object = out)
#' vcov(object = out)
#' confint(object = out, level = 0.95)
#'
#' @family Beta Nonparametric Bootstrap Functions
#' @keywords betaNB diff
#' @export
DiffBetaNB <- function(object,
                       alpha = c(0.05, 0.01, 0.001)) {
  stopifnot(
    inherits(
      x = object,
      what = "nb"
    )
  )
  if (object$lm_process$p < 2) {
    stop("Two or more regressors is required.")
  }
  fun <- "DiffBetaNB"
  est <- object$lm_process$dif_betastar
  thetahatstar <- .DiffBetaMat(
    betastar = object$es$betastar,
    lm_process = object$lm_process
  )
  jackknife <- .DiffBetaMat(
    betastar = object$es_jackknife$betastar,
    lm_process = object$lm_process
  )
  vcov <- stats::var(x = thetahatstar)
  colnames(x = vcov) <- rownames(x = vcov) <- names(x = est)
  out <- list(
    call = match.call(),
    args = list(
      object = object,
      alpha = alpha
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
