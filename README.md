betaNB
================
Ivan Jacob Agaloos Pesigan
2026-11-21

<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->
[![CRAN Status](https://www.r-pkg.org/badges/version/betaNB)](https://cran.r-project.org/package=betaNB)
[![R-Universe Status](https://jeksterslab.r-universe.dev/badges/betaNB)](https://jeksterslab.r-universe.dev)
[![pages-build-deployment](https://github.com/jeksterslab/betaNB/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/pages/pages-build-deployment)
[![codecov](https://codecov.io/gh/jeksterslab/betaNB/branch/main/graph/badge.svg?token=KVLUET3DJ6)](https://codecov.io/gh/jeksterslab/betaNB)
[![Make Project (make all)](https://github.com/jeksterslab/betaNB/actions/workflows/make-all.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/make-all.yml)
[![Make Project](https://github.com/jeksterslab/betaNB/actions/workflows/make.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/make.yml)
[![R-CMD-check-full](https://github.com/jeksterslab/betaNB/actions/workflows/check-full.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/check-full.yml)
[![R-CMD-check-oldrel](https://github.com/jeksterslab/betaNB/actions/workflows/check-oldrel.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/check-oldrel.yml)
[![R-CMD-check-standard](https://github.com/jeksterslab/betaNB/actions/workflows/check-standard.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/check-standard.yml)
[![Compile LaTeX](https://github.com/jeksterslab/betaNB/actions/workflows/latex.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/latex.yml)
[![Lint R Package](https://github.com/jeksterslab/betaNB/actions/workflows/lint.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/lint.yml)
[![Non-ASCII Check](https://github.com/jeksterslab/betaNB/actions/workflows/non-ascii-check.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/non-ascii-check.yml)
[![Package Website (GitHub Pages)](https://github.com/jeksterslab/betaNB/actions/workflows/pkgdown-gh-pages.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/pkgdown-gh-pages.yml)
[![rhub 1 (essential)](https://github.com/jeksterslab/betaNB/actions/workflows/rhub-1-essential.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/rhub-1-essential.yml)
[![rhub 2 (memory)](https://github.com/jeksterslab/betaNB/actions/workflows/rhub-2-memory.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/rhub-2-memory.yml)
[![rhub 3 (numerics), review only](https://github.com/jeksterslab/betaNB/actions/workflows/rhub-3-numerics.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/rhub-3-numerics.yml)
[![rhub 4 (compilers), review only](https://github.com/jeksterslab/betaNB/actions/workflows/rhub-4-compilers.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/rhub-4-compilers.yml)
[![Shell Check](https://github.com/jeksterslab/betaNB/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/shellcheck.yml)
[![Source Code](https://github.com/jeksterslab/betaNB/actions/workflows/source.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/source.yml)
[![R Package Test Coverage](https://github.com/jeksterslab/betaNB/actions/workflows/test-coverage.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/test-coverage.yml)
<!-- badges: end -->

## Description

Generates nonparametric bootstrap confidence intervals (Efron &
Tibshirani, 1993: <https://doi.org/10.1201/9780429246593>) for
standardized regression coefficients (beta) and other effect sizes,
including multiple correlation, semipartial correlations, squared
semipartial correlations, improvement in R-squared, squared partial
correlations, Cohen’s f-squared, and differences in standardized
regression coefficients, for models fitted by `lm()`. The pairs
bootstrap and the wild bootstrap are available, with percentile,
bias-corrected, bias-corrected and accelerated, and modified percentile
intervals.

## Installation

You can install the CRAN release of `betaNB` with:

``` r
install.packages("betaNB")
```

You can install the development version of `betaNB` from
[GitHub](https://github.com/jeksterslab/betaNB) with:

``` r
if (!require("pak")) install.packages("pak")
pak::pkg_install("jeksterslab/betaNB")
```

## Example

In this example, a multiple regression model is fitted using program
quality ratings (`QUALITY`) as the regressand/outcome variable and
number of published articles attributed to the program faculty members
(`NARTIC`), percent of faculty members holding research grants
(`PCTGRT`), and percentage of program graduates who received support
(`PCTSUPP`) as regressor/predictor variables using a data set from 1982
ratings of 46 doctoral programs in psychology in the USA (National
Research Council, 1982). Confidence intervals for the standardized
regression coefficients are generated using the `BetaNB()` function from
the `betaNB` package.

``` r
library(betaNB)
```

``` r
df <- betaNB::nas1982
```

### Regression

Fit the regression model using the `lm()` function.

``` r
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = df)
```

### Nonparametric Bootstrap

``` r
nb <- NB(object)
```

### Standardized Regression Slopes

``` r
BetaNB(nb, alpha = 0.05)
#> Call:
#> BetaNB(object = nb, alpha = 0.05)
#> 
#> Standardized regression slopes
#> type = "pc"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.4951 0.0735 5000 0.3526 0.6414
#> PCTGRT  0.3915 0.0764 5000 0.2363 0.5393
#> PCTSUPP 0.2632 0.0794 5000 0.0978 0.4131
```

## Other Features

The package provides the following functions.

| Function | Purpose |
|----|----|
| `NB()` | Nonparametric bootstrap (pairs or wild) of a fitted `lm` model |
| `BetaNB()` | Standardized regression coefficients |
| `RSqNB()` | R-squared and adjusted R-squared |
| `DiffBetaNB()` | Differences of standardized regression coefficients |
| `SCorNB()` | Semipartial correlations |
| `SCorSqNB()` | Squared semipartial correlations (squared signed interval) |
| `PCorNB()` | Squared partial correlations |
| `DeltaRSqNB()` | Improvement in R-squared (adjusted differences and modified percentile intervals available) |
| `FSqNB()` | Cohen’s f-squared and local f-squared |

The `coef()`, `vcov()`, `confint()`, `summary()`, and `print()` methods
are available for the returned objects. Examples for each function are
in the package vignettes.

## Effect Sizes

The definitions, formulas, and notes on the intervals are in the help
pages of the functions and in the vignette [betaNB: Example Using the
SCorSqNB and FSqNB
Functions](https://jeksterslab.github.io/betaNB/articles/example-es-nb.html).

## Documentation

See [GitHub Pages](https://jeksterslab.github.io/betaNB/index.html) for
package documentation.

## References

<div id="refs" class="references csl-bib-body hanging-indent"
data-entry-spacing="0" data-line-spacing="2">

<div id="ref-Efron-Tibshirani-1993" class="csl-entry">

Efron, B., & Tibshirani, R. J. (1993). *An introduction to the
bootstrap*. Chapman & Hall. <https://doi.org/10.1201/9780429246593>

</div>

<div id="ref-NationalResearchCouncil-1982" class="csl-entry">

National Research Council. (1982). *An assessment of research-doctorate
programs in the United States: Social and behavioral sciences*. National
Academies Press. <https://doi.org/10.17226/9781>

</div>

<div id="ref-Pesigan-2022" class="csl-entry">

Pesigan, I. J. A. (2022). *Confidence intervals for standardized
coefficients: Applied to regression coefficients in primary studies and
indirect effects in meta-analytic structural equation modeling* \[PhD
thesis\]. University of Macau.

</div>

<div id="ref-RCoreTeam-2026" class="csl-entry">

R Core Team. (2026). *R: A language and environment for statistical
computing*. R Foundation for Statistical Computing.
<https://www.R-project.org/>

</div>

</div>
