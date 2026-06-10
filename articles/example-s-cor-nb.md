# betaNB: Example Using the SCorNB Function

Confidence intervals for semipartial correlation coefficients are
generated using the
[`SCorNB()`](https://github.com/jeksterslab/betaNB/reference/SCorNB.md)
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

### Semipartial Correlation Coefficients

#### Normal-Theory Approach

``` r

out <- SCorNB(nb, alpha = 0.05)
```

## Methods

### summary

Summary of the results of
[`SCorNB()`](https://github.com/jeksterslab/betaNB/reference/SCorNB.md).

#### Percentile Confidence Intervals

``` r

summary(out, type = "pc")
#> Call:
#> SCorNB(object = nb, alpha = 0.05)
#> 
#> Semipartial correlations
#> type = "pc"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.4312 0.0704 5000 0.2832 0.5575
#> PCTGRT  0.3430 0.0726 5000 0.1897 0.4779
#> PCTSUPP 0.2385 0.0722 5000 0.0939 0.3747
```

#### Bias Corrected Confidence Intervals

``` r

summary(out, type = "bc")
#> Call:
#> SCorNB(object = nb, alpha = 0.05)
#> 
#> Semipartial correlations
#> type = "bc"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.4312 0.0704 5000 0.3048 0.5774
#> PCTGRT  0.3430 0.0726 5000 0.2134 0.4943
#> PCTSUPP 0.2385 0.0722 5000 0.1088 0.3904
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

summary(out, type = "bca")
#> Call:
#> SCorNB(object = nb, alpha = 0.05)
#> 
#> Semipartial correlations
#> type = "bca"
#>            est     se    R   2.5%  97.5%
#> NARTIC  0.4312 0.0704 5000 0.3109 0.5878
#> PCTGRT  0.3430 0.0726 5000 0.2237 0.5083
#> PCTSUPP 0.2385 0.0722 5000 0.1064 0.3868
```

### coef

Return the vector of estimates.

``` r

coef(out)
#>    NARTIC    PCTGRT   PCTSUPP 
#> 0.4311525 0.3430075 0.2384789
```

### vcov

Return the sampling covariance matrix.

``` r

vcov(out)
#>                NARTIC        PCTGRT       PCTSUPP
#> NARTIC   0.0049524144 -0.0004858894 -0.0007898147
#> PCTGRT  -0.0004858894  0.0052675717 -0.0007948713
#> PCTSUPP -0.0007898147 -0.0007948713  0.0052099148
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>              2.5 %    97.5 %
#> NARTIC  0.28320585 0.5574531
#> PCTGRT  0.18968176 0.4778815
#> PCTSUPP 0.09394099 0.3747119
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>             2.5 %    97.5 %
#> NARTIC  0.3047911 0.5773823
#> PCTGRT  0.2133921 0.4942692
#> PCTSUPP 0.1087848 0.3904244
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>             2.5 %    97.5 %
#> NARTIC  0.3109300 0.5878106
#> PCTGRT  0.2236736 0.5082628
#> PCTSUPP 0.1064217 0.3867941
```

## References
