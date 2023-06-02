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
#' object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
#' nb <- NB(object, R = 100)
#' print(nb)
#'
#' @keywords methods
#' @export
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
