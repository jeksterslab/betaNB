#' Print Method for an Object of Class `betanb`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Prints a matrix of estimates, standard errors,
#'   number of bootstrap replications, and confidence intervals.
#'
#' @param x Object of Class `betanb`,
#'   that is,
#'   the output of the [BetaNB()], [RSqNB()], [SCorNB()], [DeltaRSqNB()],
#'   [PCorNB()], [FSqNB()], or [DiffBetaNB()] functions.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#'   If `alpha = NULL`,
#'   use the argument `alpha` used in `x`.
#' @inheritParams summary.betanb
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
#'
#' @keywords methods
#' @export
print.betanb <- function(x,
                         alpha = NULL,
                         type = "pc",
                         digits = 4,
                         ...) {
  print.summary.betanb(
    x = summary.betanb(
      object = x,
      alpha = alpha,
      type = type,
      digits = digits
    )
  )
}

#' Summary Method for an Object of Class `betanb`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @details
#' Let \eqn{\hat{\theta}} be the estimate,
#' \eqn{\hat{\theta}^{\ast}_{1}, \dots, \hat{\theta}^{\ast}_{R}} the bootstrap
#' draws with empirical distribution function \eqn{\hat{G}},
#' \eqn{\Phi} the standard normal distribution function,
#' and \eqn{z_{p} = \Phi^{-1} \left( p \right)}.
#' The limits of a \eqn{100 \left( 1 - \alpha \right) \%} interval are
#' \eqn{\hat{G}^{-1} \left( p_{1} \right)} and
#' \eqn{\hat{G}^{-1} \left( p_{2} \right)}
#' (type 7 quantiles of the draws).
#' The percentile interval (`type = "pc"`) uses
#' \eqn{p_{1} = \alpha / 2} and \eqn{p_{2} = 1 - \alpha / 2}.
#' The bias-corrected interval (`type = "bc"`) uses
#' \deqn{p_{k} = \Phi \left( 2 \hat{z}_{0} + z_{\alpha_{k}} \right), \quad
#' \hat{z}_{0} = \Phi^{-1} \left( \frac{1}{R} \sum_{b = 1}^{R}
#' I \left( \hat{\theta}^{\ast}_{b} < \hat{\theta} \right) \right),}
#' where \eqn{I} is the indicator function,
#' \eqn{\alpha_{1} = \alpha / 2}, and \eqn{\alpha_{2} = 1 - \alpha / 2}.
#' The bias-corrected and accelerated interval (`type = "bca"`) uses
#' \deqn{p_{k} = \Phi \left( \hat{z}_{0} + \frac{\hat{z}_{0} +
#' z_{\alpha_{k}}}{1 - \hat{a} \left( \hat{z}_{0} + z_{\alpha_{k}} \right)}
#' \right), \quad \hat{a} = \frac{\sum_{i = 1}^{n} \left(
#' \bar{\theta}_{\left( \cdot \right)} - \hat{\theta}_{\left( -i \right)}
#' \right)^{3}}{6 \left[ \sum_{i = 1}^{n} \left(
#' \bar{\theta}_{\left( \cdot \right)} - \hat{\theta}_{\left( -i \right)}
#' \right)^{2} \right]^{3 / 2}},}
#' where \eqn{\hat{\theta}_{\left( -i \right)}} is the jackknife estimate
#' without observation \eqn{i} and \eqn{\bar{\theta}_{\left( \cdot \right)}}
#' is their mean (Efron & Tibshirani, 1993).
#' Failed draws are dropped.
#' The modified percentile interval (`type = "mpc"`) is described in
#' [DeltaRSqNB()].
#'
#' @references
#' Efron, B., & Tibshirani, R. J. (1993).
#' *An introduction to the bootstrap*.
#' Chapman & Hall.
#' \doi{10.1201/9780429246593}
#'
#' @return Returns a matrix of
#'   estimates,
#'   standard errors,
#'   number of bootstrap replications,
#'   and
#'   confidence intervals.
#'
#' @param object Object of Class `betanb`,
#'   that is,
#'   the output of the [BetaNB()], [RSqNB()], [SCorNB()], [DeltaRSqNB()],
#'   [PCorNB()], [FSqNB()], or [DiffBetaNB()] functions.
#' @param ... additional arguments.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#'   If `alpha = NULL`,
#'   use the argument `alpha` used in `object`.
#' @param type Character string.
#'   Confidence interval type, that is,
#'   `type = "pc"` for percentile;
#'   `type = "bc"` for bias corrected;
#'   `type = "bca"` for bias corrected and accelerated;
#'   `type = "mpc"` for modified percentile, available only for
#'   [DeltaRSqNB()] (unadjusted or `adj = TRUE`).
#' @param digits Digits to print.
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
#' summary(object = out)
#'
#' @keywords methods
#' @export
summary.betanb <- function(object,
                           alpha = NULL,
                           type = "pc",
                           digits = 4,
                           ...) {
  ci <- .CI(
    object = object,
    alpha = alpha,
    type = type
  )
  print_summary <- round(
    x = ci,
    digits = digits
  )
  attr(
    x = ci,
    which = "fit"
  ) <- object
  attr(
    x = ci,
    which = "print_summary"
  ) <- print_summary
  attr(
    x = ci,
    which = "alpha"
  ) <- alpha
  attr(
    x = ci,
    which = "type"
  ) <- type
  attr(
    x = ci,
    which = "digits"
  ) <- digits
  class(x = ci) <- "summary.betanb"
  ci
}

