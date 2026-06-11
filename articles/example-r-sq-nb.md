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
#> rsq 0.8045 0.0528 5000 0.6901 0.8977
#> adj 0.7906 0.0566 5000 0.6680 0.8904
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
#> rsq 0.8045 0.0528 5000 0.6429 0.8784
#> adj 0.7906 0.0566 5000 0.6174 0.8697
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
#> rsq 0.8045 0.0528 5000 0.6314 0.8770
#> adj 0.7906 0.0566 5000 0.6051 0.8682
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
#> rsq 0.002787058 0.002986133
#> adj 0.002986133 0.003199429
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>         2.5 %    97.5 %
#> rsq 0.6901025 0.8977158
#> adj 0.6679669 0.8904098
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>         2.5 %    97.5 %
#> rsq 0.6429176 0.8784039
#> adj 0.6174117 0.8697184
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>         2.5 %    97.5 %
#> rsq 0.6314489 0.8770113
#> adj 0.6051238 0.8682264
```

## References
