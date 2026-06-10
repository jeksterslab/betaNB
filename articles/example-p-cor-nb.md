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
#> NARTIC  0.4874 0.0990 5000 0.2839 0.6713
#> PCTGRT  0.3757 0.1069 5000 0.1651 0.5828
#> PCTSUPP 0.2254 0.1159 5000 0.0400 0.4795
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
#> NARTIC  0.4874 0.0990 5000 0.2659 0.6551
#> PCTGRT  0.3757 0.1069 5000 0.1645 0.5821
#> PCTSUPP 0.2254 0.1159 5000 0.0380 0.4733
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
#> NARTIC  0.4874 0.0990 5000 0.2662 0.6553
#> PCTGRT  0.3757 0.1069 5000 0.1698 0.5851
#> PCTSUPP 0.2254 0.1159 5000 0.0269 0.4510
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
#> NARTIC  0.009799398 0.0017154944 0.0019574927
#> PCTGRT  0.001715494 0.0114332592 0.0008842216
#> PCTSUPP 0.001957493 0.0008842216 0.0134233087
```

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

``` r

confint(out, level = 0.95, type = "pc")
#>              2.5 %    97.5 %
#> NARTIC  0.28385373 0.6712992
#> PCTGRT  0.16512710 0.5827568
#> PCTSUPP 0.03996001 0.4794838
```

#### Bias Corrected Confidence Intervals

``` r

confint(out, level = 0.95, type = "bc")
#>              2.5 %    97.5 %
#> NARTIC  0.26590173 0.6551467
#> PCTGRT  0.16445838 0.5820937
#> PCTSUPP 0.03797799 0.4733040
```

#### Bias Corrected and Accelerated Confidence Intervals

``` r

confint(out, level = 0.95, type = "bca")
#>              2.5 %    97.5 %
#> NARTIC  0.26624160 0.6552970
#> PCTGRT  0.16977608 0.5851478
#> PCTSUPP 0.02687849 0.4510365
```

## References
