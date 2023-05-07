betaNB
================
Ivan Jacob Agaloos Pesigan
2023-05-07

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
BetaNB(nb)
#> Call:
#> BetaNB(object = nb)
#> 
#> Standardized regression slopes
#> type = "pc"
#>            est     se    R  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4951 0.0727 5000 0.2566 0.3035 0.3500 0.6364 0.6845 0.7502
#> PCTGRT  0.3915 0.0764 5000 0.1160 0.1831 0.2412 0.5381 0.5851 0.6393
#> PCTSUPP 0.2632 0.0786 5000 0.0151 0.0536 0.1062 0.4175 0.4655 0.5178
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
#> rsq 0.8045 0.0528 5000 0.5659 0.6342 0.6923 0.8991 0.9174 0.9344
#> adj 0.7906 0.0566 5000 0.5349 0.6081 0.6703 0.8919 0.9115 0.9298
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
#> NARTIC  0.1859 0.0590 5000 0.0412 0.0604 0.0828 0.3109 0.3605 0.4438
#> PCTGRT  0.1177 0.0492 5000 0.0071 0.0194 0.0366 0.2256 0.2713 0.3272
#> PCTSUPP 0.0569 0.0338 5000 0.0003 0.0023 0.0092 0.1384 0.1740 0.2139
```

#### Semipartial Correlation Coefficients

``` r
SCorNB(nb)
#> Call:
#> SCorNB(object = nb)
#> 
#> Semipartial correlations
#> type = "pc"
#>            est     se    R  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4312 0.0694 5000 0.2029 0.2457 0.2878 0.5576 0.6004 0.6662
#> PCTGRT  0.3430 0.0730 5000 0.0840 0.1394 0.1914 0.4750 0.5208 0.5720
#> PCTSUPP 0.2385 0.0706 5000 0.0146 0.0475 0.0961 0.3720 0.4172 0.4625
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
#> NARTIC  0.4874 0.0984 5000 0.1274 0.2090 0.2815 0.6653 0.7194 0.7638
#> PCTGRT  0.3757 0.1085 5000 0.0453 0.1005 0.1589 0.5804 0.6578 0.7396
#> PCTSUPP 0.2254 0.1131 5000 0.0015 0.0100 0.0433 0.4751 0.5497 0.6024
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
#> NARTIC-PCTGRT  0.1037 0.1315 5000 -0.3609 -0.2344 -0.1559 0.3656 0.4541 0.6263
#> NARTIC-PCTSUPP 0.2319 0.1249 5000 -0.1681 -0.0873 -0.0109 0.4799 0.5601 0.6518
#> PCTGRT-PCTSUPP 0.1282 0.1254 5000 -0.2733 -0.1883 -0.1198 0.3799 0.4710 0.5720
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
