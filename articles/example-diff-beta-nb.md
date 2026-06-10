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
#> NARTIC-PCTGRT  0.1037 0.1317 5000 -0.1508 0.3713
#> NARTIC-PCTSUPP 0.2319 0.1225 5000 -0.0045 0.4786
#> PCTGRT-PCTSUPP 0.1282 0.1262 5000 -0.1087 0.3819
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
#> NARTIC-PCTGRT  0.1037 0.1317 5000 -0.1613 0.3588
#> NARTIC-PCTSUPP 0.2319 0.1225 5000 -0.0059 0.4784
#> PCTGRT-PCTSUPP 0.1282 0.1262 5000 -0.1011 0.3904
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
#> NARTIC-PCTGRT  0.1037 0.1317 5000 -0.1622 0.3576
#> NARTIC-PCTSUPP 0.2319 0.1225 5000 -0.0082 0.4770
#> PCTGRT-PCTSUPP 0.1282 0.1262 5000 -0.0898 0.4019
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
#> NARTIC-PCTGRT    0.017356915    0.008213228   -0.009143687
#> NARTIC-PCTSUPP   0.008213228    0.014999147    0.006785920
#> PCTGRT-PCTSUPP  -0.009143687    0.006785920    0.015929607
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>                       2.5 %    97.5 %
#> NARTIC-PCTGRT  -0.150757242 0.3712569
#> NARTIC-PCTSUPP -0.004454982 0.4786453
#> PCTGRT-PCTSUPP -0.108708781 0.3818538
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>                      2.5 %    97.5 %
#> NARTIC-PCTGRT  -0.16130068 0.3587898
#> NARTIC-PCTSUPP -0.00588999 0.4784130
#> PCTGRT-PCTSUPP -0.10110641 0.3904004
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>                       2.5 %    97.5 %
#> NARTIC-PCTGRT  -0.162224277 0.3575540
#> NARTIC-PCTSUPP -0.008206039 0.4770031
#> PCTGRT-PCTSUPP -0.089816189 0.4018992
```

## References
