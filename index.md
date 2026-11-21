# betaNB

Ivan Jacob Agaloos Pesigan 2026-11-21

## Description

Generates nonparametric bootstrap confidence intervals (Efron &
Tibshirani, 1993: <https://doi.org/10.1201/9780429246593>) for
standardized regression coefficients (beta) and other effect sizes,
including multiple correlation, semipartial correlations, squared
semipartial correlations, improvement in R-squared, squared partial
correlations, Cohen’s f-squared, and differences in standardized
regression coefficients, for models fitted by
[`lm()`](https://rdrr.io/r/stats/lm.html). The pairs bootstrap and the
wild bootstrap are available, with percentile, bias-corrected,
bias-corrected and accelerated, and modified percentile intervals.

## Installation

You can install the CRAN release of `betaNB` with:

\
[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(``"betaNB"``)`

You can install the development version of `betaNB` from
[GitHub](https://github.com/jeksterslab/betaNB) with:

\
`if`` ``(``!`[`require`](https://rdrr.io/r/base/library.html)`(`[`"pak"`](https://pak.r-lib.org/)`)``)`` `[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(``"pak"``)`\
`pak``::`[`pkg_install`](https://pak.r-lib.org/reference/pkg_install.html)`(``"jeksterslab/betaNB"``)`

## Example

In this example, a multiple regression model is fitted using program
quality ratings (`QUALITY`) as the regressand/outcome variable and
number of published articles attributed to the program faculty members
(`NARTIC`), percent of faculty members holding research grants
(`PCTGRT`), and percentage of program graduates who received support
(`PCTSUPP`) as regressor/predictor variables using a data set from 1982
ratings of 46 doctoral programs in psychology in the USA (National
Research Council, 1982). Confidence intervals for the standardized
regression coefficients are generated using the
[`BetaNB()`](https://jeksterslab.github.io/betaNB/reference/BetaNB.md)
function from the `betaNB` package.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`betaNB`](https://github.com/jeksterslab/betaNB)`)`

\
`df`` ``<-`` ``betaNB``::`[`nas1982`](https://jeksterslab.github.io/betaNB/reference/nas1982.md)

### Regression

Fit the regression model using the
[`lm()`](https://rdrr.io/r/stats/lm.html) function.

\
`object`` ``<-`` `[`lm`](https://rdrr.io/r/stats/lm.html)`(``QUALITY`` ``~`` ``NARTIC`` ``+`` ``PCTGRT`` ``+`` ``PCTSUPP``, data ``=`` ``df``)`

### Nonparametric Bootstrap

\
`nb`` ``<-`` `[`NB`](https://jeksterslab.github.io/betaNB/reference/NB.md)`(``object``)`

### Standardized Regression Slopes

\
[`BetaNB`](https://jeksterslab.github.io/betaNB/reference/BetaNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> BetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Standardized regression slopes`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4951 0.0718 5000 0.3554 0.6380`\
`#> PCTGRT  0.3915 0.0776 5000 0.2372 0.5400`\
`#> PCTSUPP 0.2632 0.0806 5000 0.1075 0.4188`

## Other Features

The package provides the following functions.

| Function | Purpose |
|----|----|
| [`NB()`](https://jeksterslab.github.io/betaNB/reference/NB.md) | Nonparametric bootstrap (pairs or wild) of a fitted `lm` model |
| [`BetaNB()`](https://jeksterslab.github.io/betaNB/reference/BetaNB.md) | Standardized regression coefficients |
| [`RSqNB()`](https://jeksterslab.github.io/betaNB/reference/RSqNB.md) | R-squared and adjusted R-squared |
| [`DiffBetaNB()`](https://jeksterslab.github.io/betaNB/reference/DiffBetaNB.md) | Differences of standardized regression coefficients |
| [`SCorNB()`](https://jeksterslab.github.io/betaNB/reference/SCorNB.md) | Semipartial correlations |
| [`SCorSqNB()`](https://jeksterslab.github.io/betaNB/reference/SCorSqNB.md) | Squared semipartial correlations (squared signed interval) |
| [`PCorNB()`](https://jeksterslab.github.io/betaNB/reference/PCorNB.md) | Squared partial correlations |
| [`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md) | Improvement in R-squared (adjusted differences and modified percentile intervals available) |
| [`FSqNB()`](https://jeksterslab.github.io/betaNB/reference/FSqNB.md) | Cohen’s f-squared and local f-squared |

The [`coef()`](https://rdrr.io/r/stats/coef.html),
[`vcov()`](https://rdrr.io/r/stats/vcov.html),
[`confint()`](https://rdrr.io/r/stats/confint.html),
[`summary()`](https://rdrr.io/r/base/summary.html), and
[`print()`](https://rdrr.io/r/base/print.html) methods are available for
the returned objects. Examples for each function are in the package
vignettes.

## Effect Sizes

The definitions, formulas, and notes on the intervals are in the help
pages of the functions and in the vignette [betaNB: Example Using the
SCorSqNB and FSqNB
Functions](https://jeksterslab.github.io/betaNB/articles/example-es-nb.html).

## Documentation

See [GitHub Pages](https://jeksterslab.github.io/betaNB/index.html) for
package documentation.

## References

Efron, B., & Tibshirani, R. J. (1993). *An introduction to the
bootstrap*. Chapman & Hall. <https://doi.org/10.1201/9780429246593>

National Research Council. (1982). *An assessment of research-doctorate
programs in the United States: Social and behavioral sciences*. National
Academies Press. <https://doi.org/10.17226/9781>

Pesigan, I. J. A. (2022). *Confidence intervals for standardized
coefficients: Applied to regression coefficients in primary studies and
indirect effects in meta-analytic structural equation modeling* \[PhD
thesis\]. University of Macau.

R Core Team. (2026). *R: A language and environment for statistical
computing*. R Foundation for Statistical Computing.
<https://www.R-project.org/>
