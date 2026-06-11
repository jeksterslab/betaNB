# betaNB: Example Using the PCorNB Function

Confidence intervals for squared partial correlation coefficients are
generated using the
[`PCorNB()`](https://github.com/jeksterslab/betaNB/reference/PCorNB.md)
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

### Squared Partial Correlation Coefficients

#### Normal-Theory Approach

``` r

out <- PCorNB(nb, alpha = 0.05)
```

## Methods

### summary

Summary of the results of
[`PCorNB()`](https://github.com/jeksterslab/betaNB/reference/PCorNB.md).

#### Percentile Confidence Intervals

``` r

summary(out, type = "pc")
#> Call:
#> PCorNB(object = nb, alpha = 0.05)
#> 
#> Squared partial correlations
#> type = "pc"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.4874 0.0983 5000 0.2781 0.6656
#> PCTGRT  0.3757 0.1078 5000 0.1587 0.5763
#> PCTSUPP 0.2254 0.1142 5000 0.0442 0.4792
```

#### Bias Corrected Confidence Intervals

``` r

summary(out, type = "bc")
#> Call:
#> PCorNB(object = nb, alpha = 0.05)
#> 
#> Squared partial correlations
#> type = "bc"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.4874 0.0983 5000 0.2621 0.6550
#> PCTGRT  0.3757 0.1078 5000 0.1493 0.5705
#> PCTSUPP 0.2254 0.1142 5000 0.0441 0.4786
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

summary(out, type = "bca")
#> Call:
#> PCorNB(object = nb, alpha = 0.05)
#> 
#> Squared partial correlations
#> type = "bca"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.4874 0.0983 5000 0.2622 0.6553
#> PCTGRT  0.3757 0.1078 5000 0.1555 0.5743
#> PCTSUPP 0.2254 0.1142 5000 0.0280 0.4542
```

### coef

Return the vector of estimates.

``` r

coef(out)
#>    NARTIC    PCTGRT   PCTSUPP 
#> 0.4874382 0.3757383 0.2253739
```

### vcov

Return the sampling covariance matrix.

``` r

vcov(out)
#>              NARTIC       PCTGRT      PCTSUPP
#> NARTIC  0.009658370 0.0016826932 0.0020011141
#> PCTGRT  0.001682693 0.0116263995 0.0007333759
#> PCTSUPP 0.002001114 0.0007333759 0.0130309953
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>              2.5 %    97.5 %
#> NARTIC  0.27811204 0.6655810
#> PCTGRT  0.15865411 0.5762806
#> PCTSUPP 0.04422461 0.4792406
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>              2.5 %    97.5 %
#> NARTIC  0.26211006 0.6550160
#> PCTGRT  0.14934640 0.5705478
#> PCTSUPP 0.04407698 0.4785623
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>              2.5 %    97.5 %
#> NARTIC  0.26224161 0.6553117
#> PCTGRT  0.15549199 0.5743441
#> PCTSUPP 0.02796673 0.4542210
```

## References
