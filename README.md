betaNB
================
Ivan Jacob Agaloos Pesigan
2025-01-11

<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![CRAN
Status](https://www.r-pkg.org/badges/version/betaNB)](https://cran.r-project.org/package=betaNB)
[![R-Universe
Status](https://jeksterslab.r-universe.dev/badges/betaNB)](https://jeksterslab.r-universe.dev/betaNB)
[![Make
Project](https://github.com/jeksterslab/betaNB/actions/workflows/make.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/make.yml)
[![R-CMD-check](https://github.com/jeksterslab/betaNB/actions/workflows/check-full.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/check-full.yml)
[![R Package Test
Coverage](https://github.com/jeksterslab/betaNB/actions/workflows/test-coverage.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/test-coverage.yml)
[![Lint R
Package](https://github.com/jeksterslab/betaNB/actions/workflows/lint.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/lint.yml)
[![Package Website (GitHub
Pages)](https://github.com/jeksterslab/betaNB/actions/workflows/pkgdown-gh-pages.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/pkgdown-gh-pages.yml)
[![Compile
LaTeX](https://github.com/jeksterslab/betaNB/actions/workflows/latex.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/latex.yml)
[![Shell
Check](https://github.com/jeksterslab/betaNB/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/shellcheck.yml)
[![pages-build-deployment](https://github.com/jeksterslab/betaNB/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/pages/pages-build-deployment)
[![codecov](https://codecov.io/gh/jeksterslab/betaNB/branch/main/graph/badge.svg?token=KVLUET3DJ6)](https://codecov.io/gh/jeksterslab/betaNB)
<!-- badges: end -->

## Description

Generates nonparametric bootstrap confidence intervals (Efron &
Tibshirani, 1993: <https://doi.org/10.1201/9780429246593>) for
standardized regression coefficients (beta) and other effect sizes,
including multiple correlation, semipartial correlations, improvement in
R-squared, squared partial correlations, and differences in standardized
regression coefficients, for models fitted by `lm()`.

## Installation

You can install the CRAN release of `betaNB` with:

``` r
install.packages("betaNB")
```

You can install the development version of `betaNB` from
[GitHub](https://github.com/jeksterslab/betaNB) with:

``` r
if (!require("remotes")) install.packages("remotes")
remotes::install_github("jeksterslab/betaNB")
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
#> NARTIC  0.4951 0.0709 5000 0.3565 0.6325
#> PCTGRT  0.3915 0.0766 5000 0.2324 0.5355
#> PCTSUPP 0.2632 0.0792 5000 0.1036 0.4144
```

### Other Effect Sizes

The `betaNB` package also has functions to generate nonparametric
bootstrap confidence intervals for other effect sizes such as `RSqNB()`
for multiple correlation coefficients (R-squared and adjusted
R-squared), `DeltaRSqNB()` for improvement in R-squared, `SCorNB()` for
semipartial correlation coefficients, `PCorNB()` for squared partial
correlation coefficients, and `DiffBetaNB()` for differences of
standardized regression coefficients.

#### Multiple Correlation Coefficients (R-squared and adjusted R-squared)

``` r
RSqNB(nb, alpha = 0.05)
#> Call:
#> RSqNB(object = nb, alpha = 0.05)
#> 
#> R-squared and adjusted R-squared
#> type = "pc"
#>        est     se    R   2.5%  97.5%
#> rsq 0.8045 0.0517 5000 0.6970 0.8973
#> adj 0.7906 0.0554 5000 0.6754 0.8899
```

#### Improvement in R-squared

``` r
DeltaRSqNB(nb, alpha = 0.05)
#> Call:
#> DeltaRSqNB(object = nb, alpha = 0.05)
#> 
#> Improvement in R-squared
#> type = "pc"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.1859 0.0575 5000 0.0836 0.3002
#> PCTGRT  0.1177 0.0479 5000 0.0348 0.2181
#> PCTSUPP 0.0569 0.0337 5000 0.0083 0.1377
```

#### Semipartial Correlation Coefficients

``` r
SCorNB(nb, alpha = 0.05)
#> Call:
#> SCorNB(object = nb, alpha = 0.05)
#> 
#> Semipartial correlations
#> type = "pc"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.4312 0.0679 5000 0.2891 0.5479
#> PCTGRT  0.3430 0.0722 5000 0.1866 0.4670
#> PCTSUPP 0.2385 0.0709 5000 0.0911 0.3711
```

#### Squared Partial Correlation Coefficients

``` r
PCorNB(nb, alpha = 0.05)
#> Call:
#> PCorNB(object = nb, alpha = 0.05)
#> 
#> Squared partial correlations
#> type = "pc"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.4874 0.0966 5000 0.2869 0.6648
#> PCTGRT  0.3757 0.1069 5000 0.1621 0.5749
#> PCTSUPP 0.2254 0.1142 5000 0.0413 0.4771
```

#### Differences of Standardized Regression Coefficients

``` r
DiffBetaNB(nb, alpha = 0.05)
#> Call:
#> DiffBetaNB(object = nb, alpha = 0.05)
#> 
#> Differences of standardized regression slopes
#> type = "pc"
#>                   est     se    R    2.5%  97.5%
#> NARTIC-PCTGRT  0.1037 0.1301 5000 -0.1433 0.3700
#> NARTIC-PCTSUPP 0.2319 0.1223 5000 -0.0047 0.4697
#> PCTGRT-PCTSUPP 0.1282 0.1280 5000 -0.1196 0.3789
```

## Documentation

See [GitHub Pages](https://jeksterslab.github.io/betaNB/index.html) for
package documentation.

## References

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0" line-spacing="2">

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

</div>
