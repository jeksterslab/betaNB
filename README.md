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
#> NARTIC  0.4951 0.0726 5000  0.2407 0.3004 0.3551 0.6379 0.7000 0.7547
#> PCTGRT  0.3915 0.0775 5000  0.1391 0.1825 0.2300 0.5436 0.5855 0.6294
#> PCTSUPP 0.2632 0.0788 5000 -0.0017 0.0556 0.1083 0.4145 0.4515 0.4983
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
#> rsq 0.8045 0.0525 5000 0.5468 0.6470 0.6949 0.9003 0.9183 0.9361
#> adj 0.7906 0.0562 5000 0.5144 0.6218 0.6731 0.8931 0.9125 0.9315
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
#> NARTIC  0.1859 0.0594 5000 0.0333 0.0578 0.0826 0.3088 0.3631 0.4356
#> PCTGRT  0.1177 0.0489 5000 0.0111 0.0189 0.0342 0.2245 0.2668 0.3184
#> PCTSUPP 0.0569 0.0338 5000 0.0001 0.0024 0.0092 0.1378 0.1686 0.1977
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
#> NARTIC  0.4312 0.0698 5000  0.1825 0.2404 0.2874 0.5557 0.6026 0.6600
#> PCTGRT  0.3430 0.0732 5000  0.1054 0.1376 0.1848 0.4738 0.5165 0.5643
#> PCTSUPP 0.2385 0.0710 5000 -0.0015 0.0488 0.0961 0.3713 0.4106 0.4447
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
#> NARTIC  0.4874 0.0982 5000 0.1168 0.2188 0.2865 0.6689 0.7162 0.7700
#> PCTGRT  0.3757 0.1096 5000 0.0558 0.0970 0.1561 0.5791 0.6382 0.7084
#> PCTSUPP 0.2254 0.1153 5000 0.0003 0.0117 0.0446 0.4856 0.5680 0.6374
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
#> NARTIC-PCTGRT  0.1037 0.1336 5000 -0.3545 -0.2587 -0.1524 0.3701 0.4827 0.5599
#> NARTIC-PCTSUPP 0.2319 0.1231 5000 -0.1455 -0.0618 -0.0022 0.4767 0.5712 0.6831
#> PCTGRT-PCTSUPP 0.1282 0.1267 5000 -0.2884 -0.1945 -0.1132 0.3838 0.4552 0.5493
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
