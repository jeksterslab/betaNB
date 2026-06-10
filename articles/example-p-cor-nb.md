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
#> NARTIC  0.4874 0.0999 5000 0.2801 0.6686
#> PCTGRT  0.3757 0.1078 5000 0.1612 0.5805
#> PCTSUPP 0.2254 0.1137 5000 0.0418 0.4786
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
#> NARTIC  0.4874 0.0999 5000 0.2654 0.6596
#> PCTGRT  0.3757 0.1078 5000 0.1605 0.5800
#> PCTSUPP 0.2254 0.1137 5000 0.0418 0.4775
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
#> NARTIC  0.4874 0.0999 5000 0.2659 0.6598
#> PCTGRT  0.3757 0.1078 5000 0.1658 0.5850
#> PCTSUPP 0.2254 0.1137 5000 0.0267 0.4498
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
#>              NARTIC      PCTGRT     PCTSUPP
#> NARTIC  0.009987847 0.001547597 0.001957922
#> PCTGRT  0.001547597 0.011612776 0.001127687
#> PCTSUPP 0.001957922 0.001127687 0.012921644
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>             2.5 %    97.5 %
#> NARTIC  0.2800513 0.6686078
#> PCTGRT  0.1611839 0.5804881
#> PCTSUPP 0.0418416 0.4785873
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>              2.5 %    97.5 %
#> NARTIC  0.26535394 0.6596203
#> PCTGRT  0.16051578 0.5800165
#> PCTSUPP 0.04177025 0.4775379
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>              2.5 %    97.5 %
#> NARTIC  0.26585525 0.6597626
#> PCTGRT  0.16577853 0.5849973
#> PCTSUPP 0.02670642 0.4498205
```

## References
