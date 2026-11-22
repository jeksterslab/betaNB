# Estimate Squared Semipartial Correlation Coefficients and the Corresponding Confidence Intervals From the Signed Intervals

Square the signed interval as a set, with lower limit zero if it
contains zero. This differs from an interval of squared draws. No draws
are generated and no endpoints are clipped to one. Failed signed
endpoints remain missing.

## Usage

``` r
SCorSqNB(object, level = 0.95, type = "pc")
```

## Arguments

- object:

  Context accepted by
  [`SCorNB()`](https://jeksterslab.github.io/betaNB/reference/SCorNB.md).

- level:

  Single confidence level in (0, 1).

- type:

  Signed bootstrap interval: pc, bc, or bca.

## Value

Data frame with est, lower and upper columns and predictor row names.
The point estimate is the squared signed estimate. No standard error is
implied by this interval transformation.

## Details

The semipartial correlation \\(sr\_{j}\\) (see
[`SCorNB()`](https://jeksterslab.github.io/betaNB/reference/SCorNB.md))
is signed, and its confidence interval \\(\left\[ l, u \right\]\\) may
contain zero. The interval for \\(sr^{2}\_{j}\\) is the image of that
interval under squaring. The squared interval is \\(\left\[ l^{2}, u^{2}
\right\]\\) if \\(0 \< l\\), \\(\left\[ u^{2}, l^{2} \right\]\\) if \\(u
\< 0\\), and \\(\left\[ 0, \max \left( l^{2}, u^{2} \right) \right\]\\)
if the signed interval contains zero. This is not the interval of
squared draws, and it is not an interval for
[`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md).

## See also

Other Beta Nonparametric Bootstrap Functions:
[`BetaNB()`](https://jeksterslab.github.io/betaNB/reference/BetaNB.md),
[`DeltaRSqNB()`](https://jeksterslab.github.io/betaNB/reference/DeltaRSqNB.md),
[`DiffBetaNB()`](https://jeksterslab.github.io/betaNB/reference/DiffBetaNB.md),
[`FSqNB()`](https://jeksterslab.github.io/betaNB/reference/FSqNB.md),
[`NB()`](https://jeksterslab.github.io/betaNB/reference/NB.md),
[`PCorNB()`](https://jeksterslab.github.io/betaNB/reference/PCorNB.md),
[`RSqNB()`](https://jeksterslab.github.io/betaNB/reference/RSqNB.md),
[`SCorNB()`](https://jeksterslab.github.io/betaNB/reference/SCorNB.md)

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

# SCorSqNB -----------------------------------------------------------------
SCorSqNB(object = nb, level = 0.95, type = "pc")
#>               est       lower     upper
#> NARTIC  0.1858925 0.079616147 0.2940437
#> PCTGRT  0.1176542 0.037356988 0.2216212
#> PCTSUPP 0.0568722 0.008838188 0.1394616
```
