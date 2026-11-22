# Print Method for an Object of Class `nb`

Print Method for an Object of Class `nb`

## Usage

``` r
# S3 method for class 'nb'
print(x, ...)
```

## Arguments

- x:

  Object of Class `nb`.

- ...:

  additional arguments.

## Value

Prints the first six bootstrap covariance matrices.

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

print(x = nb)
#> Call:
#> NB(object = object, R = 100, seed = 508)
#> 
#> The first six bootstrap covariance matrices.
#> 
#>           [,1]     [,2]     [,3]     [,4]     [,5]     [,6]     [,7]     [,8]
#> [1,] 104.87150 489.5053 112.6802 187.9391 2967.631 563.7749 844.3464 267.0512
#> [2,] 129.76087 537.8783 160.9517 223.1705 3217.043 612.2077 931.1923 389.8048
#> [3,]  68.31353 309.2290 101.9329 108.6063 2514.126 433.4164 480.6309 404.9957
#> [4,]  99.90966 533.2034 119.6609 144.6464 4584.244 536.1246 709.2473 306.1990
#> [5,] 124.06039 583.9411 141.2575 183.6101 4629.755 602.2386 732.7140 293.4208
#> [6,] 104.78841 472.3159 159.0193 163.9565 3566.429 696.9957 576.1792 357.8382
#>          [,9]    [,10]
#> [1,] 213.5585 484.8758
#> [2,] 251.7507 613.0826
#> [3,] 159.9232 442.2652
#> [4,] 173.3411 602.6048
#> [5,] 183.9396 649.0246
#> [6,] 230.7947 625.7203
```
