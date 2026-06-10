# betaNB: Example Using the DeltaRSqNB Function

Confidence intervals for improvement in R-squared are generated using
the
[`DeltaRSqNB()`](https://github.com/jeksterslab/betaNB/reference/DeltaRSqNB.md)
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

### Improvement in R-squared

#### Normal-Theory Approach

``` r

out <- DeltaRSqNB(nb, alpha = 0.05)
```

## Methods

### summary

Summary of the results of
[`DeltaRSqNB()`](https://github.com/jeksterslab/betaNB/reference/DeltaRSqNB.md).

#### Percentile Confidence Intervals

``` r

summary(out, type = "pc")
#> Call:
#> DeltaRSqNB(object = nb, alpha = 0.05)
#> 
#> Improvement in R-squared
#> type = "pc"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.1859 0.0597 5000 0.0822 0.3134
#> PCTGRT  0.1177 0.0491 5000 0.0341 0.2232
#> PCTSUPP 0.0569 0.0343 5000 0.0086 0.1413
```

#### Bias Corrected Confidence Intervals

``` r

summary(out, type = "bc")
#> Call:
#> DeltaRSqNB(object = nb, alpha = 0.05)
#> 
#> Improvement in R-squared
#> type = "bc"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.1859 0.0597 5000 0.0936 0.3323
#> PCTGRT  0.1177 0.0491 5000 0.0419 0.2398
#> PCTSUPP 0.0569 0.0343 5000 0.0104 0.1472
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

summary(out, type = "bca")
#> Call:
#> DeltaRSqNB(object = nb, alpha = 0.05)
#> 
#> Improvement in R-squared
#> type = "bca"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.1859 0.0597 5000 0.0970 0.3398
#> PCTGRT  0.1177 0.0491 5000 0.0460 0.2515
#> PCTSUPP 0.0569 0.0343 5000 0.0091 0.1430
```

### coef

Return the vector of estimates.

``` r

coef(out)
#>    NARTIC    PCTGRT   PCTSUPP 
#> 0.1858925 0.1176542 0.0568722
```

### vcov

Return the sampling covariance matrix.

``` r

vcov(out)
#>                NARTIC        PCTGRT       PCTSUPP
#> NARTIC   0.0035642433 -0.0002354521 -0.0002795930
#> PCTGRT  -0.0002354521  0.0024093541 -0.0002906479
#> PCTSUPP -0.0002795930 -0.0002906479  0.0011738516
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>               2.5 %    97.5 %
#> NARTIC  0.082234852 0.3134054
#> PCTGRT  0.034098248 0.2232247
#> PCTSUPP 0.008630746 0.1413020
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>              2.5 %    97.5 %
#> NARTIC  0.09360306 0.3322920
#> PCTGRT  0.04192096 0.2398206
#> PCTSUPP 0.01035033 0.1472059
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>               2.5 %    97.5 %
#> NARTIC  0.097008642 0.3397678
#> PCTGRT  0.046022546 0.2515047
#> PCTSUPP 0.009127099 0.1430070
```

## References
