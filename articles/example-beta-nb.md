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
#> NARTIC  0.4951 0.0740 5000 0.3506 0.6406
#> PCTGRT  0.3915 0.0784 5000 0.2350 0.5356
#> PCTSUPP 0.2632 0.0799 5000 0.1044 0.4177
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
#> NARTIC  0.4951 0.0740 5000 0.3453 0.6363
#> PCTGRT  0.3915 0.0784 5000 0.2395 0.5396
#> PCTSUPP 0.2632 0.0799 5000 0.1106 0.4211
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
#> NARTIC  0.4951 0.0740 5000 0.3465 0.6385
#> PCTGRT  0.3915 0.0784 5000 0.2447 0.5478
#> PCTSUPP 0.2632 0.0799 5000 0.1022 0.4148
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
#> NARTIC   0.005474640 -0.003342376 -0.001991086
#> PCTGRT  -0.003342376  0.006149881 -0.002010419
#> PCTSUPP -0.001991086 -0.002010419  0.006381765
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>             2.5 %    97.5 %
#> NARTIC  0.3506272 0.6406390
#> PCTGRT  0.2350212 0.5356384
#> PCTSUPP 0.1044245 0.4177361
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>             2.5 %    97.5 %
#> NARTIC  0.3452710 0.6363428
#> PCTGRT  0.2395110 0.5396052
#> PCTSUPP 0.1106066 0.4211360
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>             2.5 %    97.5 %
#> NARTIC  0.3465147 0.6384991
#> PCTGRT  0.2447404 0.5478048
#> PCTSUPP 0.1022019 0.4147542
```

## References
