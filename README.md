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
the `betaNB` package. Confidence intervals for other effect sizes such
as multiple correlation coefficient (`RSqMC()`), improvement in
R-squared (`DeltaRSqMC()`), semipartial correlation coefficients
(`SCorMC()`), and squared partial correlation coefficients (`PCorMC()`)
are also available.

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
#> NARTIC  0.4951 0.0710 5000  0.2361 0.3148 0.3632 0.6376 0.6855 0.7295
#> PCTGRT  0.3915 0.0766 5000  0.1157 0.1817 0.2324 0.5326 0.5815 0.6197
#> PCTSUPP 0.2632 0.0803 5000 -0.0102 0.0531 0.1058 0.4185 0.4648 0.5158
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
#> rsq 0.8045 0.0522 5000 0.5654 0.6397 0.6973 0.8968 0.9164 0.9296
#> adj 0.7906 0.0560 5000 0.5343 0.6140 0.6757 0.8895 0.9105 0.9246
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
#> NARTIC  0.1859 0.0582 5000 0.0330 0.0590 0.0846 0.3105 0.3586 0.4092
#> PCTGRT  0.1177 0.0487 5000 0.0079 0.0182 0.0343 0.2244 0.2642 0.2922
#> PCTSUPP 0.0569 0.0345 5000 0.0002 0.0022 0.0089 0.1403 0.1717 0.2143
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
#> NARTIC  0.4312 0.0684 5000  0.1811 0.2429 0.2908 0.5573 0.5989 0.6397
#> PCTGRT  0.3430 0.0732 5000  0.0890 0.1347 0.1852 0.4737 0.5140 0.5406
#> PCTSUPP 0.2385 0.0722 5000 -0.0092 0.0470 0.0941 0.3745 0.4144 0.4629
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
#> NARTIC  0.4874 0.0979 5000 0.1171 0.2259 0.2901 0.6715 0.7166 0.7689
#> PCTGRT  0.3757 0.1099 5000 0.0368 0.0896 0.1566 0.5820 0.6298 0.6967
#> PCTSUPP 0.2254 0.1152 5000 0.0009 0.0095 0.0399 0.4760 0.5562 0.6203
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
#> NARTIC-PCTGRT  0.1037 0.1296 5000 -0.3522 -0.2242 -0.1354 0.3764 0.4650 0.5695
#> NARTIC-PCTSUPP 0.2319 0.1241 5000 -0.1755 -0.0870 -0.0066 0.4841 0.5707 0.6568
#> PCTGRT-PCTSUPP 0.1282 0.1283 5000 -0.2667 -0.1935 -0.1248 0.3821 0.4562 0.5186
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
