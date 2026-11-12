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
`#> rsq 0.8045 0.0516 5000 0.6955 0.8962`\
`#> adj 0.7906 0.0553 5000 0.6737 0.8888`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> RSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> R-squared and adjusted R-squared`\
`#> type = "bc"`\
`#>        est     se    R   2.5%  97.5%`\
`#> rsq 0.8045 0.0516 5000 0.6548 0.8788`\
`#> adj 0.7906 0.0553 5000 0.6301 0.8702`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> RSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> R-squared and adjusted R-squared`\
`#> type = "bca"`\
`#>        est     se    R   2.5%  97.5%`\
`#> rsq 0.8045 0.0516 5000 0.6489 0.8774`\
`#> adj 0.7906 0.0553 5000 0.6238 0.8687`

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
`#> rsq 0.002659344 0.002849297`\
`#> adj 0.002849297 0.003052818`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>         2.5 %    97.5 %`\
`#> rsq 0.6954873 0.8962418`\
`#> adj 0.6737364 0.8888305`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>         2.5 %    97.5 %`\
`#> rsq 0.6547527 0.8788281`\
`#> adj 0.6300921 0.8701730`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>         2.5 %    97.5 %`\
`#> rsq 0.6488777 0.8774297`\
`#> adj 0.6237975 0.8686747`

## References
