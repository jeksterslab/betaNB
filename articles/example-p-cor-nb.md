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
`#> NARTIC  0.4874 0.0981 5000 0.2836 0.6651`\
`#> PCTGRT  0.3757 0.1077 5000 0.1637 0.5806`\
`#> PCTSUPP 0.2254 0.1145 5000 0.0417 0.4746`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.0981 5000 0.2649 0.6552`\
`#> PCTGRT  0.3757 0.1077 5000 0.1603 0.5793`\
`#> PCTSUPP 0.2254 0.1145 5000 0.0398 0.4709`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.0981 5000 0.2650 0.6554`\
`#> PCTGRT  0.3757 0.1077 5000 0.1662 0.5833`\
`#> PCTSUPP 0.2254 0.1145 5000 0.0257 0.4474`

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
`#>              NARTIC       PCTGRT      PCTSUPP`\
`#> NARTIC  0.009621849 0.0014687177 0.0019856127`\
`#> PCTGRT  0.001468718 0.0116083533 0.0008845545`\
`#> PCTSUPP 0.001985613 0.0008845545 0.0131130157`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.28358920 0.6651477`\
`#> PCTGRT  0.16367201 0.5805595`\
`#> PCTSUPP 0.04171409 0.4745691`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.26491815 0.6552181`\
`#> PCTGRT  0.16031933 0.5792924`\
`#> PCTSUPP 0.03980544 0.4709424`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.26496579 0.6554007`\
`#> PCTGRT  0.16615269 0.5833382`\
`#> PCTSUPP 0.02568428 0.4473564`

## References
