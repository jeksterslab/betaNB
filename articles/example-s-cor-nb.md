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
`#> NARTIC  0.4312 0.0684 5000 0.2859 0.5575`\
`#> PCTGRT  0.3430 0.0733 5000 0.1902 0.4754`\
`#> PCTSUPP 0.2385 0.0715 5000 0.0897 0.3681`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> SCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4312 0.0684 5000 0.3026 0.5717`\
`#> PCTGRT  0.3430 0.0733 5000 0.2069 0.4930`\
`#> PCTSUPP 0.2385 0.0715 5000 0.1001 0.3812`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> SCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4312 0.0684 5000 0.3094 0.5805`\
`#> PCTGRT  0.3430 0.0733 5000 0.2153 0.5054`\
`#> PCTSUPP 0.2385 0.0715 5000 0.0978 0.3768`

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
`#> NARTIC   0.0046759521 -0.0005074545 -0.0006763038`\
`#> PCTGRT  -0.0005074545  0.0053789263 -0.0009320692`\
`#> PCTSUPP -0.0006763038 -0.0009320692  0.0051184271`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.28585789 0.5575092`\
`#> PCTGRT  0.19020554 0.4754343`\
`#> PCTSUPP 0.08970998 0.3680668`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>             2.5 %    97.5 %`\
`#> NARTIC  0.3025829 0.5716655`\
`#> PCTGRT  0.2069407 0.4929728`\
`#> PCTSUPP 0.1001388 0.3812300`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.30942865 0.5804534`\
`#> PCTGRT  0.21527033 0.5054280`\
`#> PCTSUPP 0.09782769 0.3768286`

## References
