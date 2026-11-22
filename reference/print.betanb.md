# Print Method for an Object of Class `betanb`

Print Method for an Object of Class `betanb`

## Usage

``` r
# S3 method for class 'betanb'
print(x, alpha = NULL, type = "pc", digits = 4, ...)
```

## Arguments

- x:

  Object of Class `betanb`, that is, the output of the
  [`BetaNB()`](https://jeksterslab.github.io/betaNB/reference/BetaNB.md),
  [`RSqNB()`](https://jeksterslab.github.io/betaNB/reference/RSqNB.md),
  [`SCorNB()`](https://jeksterslab.github.io/betaNB/reference/SCorNB.md),
  [`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md),
  [`PCorNB()`](https://jeksterslab.github.io/betaNB/reference/PCorNB.md),
  [`FSqNB()`](https://jeksterslab.github.io/betaNB/reference/FSqNB.md),
  or
  [`DiffBetaNB()`](https://jeksterslab.github.io/betaNB/reference/DiffBetaNB.md)
  functions.

- alpha:

  Numeric vector. Significance level \\(\alpha\\). If `alpha = NULL`,
  use the argument `alpha` used in `x`.

- type:

  Character string. Confidence interval type, that is, `type = "pc"` for
  percentile; `type = "bc"` for bias corrected; `type = "bca"` for bias
  corrected and accelerated; `type = "mpc"` for modified percentile,
  available only for
  [`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md)
  (unadjusted or `adj = TRUE`).

- digits:

  Digits to print.

- ...:

  additional arguments.

## Value

Prints a matrix of estimates, standard errors, number of bootstrap
replications, and confidence intervals.

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
# Data ---------------------------------------------------------------------
data("nas1982", package = "betaNB")

# Fit Model in lm ----------------------------------------------------------
object <- stats::lm(
  formula = QUALITY ~ NARTIC + PCTGRT + PCTSUPP,
  data = nas1982
)

# NB -----------------------------------------------------------------------
nb <- NB(
  object = object,
  R = 100, # use a large value e.g., 5000L for actual research
  seed = 0508
)

# BetaNB -------------------------------------------------------------------
out <- BetaNB(object = nb, alpha = 0.05)

## Methods -----------------------------------------------------------------
print(x = out)
#> Call:
#> BetaNB(object = nb, alpha = 0.05)
#> 
#> Standardized regression slopes
#> type = "pc"
#>            est     se   R   2.5%  97.5%
#> NARTIC  0.4951 0.0708 100 0.3498 0.6141
#> PCTGRT  0.3915 0.0797 100 0.2440 0.5192
#> PCTSUPP 0.2632 0.0813 100 0.1033 0.4193
```
