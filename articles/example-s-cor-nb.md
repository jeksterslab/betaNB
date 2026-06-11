# betaNB: Example Using the SCorNB Function

Confidence intervals for semipartial correlation coefficients are
generated using the
[`SCorNB()`](https://github.com/jeksterslab/betaNB/reference/SCorNB.md)
function from the `betaNB` package. In this example, we use the data set
and the model used in [betaNB: Example Using the BetaNB
Function](https://github.com/jeksterslab/betaNB/articles/example-beta-nb.md).

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

### Semipartial Correlation Coefficients

#### Normal-Theory Approach

``` r

out <- SCorNB(nb, alpha = 0.05)
```

## Methods

### summary

Summary of the results of
[`SCorNB()`](https://github.com/jeksterslab/betaNB/reference/SCorNB.md).

#### Percentile Confidence Intervals

``` r

summary(out, type = "pc")
#> Call:
#> SCorNB(object = nb, alpha = 0.05)
#> 
#> Semipartial correlations
#> type = "pc"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.4312 0.0706 5000 0.2844 0.5589
#> PCTGRT  0.3430 0.0731 5000 0.1903 0.4728
#> PCTSUPP 0.2385 0.0705 5000 0.0907 0.3690
```

#### Bias Corrected Confidence Intervals

``` r

summary(out, type = "bc")
#> Call:
#> SCorNB(object = nb, alpha = 0.05)
#> 
#> Semipartial correlations
#> type = "bc"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.4312 0.0706 5000 0.3034 0.5790
#> PCTGRT  0.3430 0.0731 5000 0.2029 0.4898
#> PCTSUPP 0.2385 0.0705 5000 0.0994 0.3792
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

summary(out, type = "bca")
#> Call:
#> SCorNB(object = nb, alpha = 0.05)
#> 
#> Semipartial correlations
#> type = "bca"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.4312 0.0706 5000 0.3090 0.5898
#> PCTGRT  0.3430 0.0731 5000 0.2118 0.5050
#> PCTSUPP 0.2385 0.0705 5000 0.0957 0.3740
```

### coef

Return the vector of estimates.

``` r

coef(out)
#>    NARTIC    PCTGRT   PCTSUPP 
#> 0.4311525 0.3430075 0.2384789
```

### vcov

Return the sampling covariance matrix.

``` r

vcov(out)
#>                NARTIC        PCTGRT       PCTSUPP
#> NARTIC   0.0049821924 -0.0005212210 -0.0005744219
#> PCTGRT  -0.0005212210  0.0053392055 -0.0007315646
#> PCTSUPP -0.0005744219 -0.0007315646  0.0049646764
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>              2.5 %    97.5 %
#> NARTIC  0.28443754 0.5588720
#> PCTGRT  0.19033034 0.4728347
#> PCTSUPP 0.09069146 0.3690173
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>              2.5 %    97.5 %
#> NARTIC  0.30343766 0.5789979
#> PCTGRT  0.20291063 0.4897731
#> PCTSUPP 0.09942151 0.3792279
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>              2.5 %    97.5 %
#> NARTIC  0.30899427 0.5898160
#> PCTGRT  0.21182995 0.5050102
#> PCTSUPP 0.09568579 0.3740461
```

## References
