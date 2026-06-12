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
#> NARTIC  0.4312 0.0704 5000 0.2857 0.5618
#> PCTGRT  0.3430 0.0743 5000 0.1861 0.4804
#> PCTSUPP 0.2385 0.0721 5000 0.0912 0.3711
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
#> NARTIC  0.4312 0.0704 5000 0.3024 0.5817
#> PCTGRT  0.3430 0.0743 5000 0.2063 0.4985
#> PCTSUPP 0.2385 0.0721 5000 0.1043 0.3833
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
#> NARTIC  0.4312 0.0704 5000 0.3107 0.5897
#> PCTGRT  0.3430 0.0743 5000 0.2156 0.5127
#> PCTSUPP 0.2385 0.0721 5000 0.1003 0.3800
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
#> NARTIC   0.0049539882 -0.0005001344 -0.0005786923
#> PCTGRT  -0.0005001344  0.0055135841 -0.0007791980
#> PCTSUPP -0.0005786923 -0.0007791980  0.0052029580
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>              2.5 %    97.5 %
#> NARTIC  0.28573894 0.5617540
#> PCTGRT  0.18608325 0.4803982
#> PCTSUPP 0.09116447 0.3711175
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>             2.5 %    97.5 %
#> NARTIC  0.3024466 0.5816586
#> PCTGRT  0.2063286 0.4984734
#> PCTSUPP 0.1042671 0.3833420
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>             2.5 %    97.5 %
#> NARTIC  0.3106680 0.5896690
#> PCTGRT  0.2155639 0.5127451
#> PCTSUPP 0.1003164 0.3800107
```

## References
