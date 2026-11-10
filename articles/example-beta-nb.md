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
`#> NARTIC  0.4951 0.0733 5000 0.3505 0.6392`\
`#> PCTGRT  0.3915 0.0766 5000 0.2373 0.5373`\
`#> PCTSUPP 0.2632 0.0792 5000 0.1063 0.4163`

#### Bias Corrected Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bc"``)`\
`#> Call:`\
`#> BetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Standardized regression slopes`\
`#> type = "bc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4951 0.0733 5000 0.3500 0.6383`\
`#> PCTGRT  0.3915 0.0766 5000 0.2462 0.5435`\
`#> PCTSUPP 0.2632 0.0792 5000 0.1048 0.4156`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"bca"``)`\
`#> Call:`\
`#> BetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Standardized regression slopes`\
`#> type = "bca"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4951 0.0733 5000 0.3530 0.6399`\
`#> PCTGRT  0.3915 0.0766 5000 0.2507 0.5509`\
`#> PCTSUPP 0.2632 0.0792 5000 0.0975 0.4089`

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
`#> NARTIC   0.005379509 -0.003143621 -0.001989448`\
`#> PCTGRT  -0.003143621  0.005866119 -0.001980730`\
`#> PCTSUPP -0.001989448 -0.001980730  0.006266760`

### confint

Return confidence intervals.

#### Percentile Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>             2.5 %    97.5 %`\
`#> NARTIC  0.3504857 0.6392025`\
`#> PCTGRT  0.2372516 0.5372715`\
`#> PCTSUPP 0.1063457 0.4162688`

#### Bias Corrected Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bc"``)`\
`#>             2.5 %    97.5 %`\
`#> NARTIC  0.3500199 0.6382554`\
`#> PCTGRT  0.2462377 0.5434775`\
`#> PCTSUPP 0.1048008 0.4155996`

#### Bias Corrected and Accelerated Confidence Intervals

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>              2.5 %    97.5 %`\
`#> NARTIC  0.35297457 0.6399337`\
`#> PCTGRT  0.25067038 0.5509275`\
`#> PCTSUPP 0.09748271 0.4089434`

## References
