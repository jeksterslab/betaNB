# betaNB: Example Using the DiffBetaNB Function

Confidence intervals for differences of standardized regression slopes
are generated using the
[`DiffBetaNB()`](https://jeksterslab.github.io/betaNB/reference/DiffBetaNB.md)
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

### Differences of Standardized Regression Slopes

#### Normal-Theory Approach

\
`out`` ``<-`` `[`DiffBetaNB`](https://jeksterslab.github.io/betaNB/reference/DiffBetaNB.md)`(``nb``, alpha ``=`` ``0.05``)`

## Methods

### summary

Summary of the results of
[`DiffBetaNB()`](https://jeksterslab.github.io/betaNB/reference/DiffBetaNB.md).

#### Percentile Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"pc"``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "pc"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1325 5000 -0.1518 0.3690`\
`#> NARTIC-PCTSUPP 0.2319 0.1252 5000 -0.0152 0.4797`\
`#> PCTGRT-PCTSUPP 0.1282 0.1271 5000 -0.1249 0.3775`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "bc"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1325 5000 -0.1592 0.3635`\
`#> NARTIC-PCTSUPP 0.2319 0.1252 5000 -0.0270 0.4645`\
`#> PCTGRT-PCTSUPP 0.1282 0.1271 5000 -0.1246 0.3781`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "bca"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1325 5000 -0.1598 0.3633`\
`#> NARTIC-PCTSUPP 0.2319 0.1252 5000 -0.0295 0.4621`\
`#> PCTGRT-PCTSUPP 0.1282 0.1271 5000 -0.1091 0.3913`

### coef

Return the vector of estimates.

\
[`coef`](https://rdrr.io/r/stats/coef.html)`(``out``)`\
`#>  NARTIC-PCTGRT NARTIC-PCTSUPP PCTGRT-PCTSUPP `\
`#>      0.1036564      0.2318974      0.1282410`

### vcov

Return the sampling covariance matrix.

\
[`vcov`](https://rdrr.io/r/stats/vcov.html)`(``out``)`\
`#>                NARTIC-PCTGRT NARTIC-PCTSUPP PCTGRT-PCTSUPP`\
`#> NARTIC-PCTGRT    0.017548051    0.008539349   -0.009008702`\
`#> NARTIC-PCTSUPP   0.008539349    0.015675268    0.007135919`\
`#> PCTGRT-PCTSUPP  -0.009008702    0.007135919    0.016144621`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>                      2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.15179870 0.3689751`\
`#> NARTIC-PCTSUPP -0.01518639 0.4796980`\
`#> PCTGRT-PCTSUPP -0.12493893 0.3775117`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>                     2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.1591626 0.3634759`\
`#> NARTIC-PCTSUPP -0.0270258 0.4644711`\
`#> PCTGRT-PCTSUPP -0.1246358 0.3780501`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>                      2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.15981520 0.3633364`\
`#> NARTIC-PCTSUPP -0.02945117 0.4621390`\
`#> PCTGRT-PCTSUPP -0.10911232 0.3913309`

## References
