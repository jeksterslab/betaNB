#' Print Method for an Object of Class `nb`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Prints the first six bootstrap covariance matrices.
#'
#' @param x Object of Class `nb`.
#' @param ... additional arguments.
#'
#' @examples
#' # Fit the regression model
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' # Generate bootstrap covariance matrices
#' # (use a large R, for example, R = 5000 for actual research)
#' nb <- NB(object, R = 50)
#' print(nb)
#' @export
#' @keywords methods
print.nb <- function(x,
                     ...) {
  cat("Call:\n")
  base::print(x$call)
  cat(
    "\nThe first six bootstrap covariance matrices.\n\n"
  )
  base::print(
    utils::head(x$thetahatstar)
  )
}
