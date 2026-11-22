# Sampling Variance-Covariance Matrix Method for an Object of Class `betanb`

Sampling Variance-Covariance Matrix Method for an Object of Class
`betanb`

## Usage

``` r
# S3 method for class 'betanb'
vcov(object, ...)
```

## Arguments

- object:

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

- ...:

  additional arguments.

## Value

Returns the variance-covariance matrix of estimates.

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
vcov(object = out)
#>               NARTIC       PCTGRT      PCTSUPP
#> NARTIC   0.005012960 -0.002549951 -0.002273111
#> PCTGRT  -0.002549951  0.006346647 -0.002320642
#> PCTSUPP -0.002273111 -0.002320642  0.006606168
```
