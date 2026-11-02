#' Confidence Intervals from a Matrix of Draws
#'
#' Percentile, bias-corrected, or bias-corrected and accelerated
#' confidence intervals for every column of a matrix of draws
#' (bootstrap or Monte Carlo).
#' Same numbers and layout as looping [.PCCI()], [.BCCI()], or [.BCACI()]
#' over the columns.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param thetahatstar Numeric matrix.
#'   Draws (rows) of the parameters (columns).
#' @param thetahat Numeric vector.
#'   Parameter estimates, one for each column of `thetahatstar`.
#'   Its names label the rows of the output.
#' @param alpha Numeric vector.
#'   Significance level(s).
#' @param type Character string.
#'   `"pc"` (percentile), `"bc"` (bias-corrected),
#'   or `"bca"` (bias-corrected and accelerated).
#' @param jackknife Numeric matrix or `NULL`.
#'   Jackknife estimates (rows) of the parameters (columns).
#'   Required for `type = "bca"`.
#' @return Returns a matrix with columns
#'   `est`, `se`, `R`, and the confidence limits,
#'   and one row for each parameter.
#'
#' @family Confidence Intervals Functions
#' @keywords nBootstrap ci internal
#' @noRd
.CIMat <- function(thetahatstar,
                   thetahat,
                   alpha = c(0.05, 0.01, 0.001),
                   type = "pc",
                   jackknife = NULL) {
  probs <- .PCProbs(alpha = alpha)
  k <- dim(thetahatstar)[2]
  if (type %in% c("bc", "bca")) {
    z1 <- .Z1(probs = probs)
  }
  ci <- lapply(
    X = seq_len(k),
    FUN = function(i) {
      if (type == "pc") {
        .PCCI(
          thetahatstar = thetahatstar[, i],
          thetahat = thetahat[[i]],
          probs = probs
        )
      } else if (type == "bc") {
        .BCCI(
          thetahatstar = thetahatstar[, i],
          thetahat = thetahat[[i]],
          probs = probs,
          z0 = .Z0(
            thetahatstar = thetahatstar[, i],
            thetahat = thetahat[[i]]
          ),
          z1 = z1
        )
      } else {
        .BCACI(
          thetahatstar = thetahatstar[, i],
          thetahat = thetahat[[i]],
          probs = probs,
          z0 = .Z0(
            thetahatstar = thetahatstar[, i],
            thetahat = thetahat[[i]]
          ),
          z1 = z1,
          acceleration = .Acceleration(
            jackknife = jackknife[, i]
          )
        )
      }
    }
  )
  ci <- do.call(
    what = "rbind",
    args = ci
  )
  rownames(ci) <- names(thetahat)
  ci
}
