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
  [`NB()`](https://github.com/jeksterslab/betaNB/reference/NB.md)
  function.

- alpha:

  Numeric vector. Significance level \\\alpha\\.

## Value

Returns an object of class `betanb` which is a list with the following
elements:

- call:

  Function call.

- args:

  Function arguments.

- thetahatstar:

  Sampling distribution of \\r^{2}\_{p}\\.

- vcov:

  Sampling variance-covariance matrix of \\r^{2}\_{p}\\.

- est:

  Vector of estimated \\r^{2}\_{p}\\.

- fun:

  Function used ("PCorNB").

## Details

The vector of squared partial correlation coefficients (\\r^{2}\_{p}\\)
is estimated from bootstrap samples. Confidence intervals are generated
by obtaining percentiles corresponding to \\100(1 - \alpha)\\\\ from the
generated sampling distribution of \\r^{2}\_{p}\\, where \\\alpha\\ is
the significance level.

## See also

Other Beta Nonparametric Bootstrap Functions:
[`BetaNB()`](https://github.com/jeksterslab/betaNB/reference/BetaNB.md),
[`DeltaRSqNB()`](https://github.com/jeksterslab/betaNB/reference/DeltaRSqNB.md),
[`DiffBetaNB()`](https://github.com/jeksterslab/betaNB/reference/DiffBetaNB.md),
[`NB()`](https://github.com/jeksterslab/betaNB/reference/NB.md),
[`RSqNB()`](https://github.com/jeksterslab/betaNB/reference/RSqNB.md),
[`SCorNB()`](https://github.com/jeksterslab/betaNB/reference/SCorNB.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
# Data ---------------------------------------------------------------------
data("nas1982", package = "betaNB")

# Fit Model in lm ----------------------------------------------------------
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)

# NB -----------------------------------------------------------------------
nb <- NB(
  object,
  R = 100, # use a large value e.g., 5000L for actual research
  seed = 0508
)

# PCorNB -------------------------------------------------------------------
out <- PCorNB(nb, alpha = 0.05)

## Methods -----------------------------------------------------------------
print(out)
#> Call:
#> PCorNB(object = nb, alpha = 0.05)
#> 
#> Squared partial correlations
#> type = "pc"
#>            est     se   R   2.5%  97.5%
#> NARTIC  0.4874 0.1048 100 0.2750 0.6471
#> PCTGRT  0.3757 0.1104 100 0.1821 0.5579
#> PCTSUPP 0.2254 0.1115 100 0.0434 0.4506
summary(out)
#> Call:
#> PCorNB(object = nb, alpha = 0.05)
#> 
#> Squared partial correlations
#> type = "pc"
#>            est     se   R   2.5%  97.5%
#> NARTIC  0.4874 0.1048 100 0.2750 0.6471
#> PCTGRT  0.3757 0.1104 100 0.1821 0.5579
#> PCTSUPP 0.2254 0.1115 100 0.0434 0.4506
coef(out)
#>    NARTIC    PCTGRT   PCTSUPP 
#> 0.4874382 0.3757383 0.2253739 
vcov(out)
#>              NARTIC      PCTGRT     PCTSUPP
#> NARTIC  0.010979538 0.003168814 0.002238300
#> PCTGRT  0.003168814 0.012181158 0.001360438
#> PCTSUPP 0.002238300 0.001360438 0.012442963
confint(out, level = 0.95)
#>              2.5 %    97.5 %
#> NARTIC  0.27502096 0.6471038
#> PCTGRT  0.18213410 0.5578763
#> PCTSUPP 0.04343062 0.4506086
```
