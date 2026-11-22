# Confidence Intervals Method for an Object of Class `betanb`

Confidence Intervals Method for an Object of Class `betanb`

## Usage

``` r
# S3 method for class 'betanb'
confint(object, parm = NULL, level = 0.95, type = "pc", ...)
```

## Arguments

- object:

  Object of Class `betanb`, that is, the output of the
  [`BetaNB()`](https://jeksterslab.github.io/betaNB/reference/BetaNB.md),
  [`RSqNB()`](https://jeksterslab.github.io/betaNB/reference/RSqNB.md),
  [`SCorNB()`](https://jeksterslab.github.io/betaNB/reference/SCorNB.md),
  [`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md),
  [`PCorNB()`](https://jeksterslab.github.io/betaNB/reference/PCorNB.md),
  [`FSqNB()`](https://jeksterslab.github.io/betaNB/reference/FSqNB.md),
  or
  [`DiffBetaNB()`](https://jeksterslab.github.io/betaNB/reference/DiffBetaNB.md)
  functions.

- parm:

  a specification of which parameters are to be given confidence
  intervals, either a vector of numbers or a vector of names. If
  missing, all parameters are considered.

- level:

  the confidence level required.

- type:

  Character string. Confidence interval type, that is, `type = "pc"` for
  percentile; `type = "bc"` for bias corrected; `type = "bca"` for bias
  corrected and accelerated; `type = "mpc"` for modified percentile,
  available only for
  [`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md)
  (unadjusted or `adj = TRUE`).

- ...:

  additional arguments.

## Value

Returns a matrix of confidence intervals.

## Details

Let \\(\hat{\theta}\\) be the estimate, \\(\hat{\theta}^{\ast}\_{1},
\dots, \hat{\theta}^{\ast}\_{R}\\) the bootstrap draws with empirical
distribution function \\(\hat{G}\\), \\(\Phi\\) the standard normal
distribution function, and \\(z\_{p} = \Phi^{-1} \left( p \right)\\).
The limits of a \\(100 \left( 1 - \alpha \right) \\%\\) interval are
\\(\hat{G}^{-1} \left( p\_{1} \right)\\) and \\(\hat{G}^{-1} \left(
p\_{2} \right)\\) (type 7 quantiles of the draws). The percentile
interval (`type = "pc"`) uses \\(p\_{1} = \alpha / 2\\) and \\(p\_{2} =
1 - \alpha / 2\\). The bias-corrected interval (`type = "bc"`) uses
\$\$p\_{k} = \Phi \left( 2 \hat{z}\_{0} + z\_{\alpha\_{k}} \right),
\quad \hat{z}\_{0} = \Phi^{-1} \left( \frac{1}{R} \sum\_{b = 1}^{R} I
\left( \hat{\theta}^{\ast}\_{b} \< \hat{\theta} \right) \right),\$\$
where \\(I\\) is the indicator function, \\(\alpha\_{1} = \alpha / 2\\),
and \\(\alpha\_{2} = 1 - \alpha / 2\\). The bias-corrected and
accelerated interval (`type = "bca"`) uses \$\$p\_{k} = \Phi \left(
\hat{z}\_{0} + \frac{\hat{z}\_{0} + z\_{\alpha\_{k}}}{1 - \hat{a} \left(
\hat{z}\_{0} + z\_{\alpha\_{k}} \right)} \right), \quad \hat{a} =
\frac{\sum\_{i = 1}^{n} \left( \bar{\theta}\_{\left( \cdot \right)} -
\hat{\theta}\_{\left( -i \right)} \right)^{3}}{6 \left\[ \sum\_{i =
1}^{n} \left( \bar{\theta}\_{\left( \cdot \right)} -
\hat{\theta}\_{\left( -i \right)} \right)^{2} \right\]^{3 / 2}},\$\$
where \\(\hat{\theta}\_{\left( -i \right)}\\) is the jackknife estimate
without observation \\(i\\) and \\(\bar{\theta}\_{\left( \cdot
\right)}\\) is their mean (Efron & Tibshirani, 1993). Failed draws are
dropped. The modified percentile interval (`type = "mpc"`) is described
in
[`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md).

## References

Efron, B., & Tibshirani, R. J. (1993). *An introduction to the
bootstrap*. Chapman & Hall.
[doi:10.1201/9780429246593](https://doi.org/10.1201/9780429246593)

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
confint(object = out, level = 0.95)
#>             2.5 %    97.5 %
#> NARTIC  0.3497796 0.6141490
#> PCTGRT  0.2440254 0.5192221
#> PCTSUPP 0.1032870 0.4193349
```
