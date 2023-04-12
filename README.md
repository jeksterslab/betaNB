betaNB
================
Ivan Jacob Agaloos Pesigan
2023-04-12

<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![CRAN
Status](https://www.r-pkg.org/badges/version/betaNB)](https://cran.r-project.org/package=betaNB)
[![R-Universe
Status](https://jeksterslab.r-universe.dev/badges/betaNB)](https://jeksterslab.r-universe.dev)
[![R-CMD-check](https://github.com/jeksterslab/betaNB/workflows/R-CMD-check/badge.svg)](https://github.com/jeksterslab/betaNB/actions)
[![test-coverage](https://github.com/jeksterslab/betaNB/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/test-coverage.yaml)
[![lint](https://github.com/jeksterslab/betaNB/actions/workflows/lint.yaml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/lint.yaml)
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

## Example

In this example, a multiple regression model is fitted
using program quality ratings (`QUALITY`) as the regressand/outcome variable
and number of published articles attributed to the program faculty members (`NARTIC`),
percent of faculty members holding research grants (`PCTGRT`), and
percentage of program graduates who received support (`PCTSUPP`) as regressor/predictor variables
using a data set from 1982 ratings of 46 doctoral programs in psychology in the USA (National Research Council, 1982).
Confidence intervals for the standardized regression coefficients are generated
using the `BetaNB()` function from the `betaNB` package.


```r
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
BetaNB(nb)
#> Call:
#> BetaNB(object = nb)
#> 
#> Standardized regression slopes
#> type = "pc"
#>            est     se    R   0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4951 0.0718 5000  0.2667 0.3094 0.3548 0.6372 0.6821 0.7227
#> PCTGRT  0.3915 0.0759 5000  0.1240 0.1732 0.2375 0.5397 0.5831 0.6383
#> PCTSUPP 0.2632 0.0796 5000 -0.0010 0.0567 0.1062 0.4188 0.4698 0.5164
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
RSqNB(nb)
#> Call:
#> RSqNB(object = nb)
#> 
#> R-squared and adjusted R-squared
#> type = "pc"
#>        est     se    R  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> rsq 0.8045 0.0523 5000 0.5725 0.6358 0.6924 0.8951 0.9130 0.9392
#> adj 0.7906 0.0561 5000 0.5419 0.6097 0.6704 0.8876 0.9068 0.9348
```

#### Improvement in R-squared

``` r
DeltaRSqNB(nb)
#> Call:
#> DeltaRSqNB(object = nb)
#> 
#> Improvement in R-squared
#> type = "pc"
#>            est     se    R  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.1859 0.0587 5000 0.0425 0.0599 0.0826 0.3117 0.3578 0.4071
#> PCTGRT  0.1177 0.0484 5000 0.0074 0.0183 0.0362 0.2276 0.2731 0.3289
#> PCTSUPP 0.0569 0.0341 5000 0.0000 0.0025 0.0089 0.1400 0.1764 0.2216
```

#### Semipartial Correlation Coefficients

``` r
SCorNB(nb)
#> Call:
#> SCorNB(object = nb)
#> 
#> Semipartial correlations
#> type = "pc"
#>            est     se    R   0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4312 0.0690 5000  0.2062 0.2448 0.2875 0.5583 0.5982 0.6381
#> PCTGRT  0.3430 0.0720 5000  0.0860 0.1352 0.1902 0.4771 0.5226 0.5734
#> PCTSUPP 0.2385 0.0713 5000 -0.0006 0.0505 0.0942 0.3741 0.4200 0.4707
```

#### Squared Partial Correlation Coefficients

``` r
PCorNB(nb)
#> Call:
#> PCorNB(object = nb)
#> 
#> Squared partial correlations
#> type = "pc"
#>            est     se    R  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4874 0.0980 5000 0.1673 0.2196 0.2812 0.6686 0.7146 0.7788
#> PCTGRT  0.3757 0.1067 5000 0.0340 0.0831 0.1608 0.5830 0.6417 0.7149
#> PCTSUPP 0.2254 0.1141 5000 0.0002 0.0118 0.0421 0.4805 0.5612 0.6269
```

#### Differences of Standardized Regression Coefficients

``` r
DiffBetaNB(nb)
#> Call:
#> DiffBetaNB(object = nb)
#> 
#> Differences of standardized regression slopes
#> type = "pc"
#>                   est     se    R   0.05%    0.5%    2.5%  97.5%  99.5% 99.95%
#> NARTIC-PCTGRT  0.1037 0.1300 5000 -0.3263 -0.2466 -0.1484 0.3638 0.4664 0.5470
#> NARTIC-PCTSUPP 0.2319 0.1243 5000 -0.1713 -0.0929 -0.0038 0.4783 0.5606 0.6662
#> PCTGRT-PCTSUPP 0.1282 0.1269 5000 -0.3006 -0.1976 -0.1200 0.3730 0.4602 0.5648
```

### References

Efron, B., & Tibshirani, R. J. (1993). *An introduction to the
bootstrap*. Chapman & Hall. <https://doi.org/10.1201/9780429246593>

National Research Council. (1982). *An assessment of research-doctorate
programs in the United States: Social and behavioral sciences*.
<https://doi.org/10.17226/9781>. Reproduced with permission from the
National Academy of Sciences, Courtesy of the National Academies Press,
Washington, D.C.

Pesigan, I. J. A. (2022). Confidence intervals for standardized
coefficients: Applied to regression coefficients in primary studies and
indirect effects in meta-analytic structural equation modeling
\[Unpublished doctoral dissertation\]. University of Macau.

## Documentation

See [GitHub Pages](https://jeksterslab.github.io/betaNB/index.html) for
package documentation.
