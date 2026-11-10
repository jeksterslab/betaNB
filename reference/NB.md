# Generate the Sampling Distribution of Sample Covariances Using Nonparametric Bootstrapping

Generate the Sampling Distribution of Sample Covariances Using
Nonparametric Bootstrapping

## Usage

``` r
NB(
  object,
  R = 5000L,
  seed = NULL,
  type = c("pairs", "wild"),
  weights = c("rademacher", "mammen", "webb", "normal"),
  hc = c("hc3", "hc0", "hc1", "hc2", "hc4", "hc4m", "hc5"),
  x = c("random", "fixed")
)
```

## Arguments

- object:

  Object of class `lm`.

- R:

  Positive integer. Number of bootstrap replications.

- seed:

  Integer. Seed number for reproducibility.

- type:

  Character string. Bootstrap sampler. `"pairs"` (default) resamples the
  rows of the data (nonparametric bootstrap). `"wild"` is the wild
  bootstrap, which generates \\(y_i^{\*} = \mathbf{x}\_i^{\prime}
  \hat{\boldsymbol{\beta}} + f(h_i) e_i v_i\\), where \\(e_i\\) is the
  residual, \\(h_i\\) is the leverage, \\(v_i\\) is a random weight with
  mean 0 and variance 1, and \\(f(h_i)\\) is set by `hc`. The arguments
  `weights`, `hc`, and `x` are used only with `type = "wild"`.

- weights:

  Character string. Distribution of \\(v_i\\): `"rademacher"` (default;
  -1 or 1 with equal probability), `"mammen"` (two-point distribution
  with third moment 1), `"webb"` (six-point distribution), or `"normal"`
  (standard normal).

- hc:

  Character string. Adjustment of the residuals, with the same
  definitions as the heteroskedasticity-consistent sampling covariance
  matrices of `betaSandwich`: `"hc3"` (default), `"hc0"`, `"hc1"`,
  `"hc2"`, `"hc4"`, `"hc4m"`, or `"hc5"`. A leverage equal to 1 is an
  error for every type except `"hc0"` and `"hc1"`.

- x:

  Character string. `"random"` (default) resamples the rows \\(\left(
  \mathbf{x}\_i, f(h_i) e_i \right)\\) together before the weights are
  applied, so the sampling variability of the regressors is kept.
  `"fixed"` keeps the regressors of the data in every sample
  (conditional wild bootstrap); the covariance matrix of the regressors
  is then the same in every sample.

## Value

Returns an object of class `nb` which is a list with the following
elements:

- call:

  Function call.

- args:

  Function arguments.

- lm_process:

  Processed `lm` object.

- thetahatstar:

  Sampling distribution of sample covariances (a matrix; each row is the
  half-vectorization of one bootstrap covariance matrix).

- jackknife:

  Jackknife estimates (a matrix; each row is the half-vectorization of
  one leave-one-out covariance matrix).

- es:

  Effect sizes of the bootstrap samples (a list of matrices).

- es_jackknife:

  Effect sizes of the jackknife samples (a list of matrices).

## References

Efron, B., & Tibshirani, R. J. (1993) *An introduction to the
bootstrap*. Chapman & Hall.

## See also

Other Beta Nonparametric Bootstrap Functions:
[`BetaNB()`](https://jeksterslab.github.io/betaNB/reference/BetaNB.md),
[`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md),
[`DiffBetaNB()`](https://jeksterslab.github.io/betaNB/reference/DiffBetaNB.md),
[`FSqNB()`](https://jeksterslab.github.io/betaNB/reference/FSqNB.md),
[`PCorNB()`](https://jeksterslab.github.io/betaNB/reference/PCorNB.md),
[`RSqNB()`](https://jeksterslab.github.io/betaNB/reference/RSqNB.md),
[`SCorNB()`](https://jeksterslab.github.io/betaNB/reference/SCorNB.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
# Data ---------------------------------------------------------------------
data("nas1982", package = "betaNB")

# Fit Model in lm ----------------------------------------------------------
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)

# NB -----------------------------------------------------------------------
nb <- NB(
  object,
  R = 100, # use a large value e.g., 20000L for actual research
  seed = 0508
)
nb
#> Call:
#> NB(object = object, R = 100, seed = 508)
#> 
#> The first six bootstrap covariance matrices.
#> 
#>           [,1]     [,2]     [,3]     [,4]     [,5]     [,6]     [,7]     [,8]
#> [1,] 104.87150 489.5053 112.6802 187.9391 2967.631 563.7749 844.3464 267.0512
#> [2,] 129.76087 537.8783 160.9517 223.1705 3217.043 612.2077 931.1923 389.8048
#> [3,]  68.31353 309.2290 101.9329 108.6063 2514.126 433.4164 480.6309 404.9957
#> [4,]  99.90966 533.2034 119.6609 144.6464 4584.244 536.1246 709.2473 306.1990
#> [5,] 124.06039 583.9411 141.2575 183.6101 4629.755 602.2386 732.7140 293.4208
#> [6,] 104.78841 472.3159 159.0193 163.9565 3566.429 696.9957 576.1792 357.8382
#>          [,9]    [,10]
#> [1,] 213.5585 484.8758
#> [2,] 251.7507 613.0826
#> [3,] 159.9232 442.2652
#> [4,] 173.3411 602.6048
#> [5,] 183.9396 649.0246
#> [6,] 230.7947 625.7203
# The `nb` object can be passed as the first argument
# to the following functions
#   - BetaNB
#   - DeltaRSqNB
#   - DiffBetaNB
#   - PCorNB
#   - RSqNB
#   - SCorNB
```
