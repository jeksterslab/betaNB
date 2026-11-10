#' Classify Intervals Without Dropping Failures or Clipping Limits
#' @author Ivan Jacob Agaloos Pesigan
#' @param truth Population target rows.
#' @param estimate Point estimates.
#' @param lower Lower endpoints.
#' @param upper Upper endpoints.
#' @param status Stage status; a failed stage invalidates its intervals.
#' @param error Failure message, empty on success.
#' @return Data frame retaining invalid endpoints, coverage and miss flags.
#' @examples
#' truth <- .WildValidationTruth(sigma_x = diag(x = 3), b = c(0.5, 0.3, 0.2))
#' .WildValidationResult(truth = truth, status = "bootstrap_error", error = "x")
#' @noRd
.WildValidationResult <- function(truth, estimate = NA_real_,
                                  lower = NA_real_, upper = NA_real_,
                                  status = "ok", error = "") {
  count <- nrow(x = truth)
  out <- truth
  out$estimate <- rep(x = estimate, length.out = count)
  out$lower <- rep(x = lower, length.out = count)
  out$upper <- rep(x = upper, length.out = count)
  out$valid <- status == "ok" & is.finite(x = out$estimate) &
    is.finite(x = out$lower) & is.finite(x = out$upper) & out$lower <= out$upper
  out$infeasible <- out$valid &
    (out$lower < out$minimum | out$upper > out$maximum)
  out$status <- ifelse(
    test = status == "ok" & !out$valid, yes = "invalid_interval", no = status
  )
  out$error <- ifelse(
    test = status == "ok" & !out$valid,
    yes = "Non-finite estimate/endpoints or reversed interval", no = error
  )
  out$covered <- out$valid & out$lower <= out$truth & out$upper >= out$truth
  out$interval_below <- out$valid & out$upper < out$truth
  out$interval_above <- out$valid & out$lower > out$truth
  out$width <- ifelse(
    test = out$valid, yes = out$upper - out$lower, no = NA_real_
  )
  out
}
