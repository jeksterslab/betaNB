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
`#> NARTIC  0.1858925 0.081779071 0.3102292`\
`#> PCTGRT  0.1176542 0.035848129 0.2295359`\
`#> PCTSUPP 0.0568722 0.008977197 0.1373962`

\
[`SCorSqNB`](https://jeksterslab.github.io/betaNB/reference/SCorSqNB.md)`(``nb``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>               est      lower     upper`\
`#> NARTIC  0.1858925 0.09826801 0.3444725`\
`#> PCTGRT  0.1176542 0.04754351 0.2537687`\
`#> PCTSUPP 0.0568722 0.01003975 0.1414209`

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
`#> fsq     4.1158 1.7002 5000 2.2591 8.8989`\
`#> NARTIC  0.9510 0.4155 5000 0.3952 2.0057`\
`#> PCTGRT  0.6019 0.3074 5000 0.1927 1.3935`\
`#> PCTSUPP 0.2909 0.2316 5000 0.0461 0.9042`

### coef

\
[`coef`](https://rdrr.io/r/stats/coef.html)`(``out``)`\
`#>       fsq    NARTIC    PCTGRT   PCTSUPP `\
`#> 4.1157764 0.9509843 0.6018924 0.2909455`

### vcov

\
[`vcov`](https://rdrr.io/r/stats/vcov.html)`(``out``)`\
`#>               fsq     NARTIC      PCTGRT     PCTSUPP`\
`#> fsq     2.8908471 0.41582288 0.229330368 0.194964683`\
`#> NARTIC  0.4158229 0.17262383 0.022991454 0.019732188`\
`#> PCTGRT  0.2293304 0.02299145 0.094513844 0.007536216`\
`#> PCTSUPP 0.1949647 0.01973219 0.007536216 0.053622961`

### confint

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>              2.5 %    97.5 %`\
`#> fsq     2.25911568 8.8988562`\
`#> NARTIC  0.39519876 2.0057075`\
`#> PCTGRT  0.19274303 1.3935482`\
`#> PCTSUPP 0.04607269 0.9042489`

## References
