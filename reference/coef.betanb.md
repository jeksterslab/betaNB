# Estimated Parameter Method for an Object of Class `betanb`

Estimated Parameter Method for an Object of Class `betanb`

## Usage

``` r
# S3 method for class 'betanb'
coef(object, ...)
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

Returns a vector of estimated parameters.

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
coef(object = out)
#>    NARTIC    PCTGRT   PCTSUPP 
#> 0.4951451 0.3914887 0.2632477 
```
