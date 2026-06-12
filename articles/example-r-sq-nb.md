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
#> rsq 0.8045 0.0521 5000 0.6937 0.8968
#> adj 0.7906 0.0558 5000 0.6718 0.8895
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
#> rsq 0.8045 0.0521 5000 0.6527 0.8797
#> adj 0.7906 0.0558 5000 0.6278 0.8711
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
#> rsq 0.8045 0.0521 5000 0.6466 0.8779
#> adj 0.7906 0.0558 5000 0.6213 0.8692
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
#> rsq 0.002713540 0.002907364
#> adj 0.002907364 0.003115033
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>         2.5 %    97.5 %
#> rsq 0.6937054 0.8968400
#> adj 0.6718272 0.8894715
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>         2.5 %    97.5 %
#> rsq 0.6526504 0.8796771
#> adj 0.6278397 0.8710826
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>         2.5 %    97.5 %
#> rsq 0.6465582 0.8779490
#> adj 0.6213123 0.8692311
```

## References
