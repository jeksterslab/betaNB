# Confidence Intervals Method for an Object of Class `betanb`

Confidence Intervals Method for an Object of Class `betanb`

## Usage

``` r
# S3 method for class 'betanb'
confint(object, parm = NULL, level = 0.95, type = "pc", ...)
```

## Arguments

- object:

  Object of Class `betanb`, that is, the output of the
  [`BetaNB()`](https://github.com/jeksterslab/betaNB/reference/BetaNB.md),
  [`RSqNB()`](https://github.com/jeksterslab/betaNB/reference/RSqNB.md),
  [`SCorNB()`](https://github.com/jeksterslab/betaNB/reference/SCorNB.md),
  [`DeltaRSqNB()`](https://github.com/jeksterslab/betaNB/reference/DeltaRSqNB.md),
  [`PCorNB()`](https://github.com/jeksterslab/betaNB/reference/PCorNB.md),
  or
  [`DiffBetaNB()`](https://github.com/jeksterslab/betaNB/reference/DiffBetaNB.md)
  functions.

- parm:

  a specification of which parameters are to be given confidence
  intervals, either a vector of numbers or a vector of names. If
  missing, all parameters are considered.

- level:

  the confidence level required.

- type:

  Charater string. Confidence interval type, that is, `type = "pc"` for
  percentile; `type = "bc"` for bias corrected; `type = "bca"` for bias
  corrected and accelerated.

- ...:

  additional arguments.

## Value

Returns a matrix of confidence intervals.

## Author

Ivan Jacob Agaloos Pesigan
