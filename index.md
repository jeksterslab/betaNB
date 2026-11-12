# betaNB

Ivan Jacob Agaloos Pesigan 2026-11-12

## Description

Generates nonparametric bootstrap confidence intervals (Efron &
Tibshirani, 1993: <https://doi.org/10.1201/9780429246593>) for
standardized regression coefficients (beta) and other effect sizes,
including multiple correlation, semipartial correlations, improvement in
R-squared, squared partial correlations, and differences in standardized
regression coefficients, for models fitted by
[`lm()`](https://rdrr.io/r/stats/lm.html).

## Installation

You can install the CRAN release of `betaNB` with:

\
[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(``"betaNB"``)`

You can install the development version of `betaNB` from
[GitHub](https://github.com/jeksterslab/betaNB) with:

\
`if`` ``(``!`[`require`](https://rdrr.io/r/base/library.html)`(`[`"pak"`](https://pak.r-lib.org/)`)``)`` `[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(``"pak"``)`\
`pak``::`[`pkg_install`](https://pak.r-lib.org/reference/pkg_install.html)`(``"jeksterslab/betaNB"``)`

## Example

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
[`BetaNB`](https://jeksterslab.github.io/betaNB/reference/BetaNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> BetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Standardized regression slopes`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4951 0.0725 5000 0.3526 0.6365`\
`#> PCTGRT  0.3915 0.0775 5000 0.2333 0.5380`\
`#> PCTSUPP 0.2632 0.0774 5000 0.1049 0.4123`

### Other Effect Sizes

The `betaNB` package also has functions to generate nonparametric
bootstrap confidence intervals for other effect sizes such as
[`RSqNB()`](https://jeksterslab.github.io/betaNB/reference/RSqNB.md) for
multiple correlation coefficients (R-squared and adjusted R-squared),
[`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md)
for improvement in R-squared,
[`SCorNB()`](https://jeksterslab.github.io/betaNB/reference/SCorNB.md)
for semipartial correlation coefficients,
[`PCorNB()`](https://jeksterslab.github.io/betaNB/reference/PCorNB.md)
for squared partial correlation coefficients, and
[`DiffBetaNB()`](https://jeksterslab.github.io/betaNB/reference/DiffBetaNB.md)
for differences of standardized regression coefficients.

#### Multiple Correlation Coefficients (R-squared and adjusted R-squared)

\
[`RSqNB`](https://jeksterslab.github.io/betaNB/reference/RSqNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> RSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> R-squared and adjusted R-squared`\
`#> type = "pc"`\
`#>        est     se    R   2.5%  97.5%`\
`#> rsq 0.8045 0.0530 5000 0.6896 0.8966`\
`#> adj 0.7906 0.0567 5000 0.6675 0.8892`

#### Improvement in R-squared

\
[`DeltaRSqNB`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> DeltaRSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Improvement in R-squared`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.1859 0.0587 5000 0.0791 0.3124`\
`#> PCTGRT  0.1177 0.0493 5000 0.0349 0.2272`\
`#> PCTSUPP 0.0569 0.0328 5000 0.0089 0.1374`

#### Semipartial Correlation Coefficients

\
[`SCorNB`](https://jeksterslab.github.io/betaNB/reference/SCorNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> SCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4312 0.0695 5000 0.2813 0.5590`\
`#> PCTGRT  0.3430 0.0733 5000 0.1868 0.4766`\
`#> PCTSUPP 0.2385 0.0691 5000 0.0943 0.3707`

#### Squared Partial Correlation Coefficients

\
[`PCorNB`](https://jeksterslab.github.io/betaNB/reference/PCorNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.1003 5000 0.2759 0.6672`\
`#> PCTGRT  0.3757 0.1076 5000 0.1597 0.5777`\
`#> PCTSUPP 0.2254 0.1123 5000 0.0420 0.4730`

#### Differences of Standardized Regression Coefficients

\
[`DiffBetaNB`](https://jeksterslab.github.io/betaNB/reference/DiffBetaNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "pc"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1330 5000 -0.1672 0.3702`\
`#> NARTIC-PCTSUPP 0.2319 0.1217 5000 -0.0084 0.4784`\
`#> PCTGRT-PCTSUPP 0.1282 0.1267 5000 -0.1188 0.3853`

## Documentation

See [GitHub Pages](https://jeksterslab.github.io/betaNB/index.html) for
package documentation.

## References

Efron, B., & Tibshirani, R. J. (1993). *An introduction to the
bootstrap*. Chapman & Hall. <https://doi.org/10.1201/9780429246593>

National Research Council. (1982). *An assessment of research-doctorate
programs in the United States: Social and behavioral sciences*. National
Academies Press. <https://doi.org/10.17226/9781>

Pesigan, I. J. A. (2022). *Confidence intervals for standardized
coefficients: Applied to regression coefficients in primary studies and
indirect effects in meta-analytic structural equation modeling* \[PhD
thesis\]. University of Macau.

R Core Team. (2026). *R: A language and environment for statistical
computing*. R Foundation for Statistical Computing.
<https://www.R-project.org/>
