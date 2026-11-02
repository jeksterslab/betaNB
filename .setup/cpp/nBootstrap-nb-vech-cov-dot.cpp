// -----------------------------------------------------------------------------
// edit functionsCpp/nBootstrap/nBootstrap-nb-vech-cov-dot.cpp
// (linked into .setup/cpp/; change it in the functionsCpp project)
// Ivan Jacob Agaloos Pesigan
// -----------------------------------------------------------------------------

#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

arma::rowvec VechCpp(const arma::mat& x);

// vech of the sample covariance matrix (denominator n - 1, as stats::cov())
// of x[idx[, r], ] for each bootstrap sample r.
// idx holds 1-based row indices, one column per bootstrap sample.
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

// vech of the leave-one-out sample covariance matrices of x
// (row i is cov(x[-i, ])), by the closed-form downdate
// S_(-i) = [(n - 1) S - n / (n - 1) d_i d_i'] / (n - 2),
// with d_i = x_i - mean(x).
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
