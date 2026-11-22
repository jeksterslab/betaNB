# Estimate Squared Partial Correlation Coefficients and Generate the Corresponding Sampling Distribution Using Nonparametric Bootstrapping

Estimate Squared Partial Correlation Coefficients and Generate the
Corresponding Sampling Distribution Using Nonparametric Bootstrapping

## Usage

``` r
PCorNB(object, alpha = c(0.05, 0.01, 0.001))
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

  Sampling distribution of \\(pr^{2}\_{j}\\).

- vcov:

  Sampling variance-covariance matrix of \\(pr^{2}\_{j}\\).

- est:

  Vector of estimated \\(pr^{2}\_{j}\\).

- fun:

  Function used ("PCorNB").

## Details

The vector of squared partial correlation coefficients
(\\(pr^{2}\_{j}\\)) is estimated from bootstrap samples. Confidence
intervals are the percentiles corresponding to \\(100(1 - \alpha)\\%\\)
of the sampling distribution of \\(pr^{2}\_{j}\\), where \\(\alpha\\) is
the significance level.

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
regressor \\(j\\) becomes more redundant with the other regressors. The
squared partial correlation is \$\$pr^{2}\_{j} = \frac{sr^{2}\_{j}}{1 -
R^{2} + sr^{2}\_{j}},\$\$ the proportion of the variance in the outcome
not explained by the other regressors that is explained by regressor
\\(j\\). Each effect size is computed from every bootstrap sample (see
[`NB()`](https://jeksterslab.github.io/betaNB/reference/NB.md)), and the
confidence intervals are percentile-based.

## See also

Other Beta Nonparametric Bootstrap Functions:
[`BetaNB()`](https://jeksterslab.github.io/betaNB/reference/BetaNB.md),
[`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md),
[`DiffBetaNB()`](https://jeksterslab.github.io/betaNB/reference/DiffBetaNB.md),
[`FSqNB()`](https://jeksterslab.github.io/betaNB/reference/FSqNB.md),
[`NB()`](https://jeksterslab.github.io/betaNB/reference/NB.md),
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

# PCorNB -------------------------------------------------------------------
out <- PCorNB(object = nb, alpha = 0.05)

## Methods -----------------------------------------------------------------
print(x = out)
#> Call:
#> PCorNB(object = nb, alpha = 0.05)
#> 
#> Squared partial correlations
#> type = "pc"
#>            est     se   R   2.5%  97.5%
#> NARTIC  0.4874 0.1048 100 0.2750 0.6471
#> PCTGRT  0.3757 0.1104 100 0.1821 0.5579
#> PCTSUPP 0.2254 0.1115 100 0.0434 0.4506
summary(object = out)
#> Call:
#> PCorNB(object = nb, alpha = 0.05)
#> 
#> Squared partial correlations
#> type = "pc"
#>            est     se   R   2.5%  97.5%
#> NARTIC  0.4874 0.1048 100 0.2750 0.6471
#> PCTGRT  0.3757 0.1104 100 0.1821 0.5579
#> PCTSUPP 0.2254 0.1115 100 0.0434 0.4506
coef(object = out)
#>    NARTIC    PCTGRT   PCTSUPP 
#> 0.4874382 0.3757383 0.2253739 
vcov(object = out)
#>              NARTIC      PCTGRT     PCTSUPP
#> NARTIC  0.010979538 0.003168814 0.002238300
#> PCTGRT  0.003168814 0.012181158 0.001360438
#> PCTSUPP 0.002238300 0.001360438 0.012442963
confint(object = out, level = 0.95)
#>              2.5 %    97.5 %
#> NARTIC  0.27502096 0.6471038
#> PCTGRT  0.18213410 0.5578763
#> PCTSUPP 0.04343062 0.4506086
```
