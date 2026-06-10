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
  [`BetaNB()`](https://github.com/jeksterslab/betaNB/reference/BetaNB.md),
  [`RSqNB()`](https://github.com/jeksterslab/betaNB/reference/RSqNB.md),
  [`SCorNB()`](https://github.com/jeksterslab/betaNB/reference/SCorNB.md),
  [`DeltaRSqNB()`](https://github.com/jeksterslab/betaNB/reference/DeltaRSqNB.md),
  [`PCorNB()`](https://github.com/jeksterslab/betaNB/reference/PCorNB.md),
  or
  [`DiffBetaNB()`](https://github.com/jeksterslab/betaNB/reference/DiffBetaNB.md)
  functions.

- alpha:

  Numeric vector. Significance level \\\alpha\\. If `alpha = NULL`, use
  the argument `alpha` used in `x`.

- type:

  Charater string. Confidence interval type, that is, `type = "pc"` for
  percentile; `type = "bc"` for bias corrected; `type = "bca"` for bias
  corrected and accelerated.

- digits:

  Digits to print.

- ...:

  additional arguments.

## Value

Prints a matrix of estimates, standard errors, number of bootstrap
replications, and confidence intervals.

## Author

Ivan Jacob Agaloos Pesigan
