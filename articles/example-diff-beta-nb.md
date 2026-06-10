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
#> NARTIC-PCTGRT  0.1037 0.1336 5000 -0.1573 0.3770
#> NARTIC-PCTSUPP 0.2319 0.1243 5000 -0.0005 0.4849
#> PCTGRT-PCTSUPP 0.1282 0.1288 5000 -0.1191 0.3822
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
#> NARTIC-PCTGRT  0.1037 0.1336 5000 -0.1658 0.3720
#> NARTIC-PCTSUPP 0.2319 0.1243 5000 -0.0035 0.4809
#> PCTGRT-PCTSUPP 0.1282 0.1288 5000 -0.1162 0.3853
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
#> NARTIC-PCTGRT  0.1037 0.1336 5000 -0.1673 0.3713
#> NARTIC-PCTSUPP 0.2319 0.1243 5000 -0.0069 0.4766
#> PCTGRT-PCTSUPP 0.1282 0.1288 5000 -0.1047 0.3994
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
#> NARTIC-PCTGRT    0.017854410    0.008348747   -0.009505663
#> NARTIC-PCTSUPP   0.008348747    0.015444733    0.007095987
#> PCTGRT-PCTSUPP  -0.009505663    0.007095987    0.016601650
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>                        2.5 %    97.5 %
#> NARTIC-PCTGRT  -0.1572532341 0.3769714
#> NARTIC-PCTSUPP -0.0005209957 0.4848941
#> PCTGRT-PCTSUPP -0.1190790790 0.3822043
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>                       2.5 %    97.5 %
#> NARTIC-PCTGRT  -0.165828321 0.3719709
#> NARTIC-PCTSUPP -0.003469543 0.4808853
#> PCTGRT-PCTSUPP -0.116196566 0.3852522
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>                      2.5 %    97.5 %
#> NARTIC-PCTGRT  -0.16731590 0.3713440
#> NARTIC-PCTSUPP -0.00694688 0.4766088
#> PCTGRT-PCTSUPP -0.10471418 0.3993842
```

## References
