# betaNB: Example Using the SCorNB Function

Confidence intervals for semipartial correlation coefficients are
generated using the
[`SCorNB()`](https://jeksterslab.github.io/betaNB/reference/SCorNB.md)
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

### Semipartial Correlation Coefficients

#### Normal-Theory Approach

\
`out`` ``<-`` `[`SCorNB`](https://jeksterslab.github.io/betaNB/reference/SCorNB.md)`(``nb``, alpha ``=`` ``0.05``)`

## Methods

### summary

Summary of the results of
[`SCorNB()`](https://jeksterslab.github.io/betaNB/reference/SCorNB.md).

#### Percentile Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"pc"``)`\
`#> Call:`\
`#> SCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4312 0.0704 5000 0.2877 0.5605`\
`#> PCTGRT  0.3430 0.0727 5000 0.1904 0.4785`\
`#> PCTSUPP 0.2385 0.0709 5000 0.0908 0.3692`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> SCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4312 0.0704 5000 0.3027 0.5793`\
`#> PCTGRT  0.3430 0.0727 5000 0.2112 0.4941`\
`#> PCTSUPP 0.2385 0.0709 5000 0.1026 0.3816`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> SCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4312 0.0704 5000 0.3078 0.5904`\
`#> PCTGRT  0.3430 0.0727 5000 0.2185 0.5095`\
`#> PCTSUPP 0.2385 0.0709 5000 0.0996 0.3782`

### coef

Return the vector of estimates.

\
[`coef`](https://rdrr.io/r/stats/coef.html)`(``out``)`\
`#>    NARTIC    PCTGRT   PCTSUPP `\
`#> 0.4311525 0.3430075 0.2384789`

### vcov

Return the sampling covariance matrix.

\
[`vcov`](https://rdrr.io/r/stats/vcov.html)`(``out``)`\
`#>                NARTIC        PCTGRT       PCTSUPP`\
`#> NARTIC   0.0049566800 -0.0002301456 -0.0008082589`\
`#> PCTGRT  -0.0002301456  0.0052924991 -0.0008839620`\
`#> PCTSUPP -0.0008082589 -0.0008839620  0.0050330611`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.28771915 0.5605077`\
`#> PCTGRT  0.19043617 0.4785352`\
`#> PCTSUPP 0.09081079 0.3691979`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>             2.5 %    97.5 %`\
`#> NARTIC  0.3026770 0.5792892`\
`#> PCTGRT  0.2112431 0.4940662`\
`#> PCTSUPP 0.1025558 0.3816292`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.30784465 0.5903610`\
`#> PCTGRT  0.21850164 0.5094638`\
`#> PCTSUPP 0.09964078 0.3781765`

## References
