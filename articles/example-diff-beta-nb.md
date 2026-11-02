# betaNB: Example Using the DiffBetaNB Function

Confidence intervals for differences of standardized regression slopes
are generated using the
[`DiffBetaNB()`](https://github.com/jeksterslab/betaNB/reference/DiffBetaNB.md)
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

### Differences of Standardized Regression Slopes

#### Normal-Theory Approach

\
`out`` ``<-`` `[`DiffBetaNB`](https://github.com/jeksterslab/betaNB/reference/DiffBetaNB.md)`(``nb``, alpha ``=`` ``0.05``)`

## Methods

### summary

Summary of the results of
[`DiffBetaNB()`](https://github.com/jeksterslab/betaNB/reference/DiffBetaNB.md).

#### Percentile Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"pc"``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "pc"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1326 5000 -0.1514 0.3702`\
`#> NARTIC-PCTSUPP 0.2319 0.1235 5000 -0.0100 0.4805`\
`#> PCTGRT-PCTSUPP 0.1282 0.1267 5000 -0.1188 0.3787`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "bc"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1326 5000 -0.1466 0.3767`\
`#> NARTIC-PCTSUPP 0.2319 0.1235 5000 -0.0113 0.4804`\
`#> PCTGRT-PCTSUPP 0.1282 0.1267 5000 -0.1175 0.3802`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "bca"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1326 5000 -0.1477 0.3745`\
`#> NARTIC-PCTSUPP 0.2319 0.1235 5000 -0.0150 0.4780`\
`#> PCTGRT-PCTSUPP 0.1282 0.1267 5000 -0.1076 0.3984`

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
`#> NARTIC-PCTGRT    0.017571353    0.008386503   -0.009184850`\
`#> NARTIC-PCTSUPP   0.008386503    0.015243359    0.006856856`\
`#> PCTGRT-PCTSUPP  -0.009184850    0.006856856    0.016041706`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>                      2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.15140459 0.3702199`\
`#> NARTIC-PCTSUPP -0.01001236 0.4804931`\
`#> PCTGRT-PCTSUPP -0.11875853 0.3786585`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>                      2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.14662624 0.3767237`\
`#> NARTIC-PCTSUPP -0.01133948 0.4804052`\
`#> PCTGRT-PCTSUPP -0.11752706 0.3802373`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>                      2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.14773119 0.3745257`\
`#> NARTIC-PCTSUPP -0.01502808 0.4779739`\
`#> PCTGRT-PCTSUPP -0.10759777 0.3983777`

## References
