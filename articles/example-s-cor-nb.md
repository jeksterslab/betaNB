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
`#> NARTIC  0.4312 0.0684 5000 0.2877 0.5543`\
`#> PCTGRT  0.3430 0.0729 5000 0.1887 0.4780`\
`#> PCTSUPP 0.2385 0.0712 5000 0.0958 0.3716`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> SCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4312 0.0684 5000 0.3053 0.5745`\
`#> PCTGRT  0.3430 0.0729 5000 0.2104 0.4965`\
`#> PCTSUPP 0.2385 0.0712 5000 0.1090 0.3881`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> SCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4312 0.0684 5000 0.3118 0.5829`\
`#> PCTGRT  0.3430 0.0729 5000 0.2214 0.5095`\
`#> PCTSUPP 0.2385 0.0712 5000 0.1049 0.3857`

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
`#> NARTIC   0.0046725125 -0.0003608861 -0.0007070786`\
`#> PCTGRT  -0.0003608861  0.0053152439 -0.0008141175`\
`#> PCTSUPP -0.0007070786 -0.0008141175  0.0050728230`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>             2.5 %    97.5 %`\
`#> NARTIC  0.2877079 0.5543371`\
`#> PCTGRT  0.1886911 0.4780424`\
`#> PCTSUPP 0.0958432 0.3716110`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>             2.5 %    97.5 %`\
`#> NARTIC  0.3052635 0.5745025`\
`#> PCTGRT  0.2103651 0.4964507`\
`#> PCTSUPP 0.1089672 0.3881453`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>             2.5 %    97.5 %`\
`#> NARTIC  0.3118278 0.5829252`\
`#> PCTGRT  0.2214295 0.5095210`\
`#> PCTSUPP 0.1048587 0.3856522`

## References
