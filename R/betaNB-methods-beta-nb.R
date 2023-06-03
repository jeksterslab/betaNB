#' Print Method for an Object of Class
#' `betanb`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Prints a matrix of
#'   estimates,
#'   standard errors,
#'   number of bootstrap replications,
#'   and
#'   confidence intervals.
#'
#' @param x Object of Class `betanb`,
#'   that is,
#'   the output of the
#'   `BetaNB()`,
#'   `RSqNB()`,
#'   `SCorNB()`,
#'   `DeltaRSqNB()`,
#'   `PCorNB()`, or
#'   `DiffBetaNB()`
#'   functions.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#'   If `alpha = NULL`,
#'   use the argument `alpha` used in `x`.
#' @inheritParams summary.betanb
#'
#' @keywords methods
#' @export
print.betanb <- function(x,
                         alpha = NULL,
                         type = "pc",
                         digits = 4,
                         ...) {
  if (x$fun == "BetaNB") {
    label <- "Standardized regression slopes"
  }
  if (x$fun == "RSqNB") {
    label <- "R-squared and adjusted R-squared"
  }
  if (x$fun == "SCorNB") {
    label <- "Semipartial correlations"
  }
  if (x$fun == "DeltaRSqNB") {
    label <- "Improvement in R-squared"
  }
  if (x$fun == "PCorNB") {
    label <- "Squared partial correlations"
  }
  if (x$fun == "DiffBetaNB") {
    label <- "Differences of standardized regression slopes"
  }
  cat("Call:\n")
  base::print(x$call)
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
  base::print(
    round(
      .CI(
        object = x,
        alpha = alpha,
        type = type
      ),
      digits = digits
    )
  )
}

#' Summary Method for an Object of Class
#' `betanb`
#'
#' @author Ivan Jacob Agaloos Pesigan
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
#'   the output of the
#'   `BetaNB()`,
#'   `RSqNB()`,
#'   `SCorNB()`,
#'   `DeltaRSqNB()`,
#'   `PCorNB()`, or
#'   `DiffBetaNB()`
#'   functions.
#' @param ... additional arguments.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#'   If `alpha = NULL`,
#'   use the argument `alpha` used in `object`.
#' @param type Charater string.
#'   Confidence interval type, that is,
#'   `type = "pc"` for percentile;
#'   `type = "bc"` for bias corrected;
#'   `type = "bca"` for bias corrected and accelerated.
#' @param digits Digits to print.
#'
#' @keywords methods
#' @export
summary.betanb <- function(object,
                           alpha = NULL,
                           type = "pc",
                           digits = 4,
                           ...) {
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
  if (object$fun == "PCorNB") {
    label <- "Squared partial correlations"
  }
  if (object$fun == "DiffBetaNB") {
    label <- "Differences of standardized regression slopes"
  }
  cat("Call:\n")
  base::print(object$call)
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
  return(
    round(
      .CI(
        object = object,
        alpha = alpha,
        type = type
      ),
      digits = digits
    )
  )
}

#' Sampling Variance-Covariance Matrix Method for an Object of Class
#' `betanb`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns the variance-covariance matrix of estimates.
#'
#' @inheritParams summary.betanb
#'
#' @keywords methods
#' @export
vcov.betanb <- function(object,
                        ...) {
  return(
    object$vcov
  )
}

#' Estimated Parameter Method for an Object of Class
#' `betanb`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a vector of estimated parameters.
#'
#' @inheritParams summary.betanb
#'
#' @keywords methods
#' @export
coef.betanb <- function(object,
                        ...) {
  return(
    object$est
  )
}

#' Confidence Intervals Method for an Object of Class
#' `betanb`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of confidence intervals.
#'
#' @inheritParams summary.betanb
#' @param parm a specification of which parameters
#'   are to be given confidence intervals,
#'   either a vector of numbers or a vector of names.
#'   If missing, all parameters are considered.
#' @param level the confidence level required.
#'
#' @keywords methods
#' @export
confint.betanb <- function(object,
                           parm = NULL,
                           level = 0.95,
                           type = "pc",
                           ...) {
  if (is.null(parm)) {
    parm <- seq_len(
      length(
        object$est
      )
    )
  }
  ci <- .CI(
    object = object,
    alpha = 1 - level[1],
    type = type
  )[parm, 4:5, drop = FALSE]
  varnames <- colnames(ci)
  varnames <- gsub(
    pattern = "%",
    replacement = " %",
    x = varnames
  )
  colnames(ci) <- varnames
  return(
    ci
  )
}
