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
`#> NARTIC  0.4874 0.0996 5000 0.2772 0.6688`\
`#> PCTGRT  0.3757 0.1087 5000 0.1617 0.5817`\
`#> PCTSUPP 0.2254 0.1157 5000 0.0444 0.4796`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.0996 5000 0.2627 0.6617`\
`#> PCTGRT  0.3757 0.1087 5000 0.1517 0.5741`\
`#> PCTSUPP 0.2254 0.1157 5000 0.0445 0.4800`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.0996 5000 0.2632 0.6618`\
`#> PCTGRT  0.3757 0.1087 5000 0.1593 0.5804`\
`#> PCTSUPP 0.2254 0.1157 5000 0.0301 0.4574`

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
`#> NARTIC  0.009918354 0.001479621 0.002178278`\
`#> PCTGRT  0.001479621 0.011823656 0.000917660`\
`#> PCTSUPP 0.002178278 0.000917660 0.013392361`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.27719154 0.6687761`\
`#> PCTGRT  0.16172507 0.5816869`\
`#> PCTSUPP 0.04435464 0.4796155`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.26271671 0.6616906`\
`#> PCTGRT  0.15169646 0.5741481`\
`#> PCTSUPP 0.04452062 0.4799767`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.26320496 0.6618008`\
`#> PCTGRT  0.15934661 0.5804485`\
`#> PCTSUPP 0.03012488 0.4573699`

## References
