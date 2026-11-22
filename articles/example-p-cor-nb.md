# betaNB: Example Using the PCorNB Function

Confidence intervals for squared partial correlation coefficients are
generated using the
[`PCorNB()`](https://jeksterslab.github.io/betaNB/reference/PCorNB.md)
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

### Squared Partial Correlation Coefficients

#### Normal-Theory Approach

\
`out`` ``<-`` `[`PCorNB`](https://jeksterslab.github.io/betaNB/reference/PCorNB.md)`(``nb``, alpha ``=`` ``0.05``)`

## Methods

### summary

Summary of the results of
[`PCorNB()`](https://jeksterslab.github.io/betaNB/reference/PCorNB.md).

#### Percentile Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"pc"``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.0991 5000 0.2803 0.6677`\
`#> PCTGRT  0.3757 0.1070 5000 0.1569 0.5812`\
`#> PCTSUPP 0.2254 0.1141 5000 0.0453 0.4715`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.0991 5000 0.2561 0.6579`\
`#> PCTGRT  0.3757 0.1070 5000 0.1556 0.5800`\
`#> PCTSUPP 0.2254 0.1141 5000 0.0417 0.4655`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.0991 5000 0.2564 0.6581`\
`#> PCTGRT  0.3757 0.1070 5000 0.1630 0.5852`\
`#> PCTSUPP 0.2254 0.1141 5000 0.0304 0.4458`

### coef

Return the vector of estimates.

\
[`coef`](https://rdrr.io/r/stats/coef.html)`(``out``)`\
`#>    NARTIC    PCTGRT   PCTSUPP `\
`#> 0.4874382 0.3757383 0.2253739`

### vcov

Return the sampling covariance matrix.

\
[`vcov`](https://rdrr.io/r/stats/vcov.html)`(``out``)`\
`#>              NARTIC       PCTGRT      PCTSUPP`\
`#> NARTIC  0.009818281 0.0017219277 0.0023281504`\
`#> PCTGRT  0.001721928 0.0114511177 0.0005283513`\
`#> PCTSUPP 0.002328150 0.0005283513 0.0130134765`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.28033311 0.6677246`\
`#> PCTGRT  0.15691371 0.5812227`\
`#> PCTSUPP 0.04526989 0.4714565`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.25609682 0.6579372`\
`#> PCTGRT  0.15562079 0.5800183`\
`#> PCTSUPP 0.04165076 0.4655383`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>             2.5 %    97.5 %`\
`#> NARTIC  0.2563652 0.6580556`\
`#> PCTGRT  0.1629583 0.5852067`\
`#> PCTSUPP 0.0303994 0.4458441`

## References
