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

Generates nonparametric bootstrap confidence intervals (Efron &
Tibshirani, 1993: <https://doi.org/10.1201/9780429246593>) for
standardized regression coefficients and other effect sizes for models
fitted by `lm()`.

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
#>            est     se    R   0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4951 0.0727 5000  0.2300 0.3018 0.3474 0.6363 0.6832 0.7246
#> PCTGRT  0.3915 0.0763 5000  0.0949 0.1847 0.2335 0.5360 0.5835 0.6317
#> PCTSUPP 0.2632 0.0809 5000 -0.0006 0.0547 0.1033 0.4203 0.4765 0.5330
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
#> rsq 0.8045 0.0524 5000 0.5761 0.6456 0.6938 0.8963 0.9171 0.9354
#> adj 0.7906 0.0562 5000 0.5458 0.6203 0.6720 0.8889 0.9111 0.9307
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
#> NARTIC  0.1859 0.0591 5000 0.0339 0.0593 0.0803 0.3095 0.3634 0.4298
#> PCTGRT  0.1177 0.0484 5000 0.0059 0.0196 0.0326 0.2270 0.2672 0.3358
#> PCTSUPP 0.0569 0.0350 5000 0.0002 0.0025 0.0083 0.1423 0.1834 0.2256
```

### Semipartial Correlation Coefficients

``` r
SCorNB(nb)
#> Call:
#> SCorNB(object = nb)
#> 
#> Semipartial correlations
#> type = "pc"
#>            est     se    R   0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4312 0.0699 5000  0.1839 0.2435 0.2833 0.5563 0.6028 0.6556
#> PCTGRT  0.3430 0.0724 5000  0.0767 0.1399 0.1804 0.4765 0.5169 0.5794
#> PCTSUPP 0.2385 0.0724 5000 -0.0005 0.0499 0.0910 0.3773 0.4282 0.4749
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
#> NARTIC  0.4874 0.0986 5000 0.1360 0.2094 0.2773 0.6661 0.7058 0.7554
#> PCTGRT  0.3757 0.1072 5000 0.0292 0.1017 0.1514 0.5782 0.6419 0.6896
#> PCTSUPP 0.2254 0.1162 5000 0.0011 0.0122 0.0414 0.4817 0.5681 0.6694
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
#> NARTIC-PCTGRT  0.1037 0.1315 5000 -0.3577 -0.2473 -0.1536 0.3689 0.4643 0.6041
#> NARTIC-PCTSUPP 0.2319 0.1260 5000 -0.2117 -0.0973 -0.0180 0.4765 0.5554 0.6402
#> PCTGRT-PCTSUPP 0.1282 0.1280 5000 -0.2765 -0.1963 -0.1299 0.3760 0.4668 0.5417
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
