#' Standardized Partial Regression Slopes of
#' \eqn{\boldsymbol{\Sigma}}
#'
#' Calculate standardized partial regression slopes
#' from the covariance matrix.
#'
#' @details Let the covariance matrix of \eqn{Y} and
#'   \eqn{\boldsymbol{X} = \left\{ X_{1}, \dots, X_{p} \right\}}
#'   be partitioned as follows
#'   \deqn{
#'     \boldsymbol{\Sigma}
#'     =
#'     \left(
#'     \begin{array}{cc}
#'     \sigma_{Y}^{2}
#'     &
#'     \boldsymbol{\sigma}_{Y \boldsymbol{X}} \\
#'     \boldsymbol{\sigma}_{\boldsymbol{X} Y}
#'     &
#'     \boldsymbol{\Sigma}_{\boldsymbol{X} \boldsymbol{X}}
#'     \end{array}
#'     \right) .
#'   }
#'   The corresponding correlation matrix is given by
#'   \deqn{
#'     \boldsymbol{P}
#'     =
#'     \operatorname{diag} \left( \boldsymbol{\sigma}^{-1} \right)
#'     \boldsymbol{\Sigma}
#'     \operatorname{diag} \left( \boldsymbol{\sigma}^{-1} \right)
#'   }
#'   where \eqn{\boldsymbol{\sigma}} is the vector of standard deviations.
#'   The vector of standardized partial regression slopes
#'   is given by
#'   \deqn{
#'     \boldsymbol{\beta}^{\ast}
#'     =
#'     \boldsymbol{P}_{\boldsymbol{X} \boldsymbol{X}}^{-1}
#'     \boldsymbol{\rho}_{Y \boldsymbol{X}} .
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
#' @examples
#' beta <- c(0.5, 0.3)
#' sigmacapx <- matrix(data = c(1, 0.2, 0.2, 2), nrow = 2)
#' sigmacap <- matrix(
#'   data = c(0.89, 0.56, 0.7, 0.56, 1, 0.2, 0.7, 0.2, 2),
#'   nrow = 3
#' )
#' strRegression:::.BetaStarofSigma(
#'   sigmacap = sigmacap,
#'   q = 1 / sqrt(diag(sigmacap)),
#'   k = 3
#' )
#'
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
