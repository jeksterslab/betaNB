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
#> NARTIC  0.4951 0.0724 5000 0.3548 0.6401
#> PCTGRT  0.3915 0.0771 5000 0.2341 0.5376
#> PCTSUPP 0.2632 0.0788 5000 0.1080 0.4131
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
#> NARTIC  0.4951 0.0724 5000 0.3465 0.6349
#> PCTGRT  0.3915 0.0771 5000 0.2402 0.5408
#> PCTSUPP 0.2632 0.0788 5000 0.1090 0.4166
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
#> NARTIC  0.4951 0.0724 5000 0.3488 0.6359
#> PCTGRT  0.3915 0.0771 5000 0.2448 0.5468
#> PCTSUPP 0.2632 0.0788 5000 0.1010 0.4081
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
#> NARTIC   0.005247699 -0.003230223 -0.001798779
#> PCTGRT  -0.003230223  0.005940837 -0.001971358
#> PCTSUPP -0.001798779 -0.001971358  0.006216449
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>             2.5 %    97.5 %
#> NARTIC  0.3547622 0.6401478
#> PCTGRT  0.2340772 0.5375899
#> PCTSUPP 0.1079818 0.4131077
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>             2.5 %    97.5 %
#> NARTIC  0.3464577 0.6349104
#> PCTGRT  0.2402025 0.5408005
#> PCTSUPP 0.1089537 0.4166341
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>             2.5 %    97.5 %
#> NARTIC  0.3488052 0.6359287
#> PCTGRT  0.2448435 0.5467747
#> PCTSUPP 0.1010108 0.4080716
```

## References
