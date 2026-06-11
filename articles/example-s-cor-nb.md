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
#> NARTIC  0.4312 0.0702 5000 0.2880 0.5622
#> PCTGRT  0.3430 0.0713 5000 0.1898 0.4673
#> PCTSUPP 0.2385 0.0709 5000 0.0914 0.3718
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
#> NARTIC  0.4312 0.0702 5000 0.3004 0.5764
#> PCTGRT  0.3430 0.0713 5000 0.2119 0.4918
#> PCTSUPP 0.2385 0.0709 5000 0.1048 0.3865
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
#> NARTIC  0.4312 0.0702 5000 0.3076 0.5867
#> PCTGRT  0.3430 0.0713 5000 0.2214 0.5077
#> PCTSUPP 0.2385 0.0709 5000 0.1006 0.3810
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
#> NARTIC   0.0049263820 -0.0005111027 -0.0005567460
#> PCTGRT  -0.0005111027  0.0050881594 -0.0007857397
#> PCTSUPP -0.0005567460 -0.0007857397  0.0050314024
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>             2.5 %    97.5 %
#> NARTIC  0.2880387 0.5622362
#> PCTGRT  0.1898445 0.4672876
#> PCTSUPP 0.0913534 0.3718410
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>             2.5 %    97.5 %
#> NARTIC  0.3004391 0.5763893
#> PCTGRT  0.2118725 0.4918014
#> PCTSUPP 0.1048029 0.3864649
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>             2.5 %    97.5 %
#> NARTIC  0.3076398 0.5867168
#> PCTGRT  0.2214446 0.5077182
#> PCTSUPP 0.1005906 0.3810392
```

## References
