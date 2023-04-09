betaNB
================
Ivan Jacob Agaloos Pesigan
2023-04-09

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
#>            est     se    R  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> NARTIC  0.4951 0.0730 5000 0.2459 0.3031 0.3500 0.6380 0.6896 0.7246
#> PCTGRT  0.3915 0.0767 5000 0.1238 0.1886 0.2382 0.5416 0.5924 0.6638
#> PCTSUPP 0.2632 0.0807 5000 0.0010 0.0489 0.0992 0.4121 0.4562 0.4999
```

### Other Effect Sizes

The `betaNB` package also has functions to generate Monte Carlo
confidence intervals for other effect sizes such as `RSqNB()` for
multiple correlation coefficients (R-squared and adjusted R-squared),
`DeltaRSqNB()` for improvement in R-squared, `SCorNB()` for semipartial
correlation coefficients, `PCorNB()` for squared partial correlation
coefficients, and `DiffBetaNB()` for differences of standardized
regression coefficients.

#### Multiple Correlation Coefficients (R-squared and adjusted R-squared)

``` r
RSqNB(nb)
#> Call:
#> RSqNB(object = nb)
#> 
#> R-squared and adjusted R-squared
#> type = "pc"
#>        est     se    R  0.05%   0.5%   2.5%  97.5%  99.5% 99.95%
#> rsq 0.8045 0.0543 5000 0.5575 0.6444 0.6890 0.8983 0.9157 0.9264
#> adj 0.7906 0.0582 5000 0.5259 0.6190 0.6668 0.8911 0.9096 0.9211
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
#> NARTIC  0.1859 0.0600 5000 0.0359 0.0587 0.0817 0.3136 0.3639 0.4121
#> PCTGRT  0.1177 0.0491 5000 0.0094 0.0219 0.0339 0.2272 0.2790 0.3201
#> PCTSUPP 0.0569 0.0338 5000 0.0001 0.0018 0.0079 0.1372 0.1647 0.2122
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
#> NARTIC  0.4312 0.0705 5000 0.1895 0.2423 0.2859 0.5600 0.6033 0.6419
#> PCTGRT  0.3430 0.0728 5000 0.0969 0.1479 0.1843 0.4767 0.5282 0.5658
#> PCTSUPP 0.2385 0.0723 5000 0.0008 0.0423 0.0891 0.3704 0.4059 0.4604
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
#> NARTIC  0.4874 0.0995 5000 0.1447 0.2168 0.2778 0.6680 0.7157 0.7568
#> PCTGRT  0.3757 0.1080 5000 0.0557 0.1011 0.1567 0.5892 0.6480 0.7101
#> PCTSUPP 0.2254 0.1169 5000 0.0006 0.0090 0.0363 0.4769 0.5526 0.6165
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
#> NARTIC-PCTGRT  0.1037 0.1325 5000 -0.3683 -0.2463 -0.1528 0.3685 0.4580 0.5576
#> NARTIC-PCTSUPP 0.2319 0.1252 5000 -0.1859 -0.0732 -0.0041 0.4847 0.5766 0.6700
#> PCTGRT-PCTSUPP 0.1282 0.1289 5000 -0.2269 -0.1887 -0.1126 0.3922 0.4846 0.5755
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
