# Changelog

## betaNB 1.0.7.9001

- Add SCorSqNB() for the image of a signed-semipartial interval under
  squaring.

## betaNB 1.0.7.9000

### Minor

- [`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md)
  gains `adj = TRUE` for differences in adjusted R-squared.
  [`confint()`](https://rdrr.io/r/stats/confint.html) and
  [`summary()`](https://rdrr.io/r/base/summary.html) gain `type = "mpc"`
  for modified percentile intervals of Delta R-squared (sr2), unadjusted
  or adjusted. The sample F test uses the interval’s alpha and the
  unadjusted increment. Upper limits and ordinary percentile
  interpolation are unchanged. Existing defaults and `"pc"`, `"bc"`,
  `"bca"` intervals are unchanged.

- [`NB()`](https://jeksterslab.github.io/betaNB/reference/NB.md) gains
  the wild bootstrap: `type = "wild"` (default `"pairs"`, unchanged),
  with `weights` (`"rademacher"`, `"mammen"`, `"webb"`, `"normal"`),
  `hc` (`"hc3"`, `"hc0"`, `"hc1"`, `"hc2"`, `"hc4"`, `"hc4m"`, `"hc5"`;
  the same leverage adjustments as betaSandwich), and `x` (`"random"`
  resamples the regressors with their residuals, `"fixed"` keeps them).
  The effect size functions and intervals work on the wild draws
  unchanged. The sampler is in R for now.

- New
  [`FSqNB()`](https://jeksterslab.github.io/betaNB/reference/FSqNB.md):
  Cohen’s f-squared and the local f-squared of each regressor.

- Faster bootstrap: the bootstrap and jackknife covariance matrices
  (closed-form leave-one-out) and the effect sizes are computed in C++
  (Rcpp, RcppArmadillo), once per
  [`NB()`](https://jeksterslab.github.io/betaNB/reference/NB.md) call.
  The bootstrap samples are the same as before for the same seed.

- The `thetahatstar` and `jackknife` elements of `nb` and `betanb`
  objects are now matrices (one draw per row) instead of lists. `nb`
  objects also hold `es` and `es_jackknife`.

- Selective standardization: the arguments `std_y` and `std_x`
  standardize only y or only the named regressors (for example, leave a
  dummy variable in its 0-1 units). The defaults give the same results
  as before.

## betaNB 1.0.7

CRAN release: 2026-06-11

### Patch

- Minor documentation edits.

## betaNB 1.0.6

CRAN release: 2025-10-19

### Patch

- Minor edits to methods.

## betaNB 1.0.5

CRAN release: 2025-01-10

### Patch

- Minor documentation edits.

## betaNB 1.0.4

CRAN release: 2024-04-14

### Patch

- Minor documentation edits.

## betaNB 1.0.3

CRAN release: 2023-10-14

### Patch

- Minor edits to setting seed.

## betaNB 1.0.2

CRAN release: 2023-07-09

### Patch

- Edits to documentation.

## betaNB 1.0.1

CRAN release: 2023-04-12

### Patch

- Edits to the DESCRIPTION file.

## betaNB 1.0.0

### Major

- And so it begins.
