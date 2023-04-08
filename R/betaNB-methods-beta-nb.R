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
#'   `DeltaRSqNB()`, or
#'   `PCorNB()`
#'   functions.
#' @inheritParams summary.betanb
#'
#' @examples
#' # Fit the regression model
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' # Generate bootstrap covariance matrices
#' # (use a large R, for example, R = 5000 for actual research)
#' nb <- NB(object, R = 50)
#' # Generate confidence intervals for standardized regression slopes
#' std <- BetaNB(nb)
#' # Method ---------------------------------------------------------
#' print(std, type = "pc")
#' print(std, type = "bc")
#' print(std, type = "bca")
#' @export
#' @keywords methods
print.betanb <- function(x,
                         alpha = c(0.05, 0.01, 0.001),
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
#'   `DeltaRSqNB()`, or
#'   `PCorNB()`
#'   functions.
#' @param ... additional arguments.
#' @param alpha Significance level.
#' @param type Charater string.
#'   Confidence interval type, that is,
#'   `type = "pc"` for percentile;
#'   `type = "bc"` for bias corrected;
#'   `type = "bca"` for bias corrected and accelerated.
#' @param digits Digits to print.
#'
#' @examples
#' # Fit the regression model
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' # Generate bootstrap covariance matrices
#' # (use a large R, for example, R = 5000 for actual research)
#' nb <- NB(object, R = 50)
#' # Generate confidence intervals for standardized regression slopes
#' std <- BetaNB(nb)
#' # Method ---------------------------------------------------------
#' summary(std, type = "pc")
#' summary(std, type = "bc")
#' summary(std, type = "bca")
#' @export
#' @keywords methods
summary.betanb <- function(object,
                           alpha = c(0.05, 0.01, 0.001),
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
#' @examples
#' # Fit the regression model
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' # Generate bootstrap covariance matrices
#' # (use a large R, for example, R = 5000 for actual research)
#' nb <- NB(object, R = 50)
#' # Generate confidence intervals for standardized regression slopes
#' std <- BetaNB(nb)
#' # Method ---------------------------------------------------------
#' vcov(std)
#' @export
#' @keywords methods
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
#' @examples
#' # Fit the regression model
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' # Generate bootstrap covariance matrices
#' # (use a large R, for example, R = 5000 for actual research)
#' nb <- NB(object, R = 50)
#' # Generate confidence intervals for standardized regression slopes
#' std <- BetaNB(nb)
#' # Method ---------------------------------------------------------
#' coef(std)
#' @export
#' @keywords methods
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
#' @examples
#' # Fit the regression model
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' # Generate bootstrap covariance matrices
#' # (use a large R, for example, R = 5000 for actual research)
#' nb <- NB(object, R = 50)
#' # Generate confidence intervals for standardized regression slopes
#' std <- BetaNB(nb)
#' # Method ---------------------------------------------------------
#' confint(std, level = 0.95, type = "pc")
#' confint(std, level = 0.95, type = "bc")
#' confint(std, level = 0.95, type = "bca")
#' @export
#' @keywords methods
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
  return(
    .CI(
      object = object,
      alpha = 1 - level[1],
      type = type
    )[parm, 4:5]
  )
}
