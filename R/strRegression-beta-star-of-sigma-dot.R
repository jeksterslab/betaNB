#' Standardized Partial Regression Slopes of
#' \eqn{\boldsymbol{\Sigma}}
#'
#' Calculate standardized partial regression slopes
#' from the covariance matrix.
#'
#' @details Let the covariance matrix of \eqn{Y} and
#'   \eqn{\mathbf{X} = \left\{ X_{1}, \dots, \X_{p} \right\}}
#'   be partitioned as follows
#'   \deqn{
#'     \boldsymbol{\Sigma}
#'     =
#'     \left(
#'     \begin{array}{cc}
#'     \sigma_{Y}^{2}
#'     &
#'     \boldsymbol{\sigma}_{Y \mathbf{X}} \\
#'     \boldsymbol{\sigma}_{\mathbf{X} Y}
#'     &
#'     \boldsymbol{\Sigma}_{\mathbf{X} \mathbf{X}}
#'     \end{array}
#'     \right) .
#'   }
#'   The corresponding correlation matrix is given by
#'   \deqn{
#'     \mathbf{P}
#'     =
#'     \mathrm{diag} \left( \boldsymbol{\sigma}^{-1} \right)
#'     \boldsymbol{\Sigma}
#'     \mathrm{diag} \left( \boldsymbol{\sigma}^{-1} \right)
#'   }
#'   where \eqn{\boldsymbol{\sigma}} is the vector of standard deviations.
#'   The vector of standardized partial regression slopes
#'   is given by
#'   \deqn{
#'     \boldsymbol{\beta}^{\ast}
#'     =
#'     \mathbf{P}_{\mathbf{X} \mathbf{X}}^{-1}
#'     \boldsymbol{\rho}_{Y \mathbf{X}} .
#'   }
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param sigmacap Numeric matrix.
#'  \eqn{\boldsymbol{\Sigma}}.
#'   Covariance matrix of
#'   \eqn{\left\{ Y, X_{1}, \dots, X_{p} \right\}}.
#' @param q Numeric vector.
#'   Inverse of the standard deviation vector of
#'   \eqn{\left\{ Y, X_{1}, \dots, X_{p} \right\}}.
#' @param k Positive integer.
#'   Dimension of the `k` by `k` covariance matrix.
#'
#' @return Returns a vector.
#' @family Standardized Slopes Functions
#' @keywords strRegression slopesstd internal
#' @noRd
.BetaStarofSigma <- function(sigmacap,
                             q,
                             k) {
  .BetaStarofRho(
    rhocap = .RhoofSigma(
      x = sigmacap,
      q = q
    ),
    k = k
  )
}
