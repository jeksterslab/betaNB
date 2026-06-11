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
#> rsq 0.8045 0.0538 5000 0.6904 0.8985
#> adj 0.7906 0.0576 5000 0.6683 0.8912
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
#> rsq 0.8045 0.0538 5000 0.6443 0.8822
#> adj 0.7906 0.0576 5000 0.6189 0.8738
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
#> rsq 0.8045 0.0538 5000 0.6384 0.8803
#> adj 0.7906 0.0576 5000 0.6126 0.8718
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
#> rsq 0.002889327 0.003095708
#> adj 0.003095708 0.003316830
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>         2.5 %    97.5 %
#> rsq 0.6903789 0.8984889
#> adj 0.6682632 0.8912381
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>         2.5 %    97.5 %
#> rsq 0.6442761 0.8821766
#> adj 0.6188672 0.8737607
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>         2.5 %    97.5 %
#> rsq 0.6383921 0.8803411
#> adj 0.6125630 0.8717941
```

## References
