# Estimate Standardized Regression Coefficients and Generate the Corresponding Sampling Distribution Using Nonparametric Bootstrapping

Estimate Standardized Regression Coefficients and Generate the
Corresponding Sampling Distribution Using Nonparametric Bootstrapping

## Usage

``` r
BetaNB(object, alpha = c(0.05, 0.01, 0.001), std_y = TRUE, std_x = NULL)
```

## Arguments

- object:

  Object of class `nb`, that is, the output of the
  [`NB()`](https://jeksterslab.github.io/betaNB/reference/NB.md)
  function.

- alpha:

  Numeric vector. Significance level \\(\alpha\\).

- std_y:

  Logical. Standardize \\(y\\). With `std_y = FALSE`, \\(y\\) is left in
  its original units.

- std_x:

  Character vector or `NULL`. Names of the regressors to standardize.
  `NULL` (default) standardizes all regressors; `character(0)`
  standardizes none (for example, leave a dummy variable out to keep its
  0-1 contrast). The standard deviations are taken from each bootstrap
  sample.

## Value

Returns an object of class `betanb` which is a list with the following
elements:

- call:

  Function call.

- args:

  Function arguments.

- thetahatstar:

  Sampling distribution of \\(\boldsymbol{\hat{\beta}}\\).

- jackknife:

  Jackknife estimates.

- vcov:

  Sampling variance-covariance matrix of \\(\boldsymbol{\hat{\beta}}\\).

- est:

  Vector of estimated \\(\boldsymbol{\hat{\beta}}\\).

- fun:

  Function used ("BetaNB").

## Details

The vector of standardized regression coefficients
(\\(\boldsymbol{\hat{\beta}}\\)) is estimated from bootstrap samples.
Confidence intervals are the percentiles corresponding to \\(100(1 -
\alpha)\\%\\) of the sampling distribution of
\\(\boldsymbol{\hat{\beta}}\\), where \\(\alpha\\) is the significance
level.

Partition the covariance matrix of the outcome and the regressors as
\$\$\boldsymbol{\Sigma} = \begin{pmatrix} \sigma^{2}\_{y} &
\boldsymbol{\sigma}\_{yx}^{\prime} \\\\ \boldsymbol{\sigma}\_{yx} &
\boldsymbol{\Sigma}\_{x} \end{pmatrix}.\$\$ The regression slopes and
the standardized regression slopes are \$\$\boldsymbol{\beta} =
\boldsymbol{\Sigma}\_{x}^{-1} \boldsymbol{\sigma}\_{yx}, \quad
\beta^{\ast}\_{j} = \beta\_{j} \frac{\sigma\_{x\_{j}}}{\sigma\_{y}},\$\$
where \\(\sigma\_{x\_{j}}\\) is the standard deviation of regressor
\\(j\\). With `std_y = FALSE`, \\(\sigma\_{y}\\) is replaced by one; for
a regressor left out of `std_x`, \\(\sigma\_{x\_{j}}\\) is replaced by
one. The estimates are computed from the data, the draws
\\(\hat{\boldsymbol{\beta}}^{\ast}\_{b}\\) from each bootstrap
covariance matrix \\(\hat{\boldsymbol{\Sigma}}^{\ast}\_{b}\\) (see
[`NB()`](https://jeksterslab.github.io/betaNB/reference/NB.md)), and
`vcov` is the sample covariance matrix of the draws.

## References

Efron, B., & Tibshirani, R. J. (1993). *An introduction to the
bootstrap*. Chapman & Hall.
[doi:10.1201/9780429246593](https://doi.org/10.1201/9780429246593)

## See also

Other Beta Nonparametric Bootstrap Functions:
[`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md),
[`DiffBetaNB()`](https://jeksterslab.github.io/betaNB/reference/DiffBetaNB.md),
[`FSqNB()`](https://jeksterslab.github.io/betaNB/reference/FSqNB.md),
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

# BetaNB -------------------------------------------------------------------
out <- BetaNB(object = nb, alpha = 0.05)

## Methods -----------------------------------------------------------------
print(x = out)
#> Call:
#> BetaNB(object = nb, alpha = 0.05)
#> 
#> Standardized regression slopes
#> type = "pc"
#>            est     se   R   2.5%  97.5%
#> NARTIC  0.4951 0.0708 100 0.3498 0.6141
#> PCTGRT  0.3915 0.0797 100 0.2440 0.5192
#> PCTSUPP 0.2632 0.0813 100 0.1033 0.4193
summary(object = out)
#> Call:
#> BetaNB(object = nb, alpha = 0.05)
#> 
#> Standardized regression slopes
#> type = "pc"
#>            est     se   R   2.5%  97.5%
#> NARTIC  0.4951 0.0708 100 0.3498 0.6141
#> PCTGRT  0.3915 0.0797 100 0.2440 0.5192
#> PCTSUPP 0.2632 0.0813 100 0.1033 0.4193
coef(object = out)
#>    NARTIC    PCTGRT   PCTSUPP 
#> 0.4951451 0.3914887 0.2632477 
vcov(object = out)
#>               NARTIC       PCTGRT      PCTSUPP
#> NARTIC   0.005012960 -0.002549951 -0.002273111
#> PCTGRT  -0.002549951  0.006346647 -0.002320642
#> PCTSUPP -0.002273111 -0.002320642  0.006606168
confint(object = out, level = 0.95)
#>             2.5 %    97.5 %
#> NARTIC  0.3497796 0.6141490
#> PCTGRT  0.2440254 0.5192221
#> PCTSUPP 0.1032870 0.4193349
```
