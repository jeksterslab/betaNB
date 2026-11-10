#' Modified Percentile Confidence Intervals for Delta R-Squared
#'
#' Applies the lower-limit modifications to the existing percentile
#' calculation. Upper limits and other fields are unchanged.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param object Object returned by `DeltaRSqNB()`.
#' @param alpha Numeric vector. Interval error probabilities and F-test levels.
#' @return Returns the percentile matrix with modified lower limits.
#' @examples
#' fit <- stats::lm(formula = mpg ~ wt + hp, data = datasets::mtcars)
#' nb <- NB(object = fit, R = 20, seed = 42)
#' .MPCCIMat(object = DeltaRSqNB(object = nb), alpha = 0.05)
#' @noRd
.MPCCIMat <- function(object,
                      alpha) {
  if (!(object$fun %in% c("DeltaRSqNB", "DeltaRSqAdjNB"))) {
    stop(
      'type = "mpc" is available only for Delta R-squared (sr2), ',
      "including DeltaRSqNB(adj = TRUE)."
    )
  }
  stopifnot(
    is.numeric(x = alpha),
    length(x = alpha) > 0,
    all(is.finite(x = alpha)),
    all(alpha > 0 & alpha < 1)
  )
  alpha <- sort(x = alpha)
  ci <- .CIMat(
    thetahatstar = object$thetahatstar,
    thetahat = object$est,
    alpha = alpha,
    type = "pc"
  )
  lm_process <- object$args$object$lm_process
  p_value <- stats::pf(
    q = .DeltaRSqF(lm_process = lm_process),
    df1 = 1,
    df2 = lm_process$df,
    lower.tail = FALSE
  )
  for (i in seq_along(along.with = alpha)) {
    lower <- ci[, 3 + i]
    reject <- p_value < alpha[[i]]
    if (object$fun == "DeltaRSqAdjNB") {
      replace <- lower <= 0 & !is.na(x = lower)
      lower[replace & reject] <- 0.001
      lower[replace & !reject] <- 0
    } else {
      lower[!reject] <- 0
    }
    ci[, 3 + i] <- lower
  }
  ci
}
