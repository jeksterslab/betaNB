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
#> rsq 0.8045 0.0530 5000 0.6893 0.8985
#> adj 0.7906 0.0568 5000 0.6671 0.8912
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
#> rsq 0.8045 0.0530 5000 0.6475 0.8822
#> adj 0.7906 0.0568 5000 0.6224 0.8738
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
#> rsq 0.8045 0.0530 5000 0.6376 0.8800
#> adj 0.7906 0.0568 5000 0.6118 0.8715
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
#> rsq 0.002811712 0.003012548
#> adj 0.003012548 0.003227730
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>         2.5 %    97.5 %
#> rsq 0.6893045 0.8984977
#> adj 0.6671120 0.8912475
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>         2.5 %    97.5 %
#> rsq 0.6475476 0.8821685
#> adj 0.6223724 0.8737520
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>         2.5 %    97.5 %
#> rsq 0.6376494 0.8800398
#> adj 0.6117672 0.8714712
```

## References
