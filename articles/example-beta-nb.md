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
#> NARTIC  0.4951 0.0710 5000 0.3552 0.6319
#> PCTGRT  0.3915 0.0746 5000 0.2376 0.5337
#> PCTSUPP 0.2632 0.0781 5000 0.1059 0.4128
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
#> NARTIC  0.4951 0.0710 5000 0.3505 0.6278
#> PCTGRT  0.3915 0.0746 5000 0.2410 0.5361
#> PCTSUPP 0.2632 0.0781 5000 0.1075 0.4141
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
#> NARTIC  0.4951 0.0710 5000 0.3516 0.6283
#> PCTGRT  0.3915 0.0746 5000 0.2476 0.5405
#> PCTSUPP 0.2632 0.0781 5000 0.0999 0.4068
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
#> NARTIC   0.005034055 -0.002938621 -0.001866444
#> PCTGRT  -0.002938621  0.005567532 -0.001891597
#> PCTSUPP -0.001866444 -0.001891597  0.006103777
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>             2.5 %    97.5 %
#> NARTIC  0.3551675 0.6319083
#> PCTGRT  0.2376248 0.5337077
#> PCTSUPP 0.1058637 0.4128402
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>             2.5 %    97.5 %
#> NARTIC  0.3504783 0.6278036
#> PCTGRT  0.2410130 0.5360658
#> PCTSUPP 0.1074536 0.4141191
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>              2.5 %    97.5 %
#> NARTIC  0.35161952 0.6283464
#> PCTGRT  0.24755188 0.5405451
#> PCTSUPP 0.09990167 0.4067737
```

## References
