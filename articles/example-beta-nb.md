# betaNB: Example Using the BetaNB Function

In this example, a multiple regression model is fitted using program
quality ratings (`QUALITY`) as the regressand/outcome variable and
number of published articles attributed to the program faculty members
(`NARTIC`), percent of faculty members holding research grants
(`PCTGRT`), and percentage of program graduates who received support
(`PCTSUPP`) as regressor/predictor variables using a data set from 1982
ratings of 46 doctoral programs in psychology in the USA (National
Research Council, 1982). Confidence intervals for the standardized
regression coefficients are generated using the
[`BetaNB()`](https://github.com/jeksterslab/betaNB/reference/BetaNB.md)
function from the `betaNB` package.

``` r

library(betaNB)
```

``` r

df <- betaNB::nas1982
```

### Regression

Fit the regression model using the
[`lm()`](https://rdrr.io/r/stats/lm.html) function.

``` r

object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = df)
```

### Nonparametric Bootstrap

``` r

nb <- NB(object)
```

### Standardized Regression Slopes

``` r

out <- BetaNB(nb, alpha = 0.05)
```

## Methods

### summary

Summary of the results of
[`BetaNB()`](https://github.com/jeksterslab/betaNB/reference/BetaNB.md).

#### Percentile Confidence Intervals

``` r

summary(out, type = "pc")
#> Call:
#> BetaNB(object = nb, alpha = 0.05)
#> 
#> Standardized regression slopes
#> type = "pc"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.4951 0.0737 5000 0.3534 0.6434
#> PCTGRT  0.3915 0.0774 5000 0.2414 0.5423
#> PCTSUPP 0.2632 0.0790 5000 0.1059 0.4143
```

#### Bias Corrected Confidence Intervals

``` r

summary(out, type = "bc")
#> Call:
#> BetaNB(object = nb, alpha = 0.05)
#> 
#> Standardized regression slopes
#> type = "bc"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.4951 0.0737 5000 0.3454 0.6377
#> PCTGRT  0.3915 0.0774 5000 0.2455 0.5474
#> PCTSUPP 0.2632 0.0790 5000 0.1138 0.4229
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

summary(out, type = "bca")
#> Call:
#> BetaNB(object = nb, alpha = 0.05)
#> 
#> Standardized regression slopes
#> type = "bca"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.4951 0.0737 5000 0.3480 0.6388
#> PCTGRT  0.3915 0.0774 5000 0.2518 0.5545
#> PCTSUPP 0.2632 0.0790 5000 0.1074 0.4159
```

### coef

Return the vector of estimates.

``` r

coef(out)
#>    NARTIC    PCTGRT   PCTSUPP 
#> 0.4951451 0.3914887 0.2632477
```

### vcov

Return the sampling covariance matrix.

``` r

vcov(out)
#>               NARTIC       PCTGRT      PCTSUPP
#> NARTIC   0.005436243 -0.003235883 -0.001932523
#> PCTGRT  -0.003235883  0.005983784 -0.002032296
#> PCTSUPP -0.001932523 -0.002032296  0.006245490
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>             2.5 %    97.5 %
#> NARTIC  0.3534089 0.6434397
#> PCTGRT  0.2414354 0.5423138
#> PCTSUPP 0.1058660 0.4143109
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>             2.5 %    97.5 %
#> NARTIC  0.3454327 0.6376680
#> PCTGRT  0.2454574 0.5473688
#> PCTSUPP 0.1137904 0.4229347
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>             2.5 %    97.5 %
#> NARTIC  0.3479887 0.6388384
#> PCTGRT  0.2518161 0.5545108
#> PCTSUPP 0.1073628 0.4159399
```

## References
