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
`#> NARTIC-PCTGRT  0.1037 0.1321 5000 -0.1425 0.3719`\
`#> NARTIC-PCTSUPP 0.2319 0.1242 5000 -0.0079 0.4746`\
`#> PCTGRT-PCTSUPP 0.1282 0.1283 5000 -0.1237 0.3774`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "bc"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1321 5000 -0.1486 0.3641`\
`#> NARTIC-PCTSUPP 0.2319 0.1242 5000 -0.0090 0.4733`\
`#> PCTGRT-PCTSUPP 0.1282 0.1283 5000 -0.1182 0.3816`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "bca"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1321 5000 -0.1493 0.3636`\
`#> NARTIC-PCTSUPP 0.2319 0.1242 5000 -0.0111 0.4707`\
`#> PCTGRT-PCTSUPP 0.1282 0.1283 5000 -0.1080 0.3984`

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
`#> NARTIC-PCTGRT    0.017458453    0.008215987   -0.009242466`\
`#> NARTIC-PCTSUPP   0.008215987    0.015421714    0.007205727`\
`#> PCTGRT-PCTSUPP  -0.009242466    0.007205727    0.016448194`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>                       2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.142466885 0.3718671`\
`#> NARTIC-PCTSUPP -0.007911867 0.4746493`\
`#> PCTGRT-PCTSUPP -0.123734805 0.3773808`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>                       2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.148638663 0.3641222`\
`#> NARTIC-PCTSUPP -0.008951561 0.4733178`\
`#> PCTGRT-PCTSUPP -0.118210219 0.3815534`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>                      2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.14933595 0.3635693`\
`#> NARTIC-PCTSUPP -0.01114183 0.4707145`\
`#> PCTGRT-PCTSUPP -0.10797543 0.3984144`

## References
