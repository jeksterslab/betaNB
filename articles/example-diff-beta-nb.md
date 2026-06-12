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
#> NARTIC-PCTGRT  0.1037 0.1313 5000 -0.1422 0.3701
#> NARTIC-PCTSUPP 0.2319 0.1249 5000 -0.0061 0.4859
#> PCTGRT-PCTSUPP 0.1282 0.1265 5000 -0.1154 0.3831
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
#> NARTIC-PCTGRT  0.1037 0.1313 5000 -0.1446 0.3655
#> NARTIC-PCTSUPP 0.2319 0.1249 5000 -0.0227 0.4733
#> PCTGRT-PCTSUPP 0.1282 0.1265 5000 -0.1135 0.3845
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
#> NARTIC-PCTGRT  0.1037 0.1313 5000 -0.1467 0.3647
#> NARTIC-PCTSUPP 0.2319 0.1249 5000 -0.0267 0.4693
#> PCTGRT-PCTSUPP 0.1282 0.1265 5000 -0.1022 0.3980
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
#> NARTIC-PCTGRT    0.017229727    0.008419163   -0.008810563
#> NARTIC-PCTSUPP   0.008419163    0.015609250    0.007190086
#> PCTGRT-PCTSUPP  -0.008810563    0.007190086    0.016000650
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>                       2.5 %    97.5 %
#> NARTIC-PCTGRT  -0.142212003 0.3700797
#> NARTIC-PCTSUPP -0.006107237 0.4858998
#> PCTGRT-PCTSUPP -0.115416919 0.3831277
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>                      2.5 %    97.5 %
#> NARTIC-PCTGRT  -0.14457317 0.3655235
#> NARTIC-PCTSUPP -0.02268654 0.4733267
#> PCTGRT-PCTSUPP -0.11347571 0.3845138
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>                      2.5 %    97.5 %
#> NARTIC-PCTGRT  -0.14667317 0.3646706
#> NARTIC-PCTSUPP -0.02673211 0.4693195
#> PCTGRT-PCTSUPP -0.10223594 0.3980423
```

## References
