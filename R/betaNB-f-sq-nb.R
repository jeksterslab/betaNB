#' Estimate Cohen's f-Squared and Local f-Squared
#' and Generate the Corresponding Sampling Distribution
#' Using Nonparametric Bootstrapping
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @details
#' Let \eqn{\boldsymbol{\beta}^{\ast}} be the vector of standardized slopes,
#' \eqn{\boldsymbol{R}_{x}} the correlation matrix of the regressors,
#' \eqn{r^{jj}} the \eqn{j}th diagonal element of \eqn{\boldsymbol{R}_{x}^{-1}},
#' and \eqn{R^{2} = \boldsymbol{\beta}^{\ast\prime} \boldsymbol{R}_{x}
#' \boldsymbol{\beta}^{\ast}}.
#' The semipartial correlation of regressor \eqn{j} is
#' \deqn{sr_{j} = \beta^{\ast}_{j} / \sqrt{r^{jj}} = \beta^{\ast}_{j} \sqrt{1 -
#' R^{2}_{j \cdot -j}},}
#' where \eqn{R^{2}_{j \cdot -j}} is the R-squared from regressing regressor
#' \eqn{j}
#' on the other regressors.
#' Its square, \eqn{sr^{2}_{j}}, is the change in \eqn{R^{2}} when regressor
#' \eqn{j} is added last.
#' Because \eqn{1 / r^{jj} = 1 - R^{2}_{j \cdot -j}}, \eqn{sr_{j}} shrinks
#' toward zero
#' as regressor \eqn{j} becomes more redundant with the other regressors.
#' Cohen's f-squared and the local f-squared of regressor \eqn{j} are
#' \deqn{f^{2} = \frac{R^{2}}{1 - R^{2}}, \quad f^{2}_{j} = \frac{sr^{2}_{j}}{1
#' - R^{2}}.}
#' By convention (Cohen, 1988), values of about 0.02, 0.15, and 0.35 are small,
#' medium, and large effects.
#' Each effect size is computed from every bootstrap sample
#' (see [NB()]), and the confidence intervals are percentile-based.
#'
#' @return Returns an object
#'   of class `betanb` which is a list with the following elements:
#'   \describe{
#'     \item{call}{Function call.}
#'     \item{args}{Function arguments.}
#'     \item{thetahatstar}{Sampling distribution of
#'       \eqn{f^2} (column `fsq`) and the local \eqn{f^2}
#'       (one column per regressor).}
#'     \item{jackknife}{Jackknife estimates.}
#'     \item{vcov}{Sampling variance-covariance matrix.}
#'     \item{est}{Vector of estimates.}
#'     \item{fun}{Function used ("FSqNB").}
#'   }
#'
#' @inheritParams BetaNB
#'
#' @references
#' Selya, A. S., Rose, J. S., Dierker, L. C., Hedeker, D., & Mermelstein,
#' R. J. (2012).
#' A practical guide to calculating Cohen's f2,
#' a measure of local effect size, from PROC MIXED.
#' *Frontiers in Psychology*, *3*, 111.
#' \doi{10.3389/fpsyg.2012.00111}
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
#' # FSqNB --------------------------------------------------------------------
#' out <- FSqNB(object = nb, alpha = 0.05)
#'
#' ## Methods -----------------------------------------------------------------
#' print(x = out)
#' summary(object = out)
#' coef(object = out)
#' vcov(object = out)
#' confint(object = out, level = 0.95)
#'
#' @family Beta Nonparametric Bootstrap Functions
#' @keywords betaNB fsq
#' @export
FSqNB <- function(object,
                  alpha = c(0.05, 0.01, 0.001)) {
  stopifnot(
    inherits(
      x = object,
      what = "nb"
    )
  )
  xnames <- object$lm_process$xnames
  fun <- "FSqNB"
  est <- .FSqLM(lm_process = object$lm_process)
  spcor <- object$es$spcor
  spcor_jack <- object$es_jackknife$spcor
  colnames(x = spcor) <- colnames(x = spcor_jack) <- xnames
  thetahatstar <- .FSq(
    rsq = object$es$rsq[, 1],
    spcor = spcor
  )
  jackknife <- .FSq(
    rsq = object$es_jackknife$rsq[, 1],
    spcor = spcor_jack
  )
  vcov <- stats::var(x = thetahatstar)
  colnames(x = vcov) <- rownames(x = vcov) <- names(x = est)
  out <- list(
    call = match.call(),
    args = list(
      object = object,
      alpha = alpha
    ),
    thetahatstar = thetahatstar,
    jackknife = jackknife,
    vcov = vcov,
    est = est,
    fun = fun
  )
  class(x = out) <- c(
    "betanb",
    class(x = out)
  )
  out
}
