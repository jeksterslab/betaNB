// -----------------------------------------------------------------------------
// edit .setup/cpp/000-forward-declarations.cpp
// Ivan Jacob Agaloos Pesigan
// -----------------------------------------------------------------------------

#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

arma::mat JackknifeVechCov(const arma::mat& x);

arma::mat NBVechCov(const arma::mat& x, const arma::umat& idx);

Rcpp::NumericVector Quantile(const arma::vec& x, const arma::vec& probs);

Rcpp::List StrRegressionofVechSigmaMat(const arma::mat& vechsigmacap,
                                       const arma::uword& k);

arma::mat SymofVechCpp(const arma::rowvec& x, const arma::uword& k);

arma::rowvec VechCpp(const arma::mat& x);
