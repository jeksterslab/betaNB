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
#> NARTIC  0.4951 0.0723 5000 0.2707 0.3043 0.3525 0.6361 0.6858 0.7412
#> PCTGRT  0.3915 0.0767 5000 0.0891 0.1737 0.2385 0.5357 0.5822 0.6402
#> PCTSUPP 0.2632 0.0806 5000 0.0127 0.0495 0.1010 0.4226 0.4684 0.5186
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
#> rsq 0.8045 0.0520 5000 0.6045 0.6495 0.6939 0.8965 0.9152 0.9315
#> adj 0.7906 0.0557 5000 0.5763 0.6244 0.6720 0.8892 0.9092 0.9266
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
#> NARTIC  0.1859 0.0592 5000 0.0445 0.0596 0.0810 0.3148 0.3582 0.4194
#> PCTGRT  0.1177 0.0484 5000 0.0050 0.0193 0.0359 0.2254 0.2634 0.3283
#> PCTSUPP 0.0569 0.0348 5000 0.0001 0.0019 0.0082 0.1395 0.1821 0.2321
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
#> NARTIC  0.4312 0.0696 5000 0.2111 0.2441 0.2846 0.5610 0.5985 0.6476
#> PCTGRT  0.3430 0.0724 5000 0.0707 0.1387 0.1895 0.4748 0.5133 0.5730
#> PCTSUPP 0.2385 0.0724 5000 0.0110 0.0442 0.0903 0.3735 0.4268 0.4818
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
#> NARTIC  0.4874 0.0985 5000 0.1581 0.2202 0.2815 0.6633 0.7111 0.7528
#> PCTGRT  0.3757 0.1072 5000 0.0262 0.0979 0.1653 0.5781 0.6401 0.6900
#> PCTSUPP 0.2254 0.1154 5000 0.0007 0.0112 0.0376 0.4845 0.5562 0.6327
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
#> NARTIC-PCTGRT  0.1037 0.1312 5000 -0.3166 -0.2436 -0.1414 0.3667 0.4600 0.6350
#> NARTIC-PCTSUPP 0.2319 0.1247 5000 -0.1771 -0.0951 -0.0121 0.4784 0.5564 0.6396
#> PCTGRT-PCTSUPP 0.1282 0.1297 5000 -0.2932 -0.2130 -0.1256 0.3799 0.4788 0.5837
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
