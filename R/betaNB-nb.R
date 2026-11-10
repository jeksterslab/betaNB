#' Generate the Sampling Distribution of Sample Covariances
#' Using Nonparametric Bootstrapping
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns an object
#' of class `nb` which is a list with the following elements:
#'   \describe{
#'     \item{call}{Function call.}
#'     \item{args}{Function arguments.}
#'     \item{lm_process}{Processed `lm` object.}
#'     \item{thetahatstar}{Sampling distribution of sample covariances
#'       (a matrix; each row is the half-vectorization of one bootstrap
#'       covariance matrix).}
#'     \item{jackknife}{Jackknife estimates
#'       (a matrix; each row is the half-vectorization of one
#'       leave-one-out covariance matrix).}
#'     \item{es}{Effect sizes of the bootstrap samples (a list of matrices).}
#'     \item{es_jackknife}{Effect sizes of the jackknife samples
#'       (a list of matrices).}
#' }
#'
#' @param object Object of class `lm`.
#' @param R Positive integer.
#'   Number of bootstrap replications.
#' @param seed Integer.
#'   Seed number for reproducibility.
#' @param type Character string.
#'   Bootstrap sampler.
#'   `"pairs"` (default) resamples the rows of the data
#'   (nonparametric bootstrap).
#'   `"wild"` is the wild bootstrap, which generates
#'   \eqn{y_i^{*} = \mathbf{x}_i^{\prime} \hat{\boldsymbol{\beta}} +
#'   f(h_i) e_i v_i},
#'   where \eqn{e_i} is the residual,
#'   \eqn{h_i} is the leverage,
#'   \eqn{v_i} is a random weight with mean 0 and variance 1,
#'   and \eqn{f(h_i)} is set by `hc`.
#'   The arguments `weights`, `hc`, and `x` are used only
#'   with `type = "wild"`.
#' @param weights Character string.
#'   Distribution of \eqn{v_i}:
#'   `"rademacher"` (default; -1 or 1 with equal probability),
#'   `"mammen"` (two-point distribution with third moment 1),
#'   `"webb"` (six-point distribution),
#'   or `"normal"` (standard normal).
#' @param hc Character string.
#'   Adjustment of the residuals,
#'   with the same definitions as the heteroskedasticity-consistent
#'   sampling covariance matrices of `betaSandwich`:
#'   `"hc3"` (default), `"hc0"`, `"hc1"`, `"hc2"`, `"hc4"`, `"hc4m"`,
#'   or `"hc5"`.
#'   A leverage equal to 1 is an error for every type except
#'   `"hc0"` and `"hc1"`.
#' @param x Character string.
#'   `"random"` (default) resamples the rows
#'   \eqn{\left( \mathbf{x}_i, f(h_i) e_i \right)} together
#'   before the weights are applied,
#'   so the sampling variability of the regressors is kept.
#'   `"fixed"` keeps the regressors of the data in every sample
#'   (conditional wild bootstrap);
#'   the covariance matrix of the regressors is then the same
#'   in every sample.
#'
#' @references
#' Efron, B., & Tibshirani, R. J. (1993)
#' *An introduction to the bootstrap*.
#' Chapman & Hall.
#'
#' @examples
#' # Data ---------------------------------------------------------------------
#' data("nas1982", package = "betaNB")
#'
#' # Fit Model in lm ----------------------------------------------------------
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#'
#' # NB -----------------------------------------------------------------------
#' nb <- NB(
#'   object,
#'   R = 100, # use a large value e.g., 20000L for actual research
#'   seed = 0508
#' )
#' nb
#' # The `nb` object can be passed as the first argument
#' # to the following functions
#' #   - BetaNB
#' #   - DeltaRSqNB
#' #   - DiffBetaNB
#' #   - PCorNB
#' #   - RSqNB
#' #   - SCorNB
#'
#' @family Beta Nonparametric Bootstrap Functions
#' @keywords betaNB nb
#' @export
NB <- function(object,
               R = 5000L,
               seed = NULL,
               type = c("pairs", "wild"),
               weights = c("rademacher", "mammen", "webb", "normal"),
               hc = c("hc3", "hc0", "hc1", "hc2", "hc4", "hc4m", "hc5"),
               x = c("random", "fixed")) {
  stopifnot(
    inherits(
      x = object,
      what = "lm"
    )
  )
  type <- match.arg(arg = type)
  weights <- match.arg(arg = weights)
  hc <- match.arg(arg = hc)
  x <- match.arg(arg = x)
  if (!is.null(x = seed)) {
    set.seed(seed = seed)
  }
  lm_process <- .ProcessLM(object = object)
  if (type == "wild") {
    thetahatstar <- .NBWildVechCovDraws(
      lm_process = lm_process,
      R = R,
      weights = weights,
      hc = hc,
      x = x
    )
  } else {
    thetahatstar <- .NBVechCovDraws(
      x = lm_process$x,
      R = R
    )
  }
  jackknife <- .JackknifeVechCov(
    x = lm_process$x
  )
  out <- list(
    call = match.call(),
    args = list(
      object = object,
      R = R,
      seed = seed,
      type = type,
      weights = weights,
      hc = hc,
      x = x
    ),
    lm_process = lm_process,
    thetahatstar = thetahatstar,
    jackknife = jackknife,
    es = .NBES(
      vechsigmacap = thetahatstar,
      lm_process = lm_process
    ),
    es_jackknife = .NBES(
      vechsigmacap = jackknife,
      lm_process = lm_process
    )
  )
  class(x = out) <- c(
    "nb",
    class(x = out)
  )
  out
}
