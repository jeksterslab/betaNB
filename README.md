betaNB
================
Ivan Jacob Agaloos Pesigan
2024-12-29

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
#> NARTIC  0.4951 0.0709 5000 0.3586 0.6371
#> PCTGRT  0.3915 0.0755 5000 0.2404 0.5321
#> PCTSUPP 0.2632 0.0797 5000 0.1037 0.4145
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
#> rsq 0.8045 0.0529 5000 0.6928 0.8976
#> adj 0.7906 0.0567 5000 0.6709 0.8903
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
#> NARTIC  0.1859 0.0588 5000 0.0831 0.3115
#> PCTGRT  0.1177 0.0486 5000 0.0352 0.2270
#> PCTSUPP 0.0569 0.0338 5000 0.0084 0.1362
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
#> NARTIC  0.4312 0.0688 5000 0.2882 0.5581
#> PCTGRT  0.3430 0.0725 5000 0.1875 0.4764
#> PCTSUPP 0.2385 0.0716 5000 0.0914 0.3690
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
#> NARTIC  0.4874 0.0972 5000 0.2873 0.6693
#> PCTGRT  0.3757 0.1084 5000 0.1573 0.5860
#> PCTSUPP 0.2254 0.1157 5000 0.0402 0.4778
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
#> NARTIC-PCTGRT  0.1037 0.1286 5000 -0.1380 0.3647
#> NARTIC-PCTSUPP 0.2319 0.1236 5000 -0.0044 0.4790
#> PCTGRT-PCTSUPP 0.1282 0.1266 5000 -0.1173 0.3781
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
