# betaNB: Example Using the SCorNB Function

Confidence intervals for semipartial correlation coefficients are
generated using the
[`SCorNB()`](https://github.com/jeksterslab/betaNB/reference/SCorNB.md)
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

### Semipartial Correlation Coefficients

#### Normal-Theory Approach

\
`out`` ``<-`` `[`SCorNB`](https://github.com/jeksterslab/betaNB/reference/SCorNB.md)`(``nb``, alpha ``=`` ``0.05``)`

## Methods

### summary

Summary of the results of
[`SCorNB()`](https://github.com/jeksterslab/betaNB/reference/SCorNB.md).

#### Percentile Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"pc"``)`\
`#> Call:`\
`#> SCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4312 0.0692 5000 0.2833 0.5574`\
`#> PCTGRT  0.3430 0.0720 5000 0.1907 0.4733`\
`#> PCTSUPP 0.2385 0.0713 5000 0.0947 0.3720`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> SCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4312 0.0692 5000 0.3015 0.5731`\
`#> PCTGRT  0.3430 0.0720 5000 0.2103 0.4909`\
`#> PCTSUPP 0.2385 0.0713 5000 0.1087 0.3816`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> SCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4312 0.0692 5000 0.3082 0.5836`\
`#> PCTGRT  0.3430 0.0720 5000 0.2197 0.5053`\
`#> PCTSUPP 0.2385 0.0713 5000 0.1045 0.3791`

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
`#> NARTIC   0.0047867734 -0.0003565799 -0.0005916037`\
`#> PCTGRT  -0.0003565799  0.0051781551 -0.0009233513`\
`#> PCTSUPP -0.0005916037 -0.0009233513  0.0050777365`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.28325807 0.5573940`\
`#> PCTGRT  0.19069593 0.4733461`\
`#> PCTSUPP 0.09472646 0.3720114`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>             2.5 %    97.5 %`\
`#> NARTIC  0.3015433 0.5731019`\
`#> PCTGRT  0.2103351 0.4908515`\
`#> PCTSUPP 0.1087177 0.3816243`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>             2.5 %    97.5 %`\
`#> NARTIC  0.3081655 0.5836466`\
`#> PCTGRT  0.2197401 0.5052926`\
`#> PCTSUPP 0.1045366 0.3790860`

## References
