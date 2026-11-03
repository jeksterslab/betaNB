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
`#> NARTIC-PCTGRT  0.1037 0.1322 5000 -0.1408 0.3703`\
`#> NARTIC-PCTSUPP 0.2319 0.1255 5000 -0.0074 0.4865`\
`#> PCTGRT-PCTSUPP 0.1282 0.1264 5000 -0.1177 0.3810`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "bc"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1322 5000 -0.1529 0.3575`\
`#> NARTIC-PCTSUPP 0.2319 0.1255 5000 -0.0142 0.4768`\
`#> PCTGRT-PCTSUPP 0.1282 0.1264 5000 -0.1123 0.3867`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "bca"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1322 5000 -0.1536 0.3561`\
`#> NARTIC-PCTSUPP 0.2319 0.1255 5000 -0.0154 0.4732`\
`#> PCTGRT-PCTSUPP 0.1282 0.1264 5000 -0.1011 0.3974`

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
`#> NARTIC-PCTGRT    0.017472406    0.008622858   -0.008849549`\
`#> NARTIC-PCTSUPP   0.008622858    0.015748176    0.007125318`\
`#> PCTGRT-PCTSUPP  -0.008849549    0.007125318    0.015974867`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>                       2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.140781936 0.3702732`\
`#> NARTIC-PCTSUPP -0.007364895 0.4865448`\
`#> PCTGRT-PCTSUPP -0.117662308 0.3810307`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>                      2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.15292113 0.3574715`\
`#> NARTIC-PCTSUPP -0.01423135 0.4768297`\
`#> PCTGRT-PCTSUPP -0.11227009 0.3867032`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>                     2.5 %    97.5 %`\
`#> NARTIC-PCTGRT  -0.1535990 0.3560805`\
`#> NARTIC-PCTSUPP -0.0153819 0.4731893`\
`#> PCTGRT-PCTSUPP -0.1011104 0.3973664`

## References
