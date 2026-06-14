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
#> NARTIC  0.4312 0.0700 5000 0.2855 0.5581
#> PCTGRT  0.3430 0.0726 5000 0.1902 0.4738
#> PCTSUPP 0.2385 0.0699 5000 0.0996 0.3699
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
#> NARTIC  0.4312 0.0700 5000 0.3033 0.5823
#> PCTGRT  0.3430 0.0726 5000 0.2090 0.4907
#> PCTSUPP 0.2385 0.0699 5000 0.1128 0.3844
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
#> NARTIC  0.4312 0.0700 5000 0.3107 0.5895
#> PCTGRT  0.3430 0.0726 5000 0.2188 0.5041
#> PCTSUPP 0.2385 0.0699 5000 0.1104 0.3805
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
#> NARTIC   0.0048963501 -0.0003186424 -0.0005297367
#> PCTGRT  -0.0003186424  0.0052682043 -0.0008160308
#> PCTSUPP -0.0005297367 -0.0008160308  0.0048900647
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>              2.5 %    97.5 %
#> NARTIC  0.28547589 0.5581485
#> PCTGRT  0.19021788 0.4738493
#> PCTSUPP 0.09957335 0.3699068
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>             2.5 %    97.5 %
#> NARTIC  0.3033008 0.5823176
#> PCTGRT  0.2090310 0.4906855
#> PCTSUPP 0.1128254 0.3843738
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>             2.5 %    97.5 %
#> NARTIC  0.3106631 0.5894830
#> PCTGRT  0.2187731 0.5041047
#> PCTSUPP 0.1103597 0.3804591
```

## References
