# betaNB: Example Using the SCorSqNB and FSqNB Functions

Confidence intervals for squared semipartial correlation coefficients
and Cohen’s f-squared are generated using the
[`SCorSqNB()`](https://jeksterslab.github.io/betaNB/reference/SCorSqNB.md)
and [`FSqNB()`](https://jeksterslab.github.io/betaNB/reference/FSqNB.md)
functions from the `betaNB` package. In this example, we use the data
set and the model used in [betaNB: Example Using the BetaNB
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

### Squared Semipartial Correlation Coefficients

The semipartial correlation is signed, and its interval may contain
zero.
[`SCorSqNB()`](https://jeksterslab.github.io/betaNB/reference/SCorSqNB.md)
returns the image of the signed interval under squaring. It is not the
interval of squared draws.

\
[`SCorSqNB`](https://jeksterslab.github.io/betaNB/reference/SCorSqNB.md)`(``nb``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>               est       lower     upper`\
`#> NARTIC  0.1858925 0.082411693 0.3112014`\
`#> PCTGRT  0.1176542 0.035773840 0.2227042`\
`#> PCTSUPP 0.0568722 0.009069136 0.1422231`

\
[`SCorSqNB`](https://jeksterslab.github.io/betaNB/reference/SCorSqNB.md)`(``nb``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>               est      lower     upper`\
`#> NARTIC  0.1858925 0.09880218 0.3458601`\
`#> PCTGRT  0.1176542 0.04839790 0.2555474`\
`#> PCTSUPP 0.0568722 0.01087751 0.1477837`

### Cohen’s f-Squared

\
`out`` ``<-`` `[`FSqNB`](https://jeksterslab.github.io/betaNB/reference/FSqNB.md)`(``nb``, alpha ``=`` ``0.05``)`

## Methods

### summary

\
[`summary`](https://rdrr.io/r/base/summary.html)`(``out``, type ``=`` ``"pc"``)`\
`#> Call:`\
`#> FSqNB(object = nb, alpha = 0.05)`\
`#> `\
`#> Cohen's f-squared (fsq) and local f-squared`\
`#> type = "pc"`\
`#>            est     se    R   2.5%  97.5%`\
`#> fsq     4.1158 1.7031 5000 2.2920 8.8835`\
`#> NARTIC  0.9510 0.4194 5000 0.4069 2.0198`\
`#> PCTGRT  0.6019 0.3047 5000 0.1868 1.3864`\
`#> PCTSUPP 0.2909 0.2356 5000 0.0451 0.9318`

### coef

\
[`coef`](https://rdrr.io/r/stats/coef.html)`(``out``)`\
`#>       fsq    NARTIC    PCTGRT   PCTSUPP `\
`#> 4.1157764 0.9509843 0.6018924 0.2909455`

### vcov

\
[`vcov`](https://rdrr.io/r/stats/vcov.html)`(``out``)`\
`#>               fsq     NARTIC     PCTGRT    PCTSUPP`\
`#> fsq     2.9006430 0.42206187 0.23180340 0.19583464`\
`#> NARTIC  0.4220619 0.17587401 0.02389228 0.01987918`\
`#> PCTGRT  0.2318034 0.02389228 0.09284154 0.00811116`\
`#> PCTSUPP 0.1958346 0.01987918 0.00811116 0.05551810`

### confint

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>              2.5 %    97.5 %`\
`#> fsq     2.29199444 8.8835238`\
`#> NARTIC  0.40687175 2.0198228`\
`#> PCTGRT  0.18680928 1.3863605`\
`#> PCTSUPP 0.04506402 0.9317684`

## References
