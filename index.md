# betaNB

Ivan Jacob Agaloos Pesigan 2026-11-03

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
`#> NARTIC  0.4951 0.0708 5000 0.3581 0.6340`\
`#> PCTGRT  0.3915 0.0761 5000 0.2327 0.5361`\
`#> PCTSUPP 0.2632 0.0789 5000 0.1055 0.4147`

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
`#> rsq 0.8045 0.0525 5000 0.6968 0.8988`\
`#> adj 0.7906 0.0563 5000 0.6751 0.8916`

#### Improvement in R-squared

\
[`DeltaRSqNB`](https://github.com/jeksterslab/betaNB/reference/DeltaRSqNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> DeltaRSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Improvement in R-squared`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.1859 0.0583 5000 0.0827 0.3066`\
`#> PCTGRT  0.1177 0.0482 5000 0.0344 0.2204`\
`#> PCTSUPP 0.0569 0.0337 5000 0.0088 0.1376`

#### Semipartial Correlation Coefficients

\
[`SCorNB`](https://github.com/jeksterslab/betaNB/reference/SCorNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> SCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Semipartial correlations`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4312 0.0687 5000 0.2875 0.5537`\
`#> PCTGRT  0.3430 0.0725 5000 0.1854 0.4695`\
`#> PCTSUPP 0.2385 0.0706 5000 0.0940 0.3709`

#### Squared Partial Correlation Coefficients

\
[`PCorNB`](https://github.com/jeksterslab/betaNB/reference/PCorNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> PCorNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Squared partial correlations`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> NARTIC  0.4874 0.0971 5000 0.2908 0.6687`\
`#> PCTGRT  0.3757 0.1094 5000 0.1514 0.5862`\
`#> PCTSUPP 0.2254 0.1143 5000 0.0443 0.4758`

#### Differences of Standardized Regression Coefficients

\
[`DiffBetaNB`](https://github.com/jeksterslab/betaNB/reference/DiffBetaNB.md)`(``nb``, alpha ``=`` ``0.05``)`\
`#> Call:`\
`#> DiffBetaNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Differences of standardized regression slopes`\
`#> type = "pc"`\
`#>                   est     se    R    2.5%  97.5%`\
`#> NARTIC-PCTGRT  0.1037 0.1293 5000 -0.1413 0.3727`\
`#> NARTIC-PCTSUPP 0.2319 0.1229 5000 -0.0056 0.4772`\
`#> PCTGRT-PCTSUPP 0.1282 0.1266 5000 -0.1231 0.3776`

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
