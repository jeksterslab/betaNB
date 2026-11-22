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
`#> NARTIC  0.1858925 0.082959919 0.3136795`\
`#> PCTGRT  0.1176542 0.035421898 0.2232690`\
`#> PCTSUPP 0.0568722 0.008529185 0.1402788`

\
[`SCorSqNB`](https://jeksterslab.github.io/betaNB/reference/SCorSqNB.md)`(``nb``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>               est       lower     upper`\
`#> NARTIC  0.1858925 0.099694670 0.3481583`\
`#> PCTGRT  0.1176542 0.049531852 0.2605634`\
`#> PCTSUPP 0.0568722 0.009692286 0.1432379`

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
`#> fsq     4.1158 1.6860 5000 2.2897 8.8114`\
`#> NARTIC  0.9510 0.4165 5000 0.4085 1.9907`\
`#> PCTGRT  0.6019 0.3160 5000 0.1858 1.4233`\
`#> PCTSUPP 0.2909 0.2345 5000 0.0427 0.9370`

### coef

\
[`coef`](https://rdrr.io/r/stats/coef.html)`(``out``)`\
`#>       fsq    NARTIC    PCTGRT   PCTSUPP `\
`#> 4.1157764 0.9509843 0.6018924 0.2909455`

### vcov

\
[`vcov`](https://rdrr.io/r/stats/vcov.html)`(``out``)`\
`#>               fsq     NARTIC      PCTGRT     PCTSUPP`\
`#> fsq     2.8424703 0.40331063 0.250780103 0.193557017`\
`#> NARTIC  0.4033106 0.17349801 0.028844724 0.018107743`\
`#> PCTGRT  0.2507801 0.02884472 0.099832543 0.008505101`\
`#> PCTSUPP 0.1935570 0.01810774 0.008505101 0.054999188`

### confint

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>              2.5 %    97.5 %`\
`#> fsq     2.28967844 8.8114241`\
`#> NARTIC  0.40848620 1.9906696`\
`#> PCTGRT  0.18575286 1.4233166`\
`#> PCTSUPP 0.04272224 0.9369961`

## References
