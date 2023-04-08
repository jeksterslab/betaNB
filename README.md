betaNB
================
Ivan Jacob Agaloos Pesigan
2023-04-08

<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![R-CMD-check](https://github.com/jeksterslab/betaNB/workflows/R-CMD-check/badge.svg)](https://github.com/jeksterslab/betaNB/actions)
[![test-coverage](https://github.com/jeksterslab/betaNB/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/test-coverage.yaml)
[![lint](https://github.com/jeksterslab/betaNB/actions/workflows/lint.yaml/badge.svg)](https://github.com/jeksterslab/betaNB/actions/workflows/lint.yaml)
[![codecov](https://codecov.io/gh/jeksterslab/betaNB/branch/main/graph/badge.svg?token=KVLUET3DJ6)](https://codecov.io/gh/jeksterslab/betaNB)
<!-- badges: end -->

## Description

Generates nonparametric bootstrap confidence intervals for standardized
regression coefficients and other effect sizes for models fitted by
`lm()`.

## Installation

<!--
You can install the CRAN release of `betaNB` with:

```r
install.packages("betaNB")
```
-->

You can install the development version of `betaNB` from
[GitHub](https://github.com/jeksterslab/betaNB) with:

``` r
install.packages("remotes")
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
#> NARTIC  0.4951 0.0723 5000 0.2445 0.3143 0.3569 0.6361 0.6845 0.7356
#> PCTGRT  0.3915 0.0770 5000 0.1211 0.1831 0.2375 0.5412 0.5814 0.6228
#> PCTSUPP 0.2632 0.0780 5000 0.0124 0.0624 0.1120 0.4147 0.4643 0.5173
```

### Multiple Correlation Coefficients (R-squared and adjusted R-squared)

``` r
RSqNB(nb)
#> Call:
#> RSqNB(object = nb)
#> 
#> R-squared and adjusted R-squared
#> type = "pc"
#>        est     se    R  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> rsq 0.8045 0.0517 5000 0.5981 0.6472 0.6940 0.8975 0.9154 0.9353
#> adj 0.7906 0.0554 5000 0.5694 0.6220 0.6721 0.8902 0.9094 0.9307
```

### Improvement in R-squared

``` r
DeltaRSqNB(nb)
#> Call:
#> DeltaRSqNB(object = nb)
#> 
#> Improvement in R-squared
#> type = "pc"
#>            est     se    R  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.1859 0.0589 5000 0.0383 0.0601 0.0833 0.3132 0.3600 0.4073
#> PCTGRT  0.1177 0.0493 5000 0.0081 0.0179 0.0346 0.2295 0.2749 0.3191
#> PCTSUPP 0.0569 0.0337 5000 0.0001 0.0030 0.0099 0.1378 0.1762 0.2139
```

### Semipartial Correlation Coefficients

``` r
SCorNB(nb)
#> Call:
#> SCorNB(object = nb)
#> 
#> Semipartial correlations
#> type = "pc"
#>            est     se    R  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4312 0.0693 5000 0.1957 0.2452 0.2886 0.5596 0.6000 0.6382
#> PCTGRT  0.3430 0.0730 5000 0.0897 0.1336 0.1861 0.4791 0.5243 0.5649
#> PCTSUPP 0.2385 0.0703 5000 0.0110 0.0544 0.0996 0.3712 0.4198 0.4625
```

### Squared Partial Correlation Coefficients

``` r
PCorNB(nb)
#> Call:
#> PCorNB(object = nb)
#> 
#> Squared partial correlations
#> type = "pc"
#>            est     se    R  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4874 0.0984 5000 0.1491 0.2212 0.2884 0.6693 0.7142 0.7630
#> PCTGRT  0.3757 0.1077 5000 0.0326 0.0977 0.1628 0.5864 0.6333 0.6864
#> PCTSUPP 0.2254 0.1135 5000 0.0006 0.0162 0.0471 0.4739 0.5404 0.6054
```

### Differences of Standardized Regression Coefficients

``` r
DiffBetaNB(nb)
#> Call:
#> DiffBetaNB(object = nb)
#> 
#> Differences of standardized regression slopes
#> type = "pc"
#>                   est     se    R   0.05%    0.5%    2.5%  97.5%  99.5% 99.95%
#> NARTIC-PCTGRT  0.1037 0.1327 5000 -0.3576 -0.2250 -0.1540 0.3735 0.4650 0.6092
#> NARTIC-PCTSUPP 0.2319 0.1217 5000 -0.1840 -0.0862 -0.0020 0.4738 0.5440 0.6110
#> PCTGRT-PCTSUPP 0.1282 0.1261 5000 -0.2858 -0.1965 -0.1105 0.3830 0.4614 0.5371
```

### References

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
