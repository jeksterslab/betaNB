betaNB
================
Ivan Jacob Agaloos Pesigan
2023-04-13

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
#> NARTIC  0.4951 0.0726 5000 0.2775 0.3129 0.3495 0.6354 0.6855 0.7287
#> PCTGRT  0.3915 0.0764 5000 0.1079 0.1819 0.2386 0.5395 0.5855 0.6317
#> PCTSUPP 0.2632 0.0808 5000 0.0117 0.0496 0.1056 0.4207 0.4646 0.5152
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
#> rsq 0.8045 0.0522 5000 0.6014 0.6511 0.6950 0.9000 0.9171 0.9369
#> adj 0.7906 0.0559 5000 0.5729 0.6262 0.6733 0.8929 0.9111 0.9324
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
#> NARTIC  0.1859 0.0594 5000 0.0435 0.0642 0.0838 0.3111 0.3577 0.4222
#> PCTGRT  0.1177 0.0485 5000 0.0069 0.0200 0.0371 0.2213 0.2744 0.3253
#> PCTSUPP 0.0569 0.0344 5000 0.0001 0.0020 0.0087 0.1403 0.1680 0.2097
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
#> NARTIC  0.4312 0.0698 5000 0.2086 0.2535 0.2895 0.5578 0.5981 0.6497
#> PCTGRT  0.3430 0.0722 5000 0.0827 0.1416 0.1927 0.4704 0.5238 0.5704
#> PCTSUPP 0.2385 0.0721 5000 0.0101 0.0445 0.0931 0.3745 0.4098 0.4579
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
#> NARTIC  0.4874 0.0991 5000 0.1657 0.2253 0.2815 0.6714 0.7256 0.7683
#> PCTGRT  0.3757 0.1083 5000 0.0350 0.0953 0.1639 0.5891 0.6489 0.6900
#> PCTSUPP 0.2254 0.1165 5000 0.0010 0.0088 0.0425 0.4871 0.5562 0.6185
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
#> NARTIC-PCTGRT  0.1037 0.1309 5000 -0.3230 -0.2351 -0.1514 0.3574 0.4668 0.5843
#> NARTIC-PCTSUPP 0.2319 0.1265 5000 -0.1799 -0.1079 -0.0168 0.4766 0.5609 0.6591
#> PCTGRT-PCTSUPP 0.1282 0.1284 5000 -0.2511 -0.1963 -0.1194 0.3776 0.4602 0.5601
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
