#' Confidence Intervals
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of
#'   estimates,
#'   standard errors,
#'   and
#'   confidence intervals.
#'
#' @param object Object of class `betanb`.
#' @param alpha Numeric vector.
#'   Significance level.
#' @param type Charater string.
#'   Confidence interval type, that is,
#'   `type = "pc"` for percentile;
#'   `type = "bc"` for bias corrected;
#'   `type = "bca"` for bias corrected and accelerated.
#'
#' @export
#' @family Beta Nonparametric Bootstrap Functions
#' @keywords betaNB ci internal
.CI <- function(object,
                alpha = c(0.05, 0.01, 0.001),
                type = "pc") {
  stopifnot(
    methods::is(
      object,
      "betanb"
    )
  )
  probs <- .PCProbs(alpha = alpha)
  thetahatstar <- do.call(
    what = "rbind",
    args = object$thetahatstar
  )
  thetahatstar <- unname(thetahatstar)
  colnames(thetahatstar) <- names(object$est)
  thetahat <- object$est
  k <- dim(thetahatstar)[2]
  ci <- vector(
    mode = "list",
    length = k
  )
  if (type == "pc") {
    for (i in seq_len(k)) {
      ci[[i]] <- .PCCI(
        thetahatstar = thetahatstar[, i],
        thetahat = thetahat[[i]],
        probs = probs
      )
    }
  }
  if (type == "bc") {
    z1 <- .Z1(probs = probs)
    for (i in seq_len(k)) {
      ci[[i]] <- .BCCI(
        thetahatstar = thetahatstar[, i],
        thetahat = thetahat[[i]],
        probs = probs,
        z0 = .Z0(
          thetahatstar = thetahatstar[, i],
          thetahat = thetahat[[i]]
        ),
        z1 = z1
      )
    }
  }
  if (type == "bca") {
    z1 <- .Z1(probs = probs)
    jackknife <- do.call(
      what = "rbind",
      args = object$jackknife
    )
    for (i in seq_len(k)) {
      ci[[i]] <- .BCACI(
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
  ci <- do.call(
    what = "rbind",
    args = ci
  )
  rownames(ci) <- names(thetahat)
  return(
    ci
  )
}
