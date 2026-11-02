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
`#> NARTIC  0.1859 0.0580 5000 0.0815 0.3092`\
`#> PCTGRT  0.1177 0.0483 5000 0.0362 0.2220`\
`#> PCTSUPP 0.0569 0.0332 5000 0.0081 0.1362`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> DeltaRSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Improvement in R-squared`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.1859 0.0580 5000 0.0938 0.3278`\
`#> PCTGRT  0.1177 0.0483 5000 0.0439 0.2389`\
`#> PCTSUPP 0.0569 0.0332 5000 0.0111 0.1458`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> DeltaRSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Improvement in R-squared`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.1859 0.0580 5000 0.0976 0.3378`\
`#> PCTGRT  0.1177 0.0483 5000 0.0479 0.2549`\
`#> PCTSUPP 0.0569 0.0332 5000 0.0098 0.1420`

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
`#> NARTIC   0.0033694289 -0.0002391592 -0.0002571749`\
`#> PCTGRT  -0.0002391592  0.0023297210 -0.0002374312`\
`#> PCTSUPP -0.0002571749 -0.0002374312  0.0011028303`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>               2.5 %    97.5 %`\
`#> NARTIC  0.081535796 0.3091611`\
`#> PCTGRT  0.036232658 0.2220360`\
`#> PCTSUPP 0.008118782 0.1362059`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.09378353 0.3278135`\
`#> PCTGRT  0.04388551 0.2389215`\
`#> PCTSUPP 0.01112285 0.1457872`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>               2.5 %    97.5 %`\
`#> NARTIC  0.097633349 0.3377834`\
`#> PCTGRT  0.047946441 0.2548523`\
`#> PCTSUPP 0.009838364 0.1419608`

## References
