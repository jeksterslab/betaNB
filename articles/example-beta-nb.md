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
#> NARTIC  0.4951 0.0729 5000 0.3542 0.6421
#> PCTGRT  0.3915 0.0767 5000 0.2344 0.5386
#> PCTSUPP 0.2632 0.0787 5000 0.1066 0.4157
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
#> NARTIC  0.4951 0.0729 5000 0.3521 0.6402
#> PCTGRT  0.3915 0.0767 5000 0.2397 0.5440
#> PCTSUPP 0.2632 0.0787 5000 0.1120 0.4196
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
#> NARTIC  0.4951 0.0729 5000 0.3533 0.6416
#> PCTGRT  0.3915 0.0767 5000 0.2466 0.5504
#> PCTSUPP 0.2632 0.0787 5000 0.1048 0.4122
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
#> NARTIC   0.005319007 -0.003218292 -0.001962458
#> PCTGRT  -0.003218292  0.005882184 -0.001854133
#> PCTSUPP -0.001962458 -0.001854133  0.006196612
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>             2.5 %    97.5 %
#> NARTIC  0.3542244 0.6421041
#> PCTGRT  0.2344457 0.5386364
#> PCTSUPP 0.1065720 0.4157496
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>             2.5 %    97.5 %
#> NARTIC  0.3521170 0.6402357
#> PCTGRT  0.2397416 0.5440264
#> PCTSUPP 0.1120065 0.4196282
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>             2.5 %    97.5 %
#> NARTIC  0.3532991 0.6415823
#> PCTGRT  0.2466028 0.5504454
#> PCTSUPP 0.1048323 0.4122189
```

## References
