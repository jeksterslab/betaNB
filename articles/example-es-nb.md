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
`#> NARTIC  0.1858925 0.080438689 0.3105943`\
`#> PCTGRT  0.1176542 0.034584025 0.2285978`\
`#> PCTSUPP 0.0568722 0.008298864 0.1398926`

\
[`SCorSqNB`](https://jeksterslab.github.io/betaNB/reference/SCorSqNB.md)`(``nb``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>               est      lower     upper`\
`#> NARTIC  0.1858925 0.09737757 0.3493904`\
`#> PCTGRT  0.1176542 0.04511864 0.2599959`\
`#> PCTSUPP 0.0568722 0.01015642 0.1489956`

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
`#> fsq     4.1158 1.6840 5000 2.2644 8.8613`\
`#> NARTIC  0.9510 0.4159 5000 0.3869 2.0035`\
`#> PCTGRT  0.6019 0.3078 5000 0.1896 1.3966`\
`#> PCTSUPP 0.2909 0.2252 5000 0.0407 0.9025`

### coef

\
[`coef`](https://rdrr.io/r/stats/coef.html)`(``out``)`\
`#>       fsq    NARTIC    PCTGRT   PCTSUPP `\
`#> 4.1157764 0.9509843 0.6018924 0.2909455`

### vcov

\
[`vcov`](https://rdrr.io/r/stats/vcov.html)`(``out``)`\
`#>               fsq     NARTIC      PCTGRT     PCTSUPP`\
`#> fsq     2.8359612 0.40445751 0.219829278 0.174776159`\
`#> NARTIC  0.4044575 0.17293975 0.019187956 0.018103941`\
`#> PCTGRT  0.2198293 0.01918796 0.094738219 0.005120764`\
`#> PCTSUPP 0.1747762 0.01810394 0.005120764 0.050730347`

### confint

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>              2.5 %    97.5 %`\
`#> fsq     2.26441931 8.8612607`\
`#> NARTIC  0.38689064 2.0034891`\
`#> PCTGRT  0.18960468 1.3965600`\
`#> PCTSUPP 0.04065716 0.9024703`

## References
