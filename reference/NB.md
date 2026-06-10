# Generate the Sampling Distribution of Sample Covariances Using Nonparametric Bootstrapping

Generate the Sampling Distribution of Sample Covariances Using
Nonparametric Bootstrapping

## Usage

``` r
NB(object, R = 5000L, seed = NULL)
```

## Arguments

- object:

  Object of class `lm`.

- R:

  Positive integer. Number of bootstrap replications.

- seed:

  Integer. Seed number for reproducibility.

## Value

Returns an object of class `nb` which is a list with the following
elements:

- call:

  Function call.

- args:

  Function arguments.

- lm_process:

  Processed `lm` object.

- thetahatstar:

  Sampling distribution of sample covariances.

- jackknife:

  Jackknife estimates.

## References

Efron, B., & Tibshirani, R. J. (1993) *An introduction to the
bootstrap*. Chapman & Hall.

## See also

Other Beta Nonparametric Bootstrap Functions:
[`BetaNB()`](https://github.com/jeksterslab/betaNB/reference/BetaNB.md),
[`DeltaRSqNB()`](https://github.com/jeksterslab/betaNB/reference/DeltaRSqNB.md),
[`DiffBetaNB()`](https://github.com/jeksterslab/betaNB/reference/DiffBetaNB.md),
[`PCorNB()`](https://github.com/jeksterslab/betaNB/reference/PCorNB.md),
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
  R = 100, # use a large value e.g., 20000L for actual research
  seed = 0508
)
nb
#> Call:
#> NB(object = object, R = 100, seed = 508)
#> 
#> The first six bootstrap covariance matrices.
#> 
#> [[1]]
#>          [,1]      [,2]     [,3]     [,4]
#> [1,] 104.8715  489.5053 112.6802 187.9391
#> [2,] 489.5053 2967.6314 563.7749 844.3464
#> [3,] 112.6802  563.7749 267.0512 213.5585
#> [4,] 187.9391  844.3464 213.5585 484.8758
#> 
#> [[2]]
#>          [,1]      [,2]     [,3]     [,4]
#> [1,] 129.7609  537.8783 160.9517 223.1705
#> [2,] 537.8783 3217.0435 612.2077 931.1923
#> [3,] 160.9517  612.2077 389.8048 251.7507
#> [4,] 223.1705  931.1923 251.7507 613.0826
#> 
#> [[3]]
#>           [,1]      [,2]     [,3]     [,4]
#> [1,]  68.31353  309.2290 101.9329 108.6063
#> [2,] 309.22899 2514.1256 433.4164 480.6309
#> [3,] 101.93285  433.4164 404.9957 159.9232
#> [4,] 108.60628  480.6309 159.9232 442.2652
#> 
#> [[4]]
#>           [,1]      [,2]     [,3]     [,4]
#> [1,]  99.90966  533.2034 119.6609 144.6464
#> [2,] 533.20338 4584.2440 536.1246 709.2473
#> [3,] 119.66087  536.1246 306.1990 173.3411
#> [4,] 144.64638  709.2473 173.3411 602.6048
#> 
#> [[5]]
#>          [,1]      [,2]     [,3]     [,4]
#> [1,] 124.0604  583.9411 141.2575 183.6101
#> [2,] 583.9411 4629.7546 602.2386 732.7140
#> [3,] 141.2575  602.2386 293.4208 183.9396
#> [4,] 183.6101  732.7140 183.9396 649.0246
#> 
#> [[6]]
#>          [,1]      [,2]     [,3]     [,4]
#> [1,] 104.7884  472.3159 159.0193 163.9565
#> [2,] 472.3159 3566.4295 696.9957 576.1792
#> [3,] 159.0193  696.9957 357.8382 230.7947
#> [4,] 163.9565  576.1792 230.7947 625.7203
#> 
# The `nb` object can be passed as the first argument
# to the following functions
#   - BetaNB
#   - DeltaRSqNB
#   - DiffBetaNB
#   - PCorNB
#   - RSqNB
#   - SCorNB
```
