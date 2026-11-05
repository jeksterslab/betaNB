# betaNB: Example Using the PCorNB Function

Confidence intervals for squared partial correlation coefficients are
generated using the
[`PCorNB()`](https://github.com/jeksterslab/betaNB/reference/PCorNB.md)
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

### Squared Partial Correlation Coefficients

#### Normal-Theory Approach

\
`out`` ``<-`` `[`PCorNB`](https://github.com/jeksterslab/betaNB/reference/PCorNB.md)`(``nb``, alpha ``=`` ``0.05``)`

## Methods

### summary

Summary of the results of
[`PCorNB()`](https://github.com/jeksterslab/betaNB/reference/PCorNB.md).

#### Percentile Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"pc"``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.0980 5000 0.2876 0.6658`\
`#> PCTGRT  0.3757 0.1078 5000 0.1600 0.5786`\
`#> PCTSUPP 0.2254 0.1156 5000 0.0397 0.4848`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.0980 5000 0.2834 0.6611`\
`#> PCTGRT  0.3757 0.1078 5000 0.1535 0.5725`\
`#> PCTSUPP 0.2254 0.1156 5000 0.0355 0.4803`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.0980 5000 0.2836 0.6611`\
`#> PCTGRT  0.3757 0.1078 5000 0.1590 0.5783`\
`#> PCTSUPP 0.2254 0.1156 5000 0.0226 0.4494`

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
`#> NARTIC  0.009610874 0.0015992540 0.0021467698`\
`#> PCTGRT  0.001599254 0.0116239548 0.0007927921`\
`#> PCTSUPP 0.002146770 0.0007927921 0.0133541607`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.28764346 0.6658493`\
`#> PCTGRT  0.15997469 0.5785834`\
`#> PCTSUPP 0.03966497 0.4848334`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.28343180 0.6610844`\
`#> PCTGRT  0.15348157 0.5724949`\
`#> PCTSUPP 0.03552331 0.4803352`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>             2.5 %    97.5 %`\
`#> NARTIC  0.2836102 0.6611155`\
`#> PCTGRT  0.1590055 0.5783000`\
`#> PCTSUPP 0.0226223 0.4494068`

## References
