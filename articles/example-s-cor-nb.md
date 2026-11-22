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
`#> NARTIC  0.4312 0.0702 5000 0.2844 0.5604`\
`#> PCTGRT  0.3430 0.0721 5000 0.1876 0.4710`\
`#> PCTSUPP 0.2385 0.0724 5000 0.0892 0.3750`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> SCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4312 0.0702 5000 0.3054 0.5793`\
`#> PCTGRT  0.3430 0.0721 5000 0.2054 0.4870`\
`#> PCTSUPP 0.2385 0.0724 5000 0.1003 0.3850`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> SCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4312 0.0702 5000 0.3113 0.5874`\
`#> PCTGRT  0.3430 0.0721 5000 0.2161 0.5039`\
`#> PCTSUPP 0.2385 0.0724 5000 0.0971 0.3821`

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
`#> NARTIC   0.0049219980 -0.0003197695 -0.0007308093`\
`#> PCTGRT  -0.0003197695  0.0052017943 -0.0008627581`\
`#> PCTSUPP -0.0007308093 -0.0008627581  0.0052451624`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.28437676 0.5603684`\
`#> PCTGRT  0.18755043 0.4709647`\
`#> PCTSUPP 0.08921711 0.3749528`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>             2.5 %    97.5 %`\
`#> NARTIC  0.3053953 0.5792861`\
`#> PCTGRT  0.2053512 0.4869654`\
`#> PCTSUPP 0.1002655 0.3849823`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.31130987 0.5874072`\
`#> PCTGRT  0.21606960 0.5039130`\
`#> PCTSUPP 0.09712493 0.3820831`

## References
