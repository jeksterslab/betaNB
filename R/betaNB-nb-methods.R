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
#' print(x = nb)
#'
#' @keywords methods
#' @export
print.nb <- function(x,
                     ...) {
  cat("Call:\n")
  base::print(x = x$call)
  cat(
    "\nThe first six bootstrap covariance matrices.\n\n"
  )
  base::print(
    x = utils::head(x = x$thetahatstar)
  )
}
