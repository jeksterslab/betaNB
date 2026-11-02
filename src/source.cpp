// -----------------------------------------------------------------------------
// edit functionsCpp/linearAlgebra/linearAlgebra-sym-of-vech-dot.cpp
// (linked into .setup/cpp/; change it in the functionsCpp project)
// Ivan Jacob Agaloos Pesigan
// -----------------------------------------------------------------------------

#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// Symmetric k x k matrix from its half-vectorization
// (lower triangle, column by column, as .Vech() in R).
arma::mat SymofVechCpp(const arma::rowvec& x, const arma::uword k) {
  arma::mat out(k, k);
  arma::uword idx = 0;
  for (arma::uword j = 0; j < k; j++) {
    for (arma::uword i = j; i < k; i++) {
      out(i, j) = x(idx);
      out(j, i) = x(idx);
      idx++;
    }
  }
  return out;
}

// Half-vectorization of a square matrix
// (lower triangle, column by column, as .Vech() in R).
arma::rowvec VechCpp(const arma::mat& x) {
  const arma::uword k = x.n_rows;
  arma::rowvec out(k * (k + 1) / 2);
  arma::uword idx = 0;
  for (arma::uword j = 0; j < k; j++) {
    for (arma::uword i = j; i < k; i++) {
      out(idx) = x(i, j);
      idx++;
    }
  }
  return out;
}
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
// -----------------------------------------------------------------------------
// edit
// functions/strRegression/strRegression-str-regression-of-vech-sigma-mat-dot.cpp
// (linked into .setup/cpp/; change it in the functionsCpp project)
// Ivan Jacob Agaloos Pesigan
// -----------------------------------------------------------------------------

#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

arma::mat SymofVechCpp(const arma::rowvec& x, const arma::uword k);

// Regression effect sizes for each row of vech(sigmacap),
// where sigmacap is the covariance matrix of (y, x_1, ..., x_p):
// standardized slopes (betastar), R-squared (rsq),
// semipartial correlations (spcor),
// and squared partial correlations (pcorsq).
// Same quantities as .BetaStarofSigma(), .RSqofSigma(), .SPCor(),
// and .PCorSq() in R. Rows that fail are NA.
// [[Rcpp::export(.StrRegressionofVechSigmaMat)]]
Rcpp::List StrRegressionofVechSigmaMat(const arma::mat& vechsigmacap,
                                       const arma::uword k) {
  const arma::uword n = vechsigmacap.n_rows;
  const arma::uword p = k - 1;
  arma::mat betastar(n, p);
  arma::vec rsq(n);
  arma::mat spcor(n, p);
  arma::mat pcorsq(n, p);
  for (arma::uword r = 0; r < n; r++) {
    const arma::mat sigmacap = SymofVechCpp(vechsigmacap.row(r), k);
    const arma::mat sigmacapx = sigmacap.submat(1, 1, p, p);
    const arma::vec sigmayx = sigmacap.submat(1, 0, p, 0);
    const double sigmaysq = sigmacap(0, 0);
    arma::vec beta;
    bool ok =
        sigmaysq > 0 && arma::all(sigmacapx.diag() > 0) &&
        arma::solve(beta, sigmacapx, sigmayx, arma::solve_opts::likely_sympd);
    arma::mat invrhocapx;
    arma::vec sigmax;
    if (ok) {
      sigmax = arma::sqrt(sigmacapx.diag());
      const arma::mat rhocapx = sigmacapx / (sigmax * sigmax.t());
      ok = arma::inv_sympd(invrhocapx, rhocapx);
    }
    if (ok) {
      const double sigmay = std::sqrt(sigmaysq);
      const arma::vec b = beta % sigmax / sigmay;
      const double r2 = arma::dot(sigmayx, beta) / sigmaysq;
      const arma::vec sr = b % arma::sqrt(1.0 / invrhocapx.diag());
      const arma::vec srsq = arma::square(sr);
      betastar.row(r) = b.t();
      rsq(r) = r2;
      spcor.row(r) = sr.t();
      pcorsq.row(r) = (srsq / (1.0 - (r2 - srsq))).t();
    } else {
      betastar.row(r).fill(arma::datum::nan);
      rsq(r) = arma::datum::nan;
      spcor.row(r).fill(arma::datum::nan);
      pcorsq.row(r).fill(arma::datum::nan);
    }
  }
  return Rcpp::List::create(
      Rcpp::Named("betastar") = betastar, Rcpp::Named("rsq") = rsq,
      Rcpp::Named("spcor") = spcor, Rcpp::Named("pcorsq") = pcorsq);
}
