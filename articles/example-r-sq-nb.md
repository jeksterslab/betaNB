# betaNB: Example Using the RSqNB Function

Confidence intervals for multiple correlation coefficients are generated
using the
[`RSqNB()`](https://github.com/jeksterslab/betaNB/reference/RSqNB.md)
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

### Multiple Correlation Coefficients

#### Normal-Theory Approach

\
`out`` ``<-`` `[`RSqNB`](https://github.com/jeksterslab/betaNB/reference/RSqNB.md)`(``nb``, alpha ``=`` ``0.05``)`

## Methods

### summary

Summary of the results of
[`RSqNB()`](https://github.com/jeksterslab/betaNB/reference/RSqNB.md).

#### Percentile Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"pc"``)`\
`#> Call:`\
`#> RSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> R-squared and adjusted R-squared`\
`#> type = "pc"`\
`#>        est     se    R   2.5%  97.5%`\
`#> rsq 0.8045 0.0518 5000 0.6978 0.8982`\
`#> adj 0.7906 0.0555 5000 0.6763 0.8909`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> RSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> R-squared and adjusted R-squared`\
`#> type = "bc"`\
`#>        est     se    R   2.5%  97.5%`\
`#> rsq 0.8045 0.0518 5000 0.6609 0.8823`\
`#> adj 0.7906 0.0555 5000 0.6366 0.8739`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> RSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> R-squared and adjusted R-squared`\
`#> type = "bca"`\
`#>        est     se    R   2.5%  97.5%`\
`#> rsq 0.8045 0.0518 5000 0.6556 0.8807`\
`#> adj 0.7906 0.0555 5000 0.6310 0.8721`

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
`#> rsq 0.002681641 0.002873187`\
`#> adj 0.002873187 0.003078415`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>         2.5 %    97.5 %`\
`#> rsq 0.6978420 0.8981838`\
`#> adj 0.6762593 0.8909112`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>         2.5 %    97.5 %`\
`#> rsq 0.6608614 0.8823435`\
`#> adj 0.6366372 0.8739394`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>         2.5 %    97.5 %`\
`#> rsq 0.6555765 0.8806510`\
`#> adj 0.6309749 0.8721261`

## References
