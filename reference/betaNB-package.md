# betaNB: Nonparametric Bootstrap Confidence Intervals for Standardized Regression Coefficients

Generates nonparametric bootstrap confidence intervals for standardized
regression coefficients and other effect sizes for models fitted by
[`stats::lm()`](https://rdrr.io/r/stats/lm.html) (Efron & Tibshirani,
1993).

## Bootstrap

[`NB()`](https://jeksterslab.github.io/betaNB/reference/NB.md) generates
the bootstrap samples, either by resampling cases (`type = "pairs"`) or
by the wild bootstrap (`type = "wild"`). The arguments `std_y` and
`std_x` standardize only the outcome or only the named regressors.

## Effect sizes

[`BetaNB()`](https://jeksterslab.github.io/betaNB/reference/BetaNB.md)
(standardized regression coefficients),
[`DiffBetaNB()`](https://jeksterslab.github.io/betaNB/reference/DiffBetaNB.md)
(differences of standardized slopes),
[`RSqNB()`](https://jeksterslab.github.io/betaNB/reference/RSqNB.md)
(R-squared and adjusted R-squared),
[`SCorNB()`](https://jeksterslab.github.io/betaNB/reference/SCorNB.md)
and
[`SCorSqNB()`](https://jeksterslab.github.io/betaNB/reference/SCorSqNB.md)
(semipartial correlations),
[`PCorNB()`](https://jeksterslab.github.io/betaNB/reference/PCorNB.md)
(squared partial correlations),
[`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md)
(improvement in R-squared), and
[`FSqNB()`](https://jeksterslab.github.io/betaNB/reference/FSqNB.md)
(Cohen's f-squared and local f-squared). Percentile (`"pc"`),
bias-corrected (`"bc"`), and bias-corrected and accelerated (`"bca"`)
intervals are available.

## Methods

The [`coef()`](https://rdrr.io/r/stats/coef.html),
[`vcov()`](https://rdrr.io/r/stats/vcov.html),
[`confint()`](https://rdrr.io/r/stats/confint.html),
[`summary()`](https://rdrr.io/r/base/summary.html), and
[`print()`](https://rdrr.io/r/base/print.html) methods are available for
objects of class `betanb`.

## References

Efron, B., & Tibshirani, R. J. (1993). *An introduction to the
bootstrap*. Chapman & Hall.
[doi:10.1201/9780429246593](https://doi.org/10.1201/9780429246593)

## See also

Useful links:

- <https://github.com/jeksterslab/betaNB>

- <https://jeksterslab.github.io/betaNB/>

- Report bugs at <https://github.com/jeksterslab/betaNB/issues>

## Author

**Maintainer**: Ivan Jacob Agaloos Pesigan <r.jeksterslab@gmail.com>
([ORCID](https://orcid.org/0000-0003-4818-8420)) \[copyright holder\]

Authors:

- Ivan Jacob Agaloos Pesigan <r.jeksterslab@gmail.com>
  ([ORCID](https://orcid.org/0000-0003-4818-8420)) \[copyright holder\]
