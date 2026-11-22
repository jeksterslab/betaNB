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
`#> NARTIC-PCTGRT  0.1037 0.1328 5000 -0.1600 0.3714`\
`#> NARTIC-PCTSUPP 0.2319 0.1229 5000 -0.0014 0.4781`\
`#> PCTGRT-PCTSUPP 0.1282 0.1289 5000 -0.1170 0.3873`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "bc"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1328 5000 -0.1629 0.3674`\
`#> NARTIC-PCTSUPP 0.2319 0.1229 5000 -0.0094 0.4708`\
`#> PCTGRT-PCTSUPP 0.1282 0.1289 5000 -0.1158 0.3891`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "bca"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1328 5000 -0.1637 0.3654`\
`#> NARTIC-PCTSUPP 0.2319 0.1229 5000 -0.0138 0.4687`\
`#> PCTGRT-PCTSUPP 0.1282 0.1289 5000 -0.1043 0.4016`

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
`#> NARTIC-PCTGRT    0.017629919    0.008059692   -0.009570226`\
`#> NARTIC-PCTSUPP   0.008059692    0.015115299    0.007055606`\
`#> PCTGRT-PCTSUPP  -0.009570226    0.007055606    0.016625832`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>                       2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.159990073 0.3714183`\
`#> NARTIC-PCTSUPP -0.001436075 0.4781275`\
`#> PCTGRT-PCTSUPP -0.116967983 0.3872731`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>                       2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.162891247 0.3674279`\
`#> NARTIC-PCTSUPP -0.009380705 0.4708428`\
`#> PCTGRT-PCTSUPP -0.115848356 0.3890535`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>                      2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.16368762 0.3654271`\
`#> NARTIC-PCTSUPP -0.01381962 0.4686904`\
`#> PCTGRT-PCTSUPP -0.10427383 0.4016354`

## References