#' @noRd
#' @keywords internal
#' @exportS3Method print summary.betanb
print.summary.betanb <- function(x,
                                 ...) {
  print_summary <- attr(
    x = x,
    which = "print_summary"
  )
  type <- attr(
    x = x,
    which = "type"
  )
  object <- attr(
    x = x,
    which = "fit"
  )
  if (object$fun == "BetaNB") {
    label <- "Standardized regression slopes"
  }
  if (object$fun == "RSqNB") {
    label <- "R-squared and adjusted R-squared"
  }
  if (object$fun == "SCorNB") {
    label <- "Semipartial correlations"
  }
  if (object$fun == "DeltaRSqNB") {
    label <- "Improvement in R-squared"
  }
  if (object$fun == "DeltaRSqAdjNB") {
    label <- "Improvement in adjusted R-squared"
  }
  if (object$fun == "PCorNB") {
    label <- "Squared partial correlations"
  }
  if (object$fun == "DiffBetaNB") {
    label <- "Differences of standardized regression slopes"
  }
  if (object$fun == "FSqNB") {
    label <- "Cohen's f-squared (fsq) and local f-squared"
  }
  cat("Call:\n")
  base::print(x = object$call)
  cat(
    paste0(
      "\n",
      label,
      "\n",
      "type = ",
      "\"",
      type,
      "\"",
      "\n"
    )
  )
  print(x = print_summary)
  invisible(x = x)
}

#' Sampling Variance-Covariance Matrix Method for an Object of Class `betanb`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns the variance-covariance matrix of estimates.
#'
#' @inheritParams summary.betanb
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
#' vcov(object = out)
#'
#' @keywords methods
#' @export
vcov.betanb <- function(object,
                        ...) {
  object$vcov
}

#' Estimated Parameter Method for an Object of Class `betanb`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a vector of estimated parameters.
#'
#' @inheritParams summary.betanb
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
#' coef(object = out)
#'
#' @keywords methods
#' @export
coef.betanb <- function(object,
                        ...) {
  object$est
}

#' Confidence Intervals Method for an Object of Class `betanb`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of confidence intervals.
#'
#' @inherit summary.betanb details references
#'
#' @inheritParams summary.betanb
#' @param parm a specification of which parameters
#'   are to be given confidence intervals,
#'   either a vector of numbers or a vector of names.
#'   If missing, all parameters are considered.
#' @param level the confidence level required.
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
#' confint(object = out, level = 0.95)
#'
#' @keywords methods
#' @export
confint.betanb <- function(object,
                           parm = NULL,
                           level = 0.95,
                           type = "pc",
                           ...) {
  if (is.null(x = parm)) {
    parm <- seq_along(
      along.with = object$est
    )
  }
  ci <- .CI(
    object = object,
    alpha = 1 - level[1],
    type = type
  )[parm, 4:5, drop = FALSE]
  varnames <- colnames(x = ci)
  varnames <- gsub(
    pattern = "%",
    replacement = " %",
    x = varnames
  )
  colnames(x = ci) <- varnames
  ci
}
