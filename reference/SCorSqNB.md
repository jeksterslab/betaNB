# Squared Signed-Semipartial Confidence Intervals

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

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
fit <- stats::lm(formula = mpg ~ wt + hp, data = mtcars)
out <- NB(object = fit, R = 199)
SCorSqNB(object = out)
#>           est      lower     upper
#> wt 0.22434811 0.06452469 0.3660758
#> hp 0.07395266 0.02219781 0.1493710
```
