# betaNB: Example Using the DeltaRSqNB Function

Confidence intervals for improvement in R-squared are generated using
the
[`DeltaRSqNB()`](https://github.com/jeksterslab/betaNB/reference/DeltaRSqNB.md)
function from the `betaNB` package. In this example, we use the data set
and the model used in [betaNB: Example Using the BetaNB
Function](https://github.com/jeksterslab/betaNB/articles/example-beta-nb.md).

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`betaNB`](https://github.com/jeksterslab/betaNB)`)`

\
`df`` ``<-`` ``betaNB``::`[`nas1982`](https://github.com/jeksterslab/betaNB/reference/nas1982.md)

### Regression

Fit the regression model using the
[`lm()`](https://rdrr.io/r/stats/lm.html) function.

\
`object`` ``<-`` `[`lm`](https://rdrr.io/r/stats/lm.html)`(``QUALITY`` ``~`` ``NARTIC`` ``+`` ``PCTGRT`` ``+`` ``PCTSUPP``, data ``=`` ``df``)`

### Nonparametric Bootstrap

\
`nb`` ``<-`` `[`NB`](https://github.com/jeksterslab/betaNB/reference/NB.md)`(``object``)`

### Improvement in R-squared

#### Normal-Theory Approach

\
`out`` ``<-`` `[`DeltaRSqNB`](https://github.com/jeksterslab/betaNB/reference/DeltaRSqNB.md)`(``nb``, alpha ``=`` ``0.05``)`

## Methods

### summary

Summary of the results of
[`DeltaRSqNB()`](https://github.com/jeksterslab/betaNB/reference/DeltaRSqNB.md).

#### Percentile Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"pc"``)`\
`#> Call:`\
`#> DeltaRSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Improvement in R-squared`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.1859 0.0592 5000 0.0838 0.3148`\
`#> PCTGRT  0.1177 0.0481 5000 0.0364 0.2238`\
`#> PCTSUPP 0.0569 0.0338 5000 0.0093 0.1397`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> DeltaRSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Improvement in R-squared`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.1859 0.0592 5000 0.0929 0.3377`\
`#> PCTGRT  0.1177 0.0481 5000 0.0453 0.2419`\
`#> PCTSUPP 0.0569 0.0338 5000 0.0116 0.1499`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> DeltaRSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Improvement in R-squared`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.1859 0.0592 5000 0.0960 0.3476`\
`#> PCTGRT  0.1177 0.0481 5000 0.0487 0.2523`\
`#> PCTSUPP 0.0569 0.0338 5000 0.0107 0.1448`

### coef

Return the vector of estimates.

\
[`coef`](https://rdrr.io/r/stats/coef.html)`(``out``)`\
`#>    NARTIC    PCTGRT   PCTSUPP `\
`#> 0.1858925 0.1176542 0.0568722`

### vcov

Return the sampling covariance matrix.

\
[`vcov`](https://rdrr.io/r/stats/vcov.html)`(``out``)`\
`#>                NARTIC        PCTGRT       PCTSUPP`\
`#> NARTIC   0.0035093911 -0.0002383336 -0.0002229942`\
`#> PCTGRT  -0.0002383336  0.0023151070 -0.0002548391`\
`#> PCTSUPP -0.0002229942 -0.0002548391  0.0011393878`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>               2.5 %    97.5 %`\
`#> NARTIC  0.083757393 0.3147993`\
`#> PCTGRT  0.036392876 0.2237773`\
`#> PCTSUPP 0.009338141 0.1396577`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.09286060 0.3376644`\
`#> PCTGRT  0.04529890 0.2418706`\
`#> PCTSUPP 0.01155723 0.1499424`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.09599069 0.3476123`\
`#> PCTGRT  0.04868579 0.2523253`\
`#> PCTSUPP 0.01066399 0.1447735`

## References
