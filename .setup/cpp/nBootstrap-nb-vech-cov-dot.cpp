// -----------------------------------------------------------------------------
// edit .setup/cpp/nBootstrap-nb-vech-cov-dot.cpp
// Ivan Jacob Agaloos Pesigan
// -----------------------------------------------------------------------------

#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

//' Nonparametric Bootstrap Half-Vectorized Covariance Matrices (C++)
//'
//' Half-vectorization of the sample covariance matrix
//' (denominator \eqn{n - 1}, as `stats::cov()`)
//' of `x[idx[, r], ]` for each bootstrap sample `r`.
//'
//' @author Ivan Jacob Agaloos Pesigan
//'
//' @param x Numeric \eqn{n \times k} matrix.
//'   Data.
//' @param idx Integer matrix.
//'   1-based row indices, one column per bootstrap sample.
//'
//' @return Numeric matrix with one row per bootstrap sample
//'   and \eqn{k (k + 1) / 2} columns.
//'
//' @examples
//' x <- matrix(data = c(1, 2, 4, 3, 5, 9), nrow = 3)
//' idx <- matrix(data = c(1L, 2L, 3L, 3L, 2L, 1L), nrow = 3)
//' .NBVechCov(x = x, idx = idx)
//'
//' @noRd
// [[Rcpp::export(.NBVechCov)]]
arma::mat NBVechCov(const arma::mat& x, const arma::umat& idx) {
  const arma::uword k = x.n_cols;
  const arma::uword n_boot = idx.n_cols;
  arma::mat out(n_boot, k * (k + 1) / 2);
  for (arma::uword r = 0; r < n_boot; r++) {
    const arma::mat xr = x.rows(idx.col(r) - 1);
    out.row(r) = VechCpp(arma::cov(xr));
  }
  return out;
}

//' Leave-One-Out Half-Vectorized Covariance Matrices (C++)
//'
//' Half-vectorization of the leave-one-out sample covariance matrices
//' of `x` (row `i` is `stats::cov(x[-i, ])`),
//' by the closed-form downdate
//' \eqn{S_{(-i)} = [(n - 1) S - n / (n - 1) d_i d_i'] / (n - 2)},
//' with \eqn{d_i = x_i - \bar{x}}.
//'
//' @author Ivan Jacob Agaloos Pesigan
//'
//' @param x Numeric \eqn{n \times k} matrix.
//'   Data.
//'
//' @return Numeric matrix with \eqn{n} rows
//'   and \eqn{k (k + 1) / 2} columns.
//'
//' @examples
//' x <- matrix(data = c(1, 2, 4, 7, 3, 5, 9, 8), nrow = 4)
//' .JackknifeVechCov(x = x)
//'
//' @noRd
// [[Rcpp::export(.JackknifeVechCov)]]
arma::mat JackknifeVechCov(const arma::mat& x) {
  const arma::uword n = x.n_rows;
  const arma::uword k = x.n_cols;
  const double nd = static_cast<double>(n);
  const arma::rowvec mu = arma::mean(x, 0);
  const arma::mat ss = (nd - 1.0) * arma::cov(x);
  arma::mat out(n, k * (k + 1) / 2);
  for (arma::uword i = 0; i < n; i++) {
    const arma::vec d = (x.row(i) - mu).t();
    out.row(i) = VechCpp((ss - (nd / (nd - 1.0)) * (d * d.t())) / (nd - 2.0));
  }
  return out;
}
