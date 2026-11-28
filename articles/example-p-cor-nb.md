# betaNB: Example Using the PCorNB Function

Confidence intervals for squared partial correlation coefficients are
generated using the
[`PCorNB()`](https://jeksterslab.github.io/betaNB/reference/PCorNB.md)
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

### Squared Partial Correlation Coefficients

#### Normal-Theory Approach

\
`out`` ``<-`` `[`PCorNB`](https://jeksterslab.github.io/betaNB/reference/PCorNB.md)`(``nb``, alpha ``=`` ``0.05``)`

## Methods

### summary

Summary of the results of
[`PCorNB()`](https://jeksterslab.github.io/betaNB/reference/PCorNB.md).

#### Percentile Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"pc"``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.0993 5000 0.2775 0.6694`\
`#> PCTGRT  0.3757 0.1069 5000 0.1597 0.5794`\
`#> PCTSUPP 0.2254 0.1167 5000 0.0387 0.4852`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.0993 5000 0.2606 0.6566`\
`#> PCTGRT  0.3757 0.1069 5000 0.1597 0.5794`\
`#> PCTSUPP 0.2254 0.1167 5000 0.0385 0.4850`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.0993 5000 0.2609 0.6570`\
`#> PCTGRT  0.3757 0.1069 5000 0.1684 0.5835`\
`#> PCTSUPP 0.2254 0.1167 5000 0.0248 0.4591`

### coef

Return the vector of estimates.

\
[`coef`](https://rdrr.io/r/stats/coef.html)`(``out``)`\
`#>    NARTIC    PCTGRT   PCTSUPP `\
`#> 0.4874382 0.3757383 0.2253739`

### vcov

Return the sampling covariance matrix.

\
[`vcov`](https://rdrr.io/r/stats/vcov.html)`(``out``)`\
`#>              NARTIC      PCTGRT     PCTSUPP`\
`#> NARTIC  0.009865941 0.001417399 0.002080690`\
`#> PCTGRT  0.001417399 0.011437691 0.000822264`\
`#> PCTSUPP 0.002080690 0.000822264 0.013610368`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.27754010 0.6693908`\
`#> PCTGRT  0.15965571 0.5793990`\
`#> PCTSUPP 0.03866216 0.4851568`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.26063285 0.6566008`\
`#> PCTGRT  0.15971650 0.5794289`\
`#> PCTSUPP 0.03850854 0.4849502`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.26086782 0.6570024`\
`#> PCTGRT  0.16843023 0.5835025`\
`#> PCTSUPP 0.02481129 0.4590536`

## References
