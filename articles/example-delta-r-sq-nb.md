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
`#> NARTIC  0.1859 0.0578 5000 0.0791 0.3093`\
`#> PCTGRT  0.1177 0.0481 5000 0.0360 0.2215`\
`#> PCTSUPP 0.0569 0.0333 5000 0.0086 0.1361`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> DeltaRSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Improvement in R-squared`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.1859 0.0578 5000 0.0940 0.3340`\
`#> PCTGRT  0.1177 0.0481 5000 0.0435 0.2385`\
`#> PCTSUPP 0.0569 0.0333 5000 0.0102 0.1435`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> DeltaRSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Improvement in R-squared`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.1859 0.0578 5000 0.0985 0.3432`\
`#> PCTGRT  0.1177 0.0481 5000 0.0470 0.2553`\
`#> PCTSUPP 0.0569 0.0333 5000 0.0093 0.1392`

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
`#> NARTIC   0.0033400766 -0.0002752892 -0.0002038799`\
`#> PCTGRT  -0.0002752892  0.0023130643 -0.0002716201`\
`#> PCTSUPP -0.0002038799 -0.0002716201  0.0011107343`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>               2.5 %    97.5 %`\
`#> NARTIC  0.079103186 0.3092624`\
`#> PCTGRT  0.035984680 0.2214973`\
`#> PCTSUPP 0.008583263 0.1360663`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.09400901 0.3340498`\
`#> PCTGRT  0.04346971 0.2384734`\
`#> PCTSUPP 0.01022458 0.1434716`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>               2.5 %    97.5 %`\
`#> NARTIC  0.098521491 0.3431962`\
`#> PCTGRT  0.046989955 0.2553339`\
`#> PCTSUPP 0.009255597 0.1391925`

## References
