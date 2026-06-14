# betaNB: Example Using the RSqNB Function

Confidence intervals for multiple correlation coefficients are generated
using the
[`RSqNB()`](https://github.com/jeksterslab/betaNB/reference/RSqNB.md)
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

### Multiple Correlation Coefficients

#### Normal-Theory Approach

``` r

out <- RSqNB(nb, alpha = 0.05)
```

## Methods

### summary

Summary of the results of
[`RSqNB()`](https://github.com/jeksterslab/betaNB/reference/RSqNB.md).

#### Percentile Confidence Intervals

``` r

summary(out, type = "pc")
#> Call:
#> RSqNB(object = nb, alpha = 0.05)
#> 
#> R-squared and adjusted R-squared
#> type = "pc"
#>        est     se    R   2.5%  97.5%
#> rsq 0.8045 0.0525 5000 0.6926 0.8979
#> adj 0.7906 0.0563 5000 0.6707 0.8906
```

#### Bias Corrected Confidence Intervals

``` r

summary(out, type = "bc")
#> Call:
#> RSqNB(object = nb, alpha = 0.05)
#> 
#> R-squared and adjusted R-squared
#> type = "bc"
#>        est     se    R   2.5%  97.5%
#> rsq 0.8045 0.0525 5000 0.6409 0.8793
#> adj 0.7906 0.0563 5000 0.6153 0.8707
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

summary(out, type = "bca")
#> Call:
#> RSqNB(object = nb, alpha = 0.05)
#> 
#> R-squared and adjusted R-squared
#> type = "bca"
#>        est     se    R   2.5%  97.5%
#> rsq 0.8045 0.0525 5000 0.6322 0.8776
#> adj 0.7906 0.0563 5000 0.6059 0.8689
```

### coef

Return the vector of estimates.

``` r

coef(out)
#>       rsq       adj 
#> 0.8045263 0.7905638
```

### vcov

Return the sampling covariance matrix.

``` r

vcov(out)
#>             rsq         adj
#> rsq 0.002759827 0.002956958
#> adj 0.002956958 0.003168169
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>         2.5 %    97.5 %
#> rsq 0.6926176 0.8978808
#> adj 0.6706618 0.8905866
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>         2.5 %    97.5 %
#> rsq 0.6409040 0.8792776
#> adj 0.6152543 0.8706546
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>         2.5 %   97.5 %
#> rsq 0.6321610 0.877625
#> adj 0.6058868 0.868884
```

## References
