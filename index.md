# betaNB

Ivan Jacob Agaloos Pesigan 2026-11-02

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
[`BetaNB()`](https://github.com/jeksterslab/betaNB/reference/BetaNB.md)
function from the `betaNB` package.

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

### Standardized Regression Slopes

\
[`BetaNB`](https://github.com/jeksterslab/betaNB/reference/BetaNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> BetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Standardized regression slopes`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4951 0.0734 5000 0.3491 0.6415`\
`#> PCTGRT  0.3915 0.0766 5000 0.2294 0.5322`\
`#> PCTSUPP 0.2632 0.0790 5000 0.1102 0.4154`

### Other Effect Sizes

The `betaNB` package also has functions to generate nonparametric
bootstrap confidence intervals for other effect sizes such as
[`RSqNB()`](https://github.com/jeksterslab/betaNB/reference/RSqNB.md)
for multiple correlation coefficients (R-squared and adjusted
R-squared),
[`DeltaRSqNB()`](https://github.com/jeksterslab/betaNB/reference/DeltaRSqNB.md)
for improvement in R-squared,
[`SCorNB()`](https://github.com/jeksterslab/betaNB/reference/SCorNB.md)
for semipartial correlation coefficients,
[`PCorNB()`](https://github.com/jeksterslab/betaNB/reference/PCorNB.md)
for squared partial correlation coefficients, and
[`DiffBetaNB()`](https://github.com/jeksterslab/betaNB/reference/DiffBetaNB.md)
for differences of standardized regression coefficients.

#### Multiple Correlation Coefficients (R-squared and adjusted R-squared)

\
[`RSqNB`](https://github.com/jeksterslab/betaNB/reference/RSqNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> RSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> R-squared and adjusted R-squared`\
`#> type = "pc"`\
`#>        est     se    R   2.5%  97.5%`\
`#> rsq 0.8045 0.0538 5000 0.6869 0.8976`\
`#> adj 0.7906 0.0576 5000 0.6645 0.8903`

#### Improvement in R-squared

\
[`DeltaRSqNB`](https://github.com/jeksterslab/betaNB/reference/DeltaRSqNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> DeltaRSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Improvement in R-squared`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.1859 0.0604 5000 0.0784 0.3154`\
`#> PCTGRT  0.1177 0.0478 5000 0.0335 0.2218`\
`#> PCTSUPP 0.0569 0.0342 5000 0.0094 0.1418`

#### Semipartial Correlation Coefficients

\
[`SCorNB`](https://github.com/jeksterslab/betaNB/reference/SCorNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> SCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations`\
`#> type = "pc"`\
`#>            est     se    R  2.5%  97.5%`\
`#> NARTIC  0.4312 0.0710 5000 0.280 0.5616`\
`#> PCTGRT  0.3430 0.0724 5000 0.183 0.4710`\
`#> PCTSUPP 0.2385 0.0710 5000 0.097 0.3766`

#### Squared Partial Correlation Coefficients

\
[`PCorNB`](https://github.com/jeksterslab/betaNB/reference/PCorNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.1004 5000 0.2772 0.6701`\
`#> PCTGRT  0.3757 0.1095 5000 0.1532 0.5802`\
`#> PCTSUPP 0.2254 0.1148 5000 0.0434 0.4865`

#### Differences of Standardized Regression Coefficients

\
[`DiffBetaNB`](https://github.com/jeksterslab/betaNB/reference/DiffBetaNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "pc"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1330 5000 -0.1512 0.3788`\
`#> NARTIC-PCTSUPP 0.2319 0.1248 5000 -0.0152 0.4814`\
`#> PCTGRT-PCTSUPP 0.1282 0.1261 5000 -0.1190 0.3728`

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
