# betaNB: Example Using the DiffBetaNB Function

Confidence intervals for differences of standardized regression slopes
are generated using the
[`DiffBetaNB()`](https://github.com/jeksterslab/betaNB/reference/DiffBetaNB.md)
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

### Differences of Standardized Regression Slopes

#### Normal-Theory Approach

``` r

out <- DiffBetaNB(nb, alpha = 0.05)
```

## Methods

### summary

Summary of the results of
[`DiffBetaNB()`](https://github.com/jeksterslab/betaNB/reference/DiffBetaNB.md).

#### Percentile Confidence Intervals

``` r

summary(out, type = "pc")
#> Call:
#> DiffBetaNB(object = nb, alpha = 0.05)
#> 
#> Differences of standardized regression slopes
#> type = "pc"
#>                   est     se    R    2.5%  97.5%
#> NARTIC-PCTGRT  0.1037 0.1324 5000 -0.1555 0.3668
#> NARTIC-PCTSUPP 0.2319 0.1228 5000  0.0004 0.4786
#> PCTGRT-PCTSUPP 0.1282 0.1265 5000 -0.1199 0.3718
```

#### Bias Corrected Confidence Intervals

``` r

summary(out, type = "bc")
#> Call:
#> DiffBetaNB(object = nb, alpha = 0.05)
#> 
#> Differences of standardized regression slopes
#> type = "bc"
#>                   est     se    R    2.5%  97.5%
#> NARTIC-PCTGRT  0.1037 0.1324 5000 -0.1627 0.3642
#> NARTIC-PCTSUPP 0.2319 0.1228 5000 -0.0023 0.4765
#> PCTGRT-PCTSUPP 0.1282 0.1265 5000 -0.1132 0.3798
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

summary(out, type = "bca")
#> Call:
#> DiffBetaNB(object = nb, alpha = 0.05)
#> 
#> Differences of standardized regression slopes
#> type = "bca"
#>                   est     se    R    2.5%  97.5%
#> NARTIC-PCTGRT  0.1037 0.1324 5000 -0.1629 0.3628
#> NARTIC-PCTSUPP 0.2319 0.1228 5000 -0.0036 0.4718
#> PCTGRT-PCTSUPP 0.1282 0.1265 5000 -0.1022 0.3918
```

### coef

Return the vector of estimates.

``` r

coef(out)
#>  NARTIC-PCTGRT NARTIC-PCTSUPP PCTGRT-PCTSUPP 
#>      0.1036564      0.2318974      0.1282410
```

### vcov

Return the sampling covariance matrix.

``` r

vcov(out)
#>                NARTIC-PCTGRT NARTIC-PCTSUPP PCTGRT-PCTSUPP
#> NARTIC-PCTGRT    0.017537882    0.008309724   -0.009228158
#> NARTIC-PCTSUPP   0.008309724    0.015079328    0.006769604
#> PCTGRT-PCTSUPP  -0.009228158    0.006769604    0.015997762
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>                        2.5 %    97.5 %
#> NARTIC-PCTGRT  -0.1554984229 0.3668378
#> NARTIC-PCTSUPP  0.0004015529 0.4785688
#> PCTGRT-PCTSUPP -0.1198726142 0.3718124
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>                       2.5 %    97.5 %
#> NARTIC-PCTGRT  -0.162656941 0.3642238
#> NARTIC-PCTSUPP -0.002323228 0.4764958
#> PCTGRT-PCTSUPP -0.113211244 0.3797832
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>                       2.5 %    97.5 %
#> NARTIC-PCTGRT  -0.162939869 0.3628479
#> NARTIC-PCTSUPP -0.003590219 0.4717809
#> PCTGRT-PCTSUPP -0.102184257 0.3917564
```

## References
