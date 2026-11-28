# betaNB: Example Using the BetaNB Function

In this example, a multiple regression model is fitted using program
quality ratings (`QUALITY`) as the regressand/outcome variable and
number of published articles attributed to the program faculty members
(`NARTIC`), percent of faculty members holding research grants
(`PCTGRT`), and percentage of program graduates who received support
(`PCTSUPP`) as regressor/predictor variables using a data set from 1982
ratings of 46 doctoral programs in psychology in the USA (National
Research Council, 1982). Confidence intervals for the standardized
regression coefficients are generated using the
[`BetaNB()`](https://jeksterslab.github.io/betaNB/reference/BetaNB.md)
function from the `betaNB` package.

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

### Standardized Regression Slopes

\
`out`` ``<-`` `[`BetaNB`](https://jeksterslab.github.io/betaNB/reference/BetaNB.md)`(``nb``, alpha ``=`` ``0.05``)`

## Methods

### summary

Summary of the results of
[`BetaNB()`](https://jeksterslab.github.io/betaNB/reference/BetaNB.md).

#### Percentile Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"pc"``)`\
`#> Call:`\
`#> BetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Standardized regression slopes`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4951 0.0728 5000 0.3546 0.6418`\
`#> PCTGRT  0.3915 0.0770 5000 0.2334 0.5363`\
`#> PCTSUPP 0.2632 0.0791 5000 0.1056 0.4143`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> BetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Standardized regression slopes`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4951 0.0728 5000 0.3538 0.6410`\
`#> PCTGRT  0.3915 0.0770 5000 0.2406 0.5427`\
`#> PCTSUPP 0.2632 0.0791 5000 0.1094 0.4172`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> BetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Standardized regression slopes`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4951 0.0728 5000 0.3556 0.6434`\
`#> PCTGRT  0.3915 0.0770 5000 0.2468 0.5483`\
`#> PCTSUPP 0.2632 0.0791 5000 0.1021 0.4113`

### coef

Return the vector of estimates.

\
[`coef`](https://rdrr.io/r/stats/coef.html)`(``out``)`\
`#>    NARTIC    PCTGRT   PCTSUPP `\
`#> 0.4951451 0.3914887 0.2632477`

### vcov

Return the sampling covariance matrix.

\
[`vcov`](https://rdrr.io/r/stats/vcov.html)`(``out``)`\
`#>               NARTIC       PCTGRT      PCTSUPP`\
`#> NARTIC   0.005293709 -0.003204797 -0.001929048`\
`#> PCTGRT  -0.003204797  0.005925459 -0.001987607`\
`#> PCTSUPP -0.001929048 -0.001987607  0.006255415`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>             2.5 %    97.5 %`\
`#> NARTIC  0.3546494 0.6418119`\
`#> PCTGRT  0.2333524 0.5363251`\
`#> PCTSUPP 0.1055654 0.4142962`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>             2.5 %    97.5 %`\
`#> NARTIC  0.3537722 0.6409930`\
`#> PCTGRT  0.2405827 0.5426625`\
`#> PCTSUPP 0.1093636 0.4172256`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>             2.5 %    97.5 %`\
`#> NARTIC  0.3556038 0.6433745`\
`#> PCTGRT  0.2467674 0.5482974`\
`#> PCTSUPP 0.1020668 0.4112560`

## References
