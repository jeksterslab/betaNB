# Estimate Cohen's f-Squared and Local f-Squared and Generate the Corresponding Sampling Distribution Using Nonparametric Bootstrapping

Estimate Cohen's f-Squared and Local f-Squared and Generate the
Corresponding Sampling Distribution Using Nonparametric Bootstrapping

## Usage

``` r
FSqNB(object, alpha = c(0.05, 0.01, 0.001))
```

## Arguments

- object:

  Object of class `nb`, that is, the output of the
  [`NB()`](https://jeksterslab.github.io/betaNB/reference/NB.md)
  function.

- alpha:

  Numeric vector. Significance level \\(\alpha\\).

## Value

Returns an object of class `betanb` which is a list with the following
elements:

- call:

  Function call.

- args:

  Function arguments.

- thetahatstar:

  Sampling distribution of \\(f^2\\) (column `fsq`) and the local
  \\(f^2\\) (one column per regressor).

- jackknife:

  Jackknife estimates.

- vcov:

  Sampling variance-covariance matrix.

- est:

  Vector of estimates.

- fun:

  Function used ("FSqNB").

## Details

Let \\(\boldsymbol{\beta}^{\ast}\\) be the vector of standardized
slopes, \\(\boldsymbol{R}\_{x}\\) the correlation matrix of the
regressors, \\(r^{jj}\\) the \\(j\\)th diagonal element of
\\(\boldsymbol{R}\_{x}^{-1}\\), and \\(R^{2} =
\boldsymbol{\beta}^{\ast\prime} \boldsymbol{R}\_{x}
\boldsymbol{\beta}^{\ast}\\). The semipartial correlation of regressor
\\(j\\) is \$\$sr\_{j} = \beta^{\ast}\_{j} / \sqrt{r^{jj}} =
\beta^{\ast}\_{j} \sqrt{1 - R^{2}\_{j \cdot -j}},\$\$ where \\(R^{2}\_{j
\cdot -j}\\) is the R-squared from regressing regressor \\(j\\) on the
other regressors. Its square, \\(sr^{2}\_{j}\\), is the change in
\\(R^{2}\\) when regressor \\(j\\) is added last. Because \\(1 / r^{jj}
= 1 - R^{2}\_{j \cdot -j}\\), \\(sr\_{j}\\) shrinks toward zero as
regressor \\(j\\) becomes more redundant with the other regressors.
Cohen's f-squared and the local f-squared of regressor \\(j\\) are
\$\$f^{2} = \frac{R^{2}}{1 - R^{2}}, \quad f^{2}\_{j} =
\frac{sr^{2}\_{j}}{1 - R^{2}}.\$\$ By convention (Cohen, 1988), values
of about 0.02, 0.15, and 0.35 are small, medium, and large effects. Each
effect size is computed from every bootstrap sample (see
[`NB()`](https://jeksterslab.github.io/betaNB/reference/NB.md)), and the
confidence intervals are percentile-based.

## References

Selya, A. S., Rose, J. S., Dierker, L. C., Hedeker, D., & Mermelstein,
R. J. (2012). A practical guide to calculating Cohen's f2, a measure of
local effect size, from PROC MIXED. *Frontiers in Psychology*, *3*, 111.
[doi:10.3389/fpsyg.2012.00111](https://doi.org/10.3389/fpsyg.2012.00111)

## See also

Other Beta Nonparametric Bootstrap Functions:
[`BetaNB()`](https://jeksterslab.github.io/betaNB/reference/BetaNB.md),
[`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md),
[`DiffBetaNB()`](https://jeksterslab.github.io/betaNB/reference/DiffBetaNB.md),
[`NB()`](https://jeksterslab.github.io/betaNB/reference/NB.md),
[`PCorNB()`](https://jeksterslab.github.io/betaNB/reference/PCorNB.md),
[`RSqNB()`](https://jeksterslab.github.io/betaNB/reference/RSqNB.md),
[`SCorNB()`](https://jeksterslab.github.io/betaNB/reference/SCorNB.md),
[`SCorSqNB()`](https://jeksterslab.github.io/betaNB/reference/SCorSqNB.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
# Data ---------------------------------------------------------------------
data("nas1982", package = "betaNB")

# Fit Model in lm ----------------------------------------------------------
object <- stats::lm(
  formula = QUALITY ~ NARTIC + PCTGRT + PCTSUPP,
  data = nas1982
)

# NB -----------------------------------------------------------------------
nb <- NB(
  object = object,
  R = 100, # use a large value e.g., 5000L for actual research
  seed = 0508
)

# FSqNB --------------------------------------------------------------------
out <- FSqNB(object = nb, alpha = 0.05)

## Methods -----------------------------------------------------------------
print(x = out)
#> Call:
#> FSqNB(object = nb, alpha = 0.05)
#> 
#> Cohen's f-squared (fsq) and local f-squared
#> type = "pc"
#>            est     se   R   2.5%  97.5%
#> fsq     4.1158 1.5440 100 2.4601 7.8713
#> NARTIC  0.9510 0.4070 100 0.3796 1.8343
#> PCTGRT  0.6019 0.2949 100 0.2230 1.2633
#> PCTSUPP 0.2909 0.2197 100 0.0457 0.8203
summary(object = out)
#> Call:
#> FSqNB(object = nb, alpha = 0.05)
#> 
#> Cohen's f-squared (fsq) and local f-squared
#> type = "pc"
#>            est     se   R   2.5%  97.5%
#> fsq     4.1158 1.5440 100 2.4601 7.8713
#> NARTIC  0.9510 0.4070 100 0.3796 1.8343
#> PCTGRT  0.6019 0.2949 100 0.2230 1.2633
#> PCTSUPP 0.2909 0.2197 100 0.0457 0.8203
coef(object = out)
#>       fsq    NARTIC    PCTGRT   PCTSUPP 
#> 4.1157764 0.9509843 0.6018924 0.2909455 
vcov(object = out)
#>               fsq     NARTIC     PCTGRT    PCTSUPP
#> fsq     2.3839448 0.43201767 0.15793271 0.16327829
#> NARTIC  0.4320177 0.16565182 0.03993109 0.02103005
#> PCTGRT  0.1579327 0.03993109 0.08698758 0.01286252
#> PCTSUPP 0.1632783 0.02103005 0.01286252 0.04825512
confint(object = out, level = 0.95)
#>              2.5 %    97.5 %
#> fsq     2.46014097 7.8713443
#> NARTIC  0.37962844 1.8342847
#> PCTGRT  0.22297610 1.2633129
#> PCTSUPP 0.04572958 0.8202957
```
