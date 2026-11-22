# betaNB: Example Using the RSqNB Function

Confidence intervals for multiple correlation coefficients are generated
using the
[`RSqNB()`](https://jeksterslab.github.io/betaNB/reference/RSqNB.md)
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

### Multiple Correlation Coefficients

#### Normal-Theory Approach

\
`out`` ``<-`` `[`RSqNB`](https://jeksterslab.github.io/betaNB/reference/RSqNB.md)`(``nb``, alpha ``=`` ``0.05``)`

## Methods

### summary

Summary of the results of
[`RSqNB()`](https://jeksterslab.github.io/betaNB/reference/RSqNB.md).

#### Percentile Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"pc"``)`\
`#> Call:`\
`#> RSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> R-squared and adjusted R-squared`\
`#> type = "pc"`\
`#>        est     se    R   2.5%  97.5%`\
`#> rsq 0.8045 0.0529 5000 0.6879 0.8965`\
`#> adj 0.7906 0.0566 5000 0.6656 0.8891`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> RSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> R-squared and adjusted R-squared`\
`#> type = "bc"`\
`#>        est     se    R   2.5%  97.5%`\
`#> rsq 0.8045 0.0529 5000 0.6594 0.8807`\
`#> adj 0.7906 0.0566 5000 0.6351 0.8721`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> RSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> R-squared and adjusted R-squared`\
`#> type = "bca"`\
`#>        est     se    R   2.5%  97.5%`\
`#> rsq 0.8045 0.0529 5000 0.6529 0.8787`\
`#> adj 0.7906 0.0566 5000 0.6281 0.8701`

### coef

Return the vector of estimates.

\
[`coef`](https://rdrr.io/r/stats/coef.html)`(``out``)`\
`#>       rsq       adj `\
`#> 0.8045263 0.7905638`

### vcov

Return the sampling covariance matrix.

\
[`vcov`](https://rdrr.io/r/stats/vcov.html)`(``out``)`\
`#>             rsq         adj`\
`#> rsq 0.002795241 0.002994901`\
`#> adj 0.002994901 0.003208822`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>         2.5 %    97.5 %`\
`#> rsq 0.6878720 0.8965384`\
`#> adj 0.6655771 0.8891483`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>         2.5 %    97.5 %`\
`#> rsq 0.6594060 0.8806705`\
`#> adj 0.6350779 0.8721470`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>         2.5 %   97.5 %`\
`#> rsq 0.6528503 0.878746`\
`#> adj 0.6280539 0.870085`

## References
