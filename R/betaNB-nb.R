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
#'     \item{thetahatstar}{Sampling distribution of sample covariances.}
#'     \item{jackknife}{Jackknife estimates.}
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
#' # Fit the regression model
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' # Generate the sampling distribution of sample covariances
#' # (use a large R, for example, R = 5000 for actual research)
#' NB(object, R = 100)
#' @export
#' @family Beta Nonparametric Bootstrap Functions
#' @keywords betaNB nb
NB <- function(object,
               R = 5000,
               seed = NULL) {
  set.seed(seed)
  lm_process <- .ProcessLM(object)
  out <- list(
    call = match.call(),
    args = list(
      object = object,
      R = R,
      seed = seed
    ),
    lm_process = lm_process,
    thetahatstar = lapply(
      X = seq_len(R),
      FUN = function(i,
                     x,
                     n) {
        return(
          unname(
            stats::cov(
              x[
                sample.int(
                  n = n,
                  size = n,
                  replace = TRUE
                ), ,
                drop = FALSE
              ]
            )
          )
        )
      },
      x = lm_process$x,
      n = lm_process$n
    ),
    jackknife = lapply(
      X = seq_len(lm_process$n),
      FUN = function(i,
                     x) {
        return(
          unname(
            stats::cov(
              x[
                -i, ,
                drop = FALSE
              ]
            )
          )
        )
      },
      x = lm_process$x
    )
  )
  class(out) <- c(
    "nb",
    class(out)
  )
  return(
    out
  )
}
