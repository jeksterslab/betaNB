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
object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = nas1982)
nb <- NB(object, R = 100)
print(nb)
#> Call:
#> NB(object = object, R = 100)
#> 
#> The first six bootstrap covariance matrices.
#> 
#>           [,1]     [,2]      [,3]      [,4]     [,5]     [,6]     [,7]     [,8]
#> [1,]  72.93188 274.6449  94.69855 106.57826 2287.452 290.4338 301.6961 377.0319
#> [2,]  76.34058 295.7188  98.86039  94.01691 2757.851 110.5903 234.2106 379.8884
#> [3,] 103.20242 623.9106  96.47343 135.01836 5551.129 502.4386 656.6986 271.3700
#> [4,] 139.10531 623.2995 184.59903 197.00676 3684.010 720.2203 779.6913 392.3517
#> [5,]  90.28841 361.3986 124.31063 161.34444 2312.685 432.5541 594.0111 318.5551
#> [6,]  92.72464 501.1150 120.14300 105.44348 3946.655 604.3932 461.8029 295.3720
#>           [,9]    [,10]
#> [1,]  61.41159 474.8739
#> [2,]  77.14831 518.2246
#> [3,] 130.90918 391.4995
#> [4,] 266.20483 641.4440
#> [5,] 238.70000 546.5667
#> [6,] 155.30725 494.1159
```
