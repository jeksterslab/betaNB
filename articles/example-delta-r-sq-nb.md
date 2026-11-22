# betaNB: Example Using the DeltaRSqNB Function

Confidence intervals for improvement in R-squared are generated using
the
[`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md)
function from the `betaNB` package. In this example, we use the data set
and the model used in [betaNB: Example Using the BetaNB
Function](https://jeksterslab.github.io/betaNB/articles/example-beta-nb.md).

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`betaNB`](https://github.com/jeksterslab/betaNB)`)`

\
`df`` ``<-`` ``betaNB``::`[`nas1982`](https://jeksterslab.github.io/betaNB/reference/nas1982.md)

### Regression

Fit the regression model using the
[`lm()`](https://rdrr.io/r/stats/lm.html) function.

\
`object`` ``<-`` `[`lm`](https://rdrr.io/r/stats/lm.html)`(``QUALITY`` ``~`` ``NARTIC`` ``+`` ``PCTGRT`` ``+`` ``PCTSUPP``, data ``=`` ``df``)`

### Nonparametric Bootstrap

\
`nb`` ``<-`` `[`NB`](https://jeksterslab.github.io/betaNB/reference/NB.md)`(``object``)`

### Improvement in R-squared

#### Normal-Theory Approach

\
`out`` ``<-`` `[`DeltaRSqNB`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md)`(``nb``, alpha ``=`` ``0.05``)`

## Methods

### summary

Summary of the results of
[`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md).

#### Percentile Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"pc"``)`\
`#> Call:`\
`#> DeltaRSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Improvement in R-squared`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.1859 0.0590 5000 0.0803 0.3107`\
`#> PCTGRT  0.1177 0.0482 5000 0.0334 0.2227`\
`#> PCTSUPP 0.0569 0.0340 5000 0.0084 0.1367`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> DeltaRSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Improvement in R-squared`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.1859 0.0590 5000 0.0918 0.3340`\
`#> PCTGRT  0.1177 0.0482 5000 0.0452 0.2432`\
`#> PCTSUPP 0.0569 0.0340 5000 0.0106 0.1458`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> DeltaRSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Improvement in R-squared`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.1859 0.0590 5000 0.0961 0.3430`\
`#> PCTGRT  0.1177 0.0482 5000 0.0502 0.2532`\
`#> PCTSUPP 0.0569 0.0340 5000 0.0095 0.1419`

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
`#> NARTIC   0.0034858220 -0.0002657589 -0.0002808123`\
`#> PCTGRT  -0.0002657589  0.0023190316 -0.0002526860`\
`#> PCTSUPP -0.0002808123 -0.0002526860  0.0011532442`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>               2.5 %    97.5 %`\
`#> NARTIC  0.080317408 0.3106808`\
`#> PCTGRT  0.033350221 0.2227354`\
`#> PCTSUPP 0.008416453 0.1366950`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.09175587 0.3340003`\
`#> PCTGRT  0.04524251 0.2432417`\
`#> PCTSUPP 0.01057903 0.1458029`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>               2.5 %    97.5 %`\
`#> NARTIC  0.096086860 0.3430073`\
`#> PCTGRT  0.050206093 0.2532121`\
`#> PCTSUPP 0.009511528 0.1418654`

## References
