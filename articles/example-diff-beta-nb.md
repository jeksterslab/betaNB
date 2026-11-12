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
`#> NARTIC-PCTGRT  0.1037 0.1321 5000 -0.1576 0.3712`\
`#> NARTIC-PCTSUPP 0.2319 0.1249 5000 -0.0170 0.4707`\
`#> PCTGRT-PCTSUPP 0.1282 0.1269 5000 -0.1198 0.3783`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "bc"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1321 5000 -0.1584 0.3708`\
`#> NARTIC-PCTSUPP 0.2319 0.1249 5000 -0.0160 0.4727`\
`#> PCTGRT-PCTSUPP 0.1282 0.1269 5000 -0.1190 0.3805`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "bca"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1321 5000 -0.1609 0.3692`\
`#> NARTIC-PCTSUPP 0.2319 0.1249 5000 -0.0180 0.4699`\
`#> PCTGRT-PCTSUPP 0.1282 0.1269 5000 -0.1082 0.3971`

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
`#> NARTIC-PCTGRT    0.017437817    0.008469112   -0.008968705`\
`#> NARTIC-PCTSUPP   0.008469112    0.015599854    0.007130741`\
`#> PCTGRT-PCTSUPP  -0.008968705    0.007130741    0.016099446`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>                      2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.15756052 0.3712361`\
`#> NARTIC-PCTSUPP -0.01698271 0.4706734`\
`#> PCTGRT-PCTSUPP -0.11977929 0.3782666`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>                      2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.15835189 0.3707714`\
`#> NARTIC-PCTSUPP -0.01603969 0.4726657`\
`#> PCTGRT-PCTSUPP -0.11899001 0.3805022`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>                      2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.16086888 0.3691959`\
`#> NARTIC-PCTSUPP -0.01801323 0.4698730`\
`#> PCTGRT-PCTSUPP -0.10818679 0.3971232`

## References
