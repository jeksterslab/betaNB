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
               seed = NULL) {
  stopifnot(
    inherits(
      x = object,
      what = "lm"
    )
  )
  if (!is.null(seed)) {
    set.seed(seed)
  }
  lm_process <- .ProcessLM(object)
  thetahatstar <- .NBVechCovDraws(
    x = lm_process$x,
    R = R
  )
  jackknife <- .JackknifeVechCov(
    x = lm_process$x
  )
  out <- list(
    call = match.call(),
    args = list(
      object = object,
      R = R,
      seed = seed
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
  class(out) <- c(
    "nb",
    class(out)
  )
  out
}
