# betaNB 1.0.7.9000

## Minor

* New `FSqNB()`: Cohen's f-squared and the local f-squared of each
  regressor.
* Faster bootstrap: the bootstrap and jackknife covariance matrices
  (closed-form leave-one-out) and the effect sizes are computed in C++
  (Rcpp, RcppArmadillo), once per `NB()` call. The bootstrap samples are
  the same as before for the same seed.
* The `thetahatstar` and `jackknife` elements of `nb` and `betanb`
  objects are now matrices (one draw per row) instead of lists. `nb`
  objects also hold `es` and `es_jackknife`.
* Selective standardization: the arguments `std_y` and `std_x` standardize
  only y or only the named regressors (for example, leave a dummy
  variable in its 0-1 units). The defaults give the same results as
  before.

# betaNB 1.0.7

## Patch

* Minor documentation edits.

# betaNB 1.0.6

## Patch

* Minor edits to methods.

# betaNB 1.0.5

## Patch

* Minor documentation edits.

# betaNB 1.0.4

## Patch

* Minor documentation edits.

# betaNB 1.0.3

## Patch

* Minor edits to setting seed.

# betaNB 1.0.2

## Patch

* Edits to documentation.

# betaNB 1.0.1

## Patch

* Edits to the DESCRIPTION file.

# betaNB 1.0.0

## Major

* And so it begins.
