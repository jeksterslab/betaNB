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
`#> NARTIC  0.1858925 0.079253659 0.3157368`\
`#> PCTGRT  0.1176542 0.034955539 0.2266848`\
`#> PCTSUPP 0.0568722 0.008182843 0.1400833`

\
[`SCorSqNB`](https://jeksterslab.github.io/betaNB/reference/SCorSqNB.md)`(``nb``, level ``=`` ``0.95``, type ``=`` ``"bca"``)`\
`#>               est      lower     upper`\
`#> NARTIC  0.1858925 0.09695774 0.3578561`\
`#> PCTGRT  0.1176542 0.05018211 0.2660623`\
`#> PCTSUPP 0.0568722 0.01030343 0.1471063`

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
`#> fsq     4.1158 1.6723 5000 2.3363 8.8333`\
`#> NARTIC  0.9510 0.4172 5000 0.4038 1.9950`\
`#> PCTGRT  0.6019 0.3078 5000 0.1879 1.3668`\
`#> PCTSUPP 0.2909 0.2351 5000 0.0422 0.9193`

### coef

\
[`coef`](https://rdrr.io/r/stats/coef.html)`(``out``)`\
`#>       fsq    NARTIC    PCTGRT   PCTSUPP `\
`#> 4.1157764 0.9509843 0.6018924 0.2909455`

### vcov

\
[`vcov`](https://rdrr.io/r/stats/vcov.html)`(``out``)`\
`#>               fsq     NARTIC      PCTGRT     PCTSUPP`\
`#> fsq     2.7965017 0.39964466 0.225417051 0.191258717`\
`#> NARTIC  0.3996447 0.17409483 0.024065943 0.018209997`\
`#> PCTGRT  0.2254171 0.02406594 0.094759130 0.006382477`\
`#> PCTSUPP 0.1912587 0.01821000 0.006382477 0.055287292`

### confint

\
[`confint`](https://rdrr.io/r/stats/confint.html)`(``out``, level ``=`` ``0.95``, type ``=`` ``"pc"``)`\
`#>              2.5 %    97.5 %`\
`#> fsq     2.33633090 8.8333110`\
`#> NARTIC  0.40383014 1.9949771`\
`#> PCTGRT  0.18785387 1.3668470`\
`#> PCTSUPP 0.04223012 0.9193111`

## References
