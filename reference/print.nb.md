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
#> [1,] 108.49903 517.1585 117.31932 162.80000 3725.258 429.4309 633.9556 244.1802
#> [2,]  86.11836 364.8473 121.97343 127.49275 2415.859 517.4560 510.9749 347.7048
#> [3,] 148.90242 676.1353 182.11498 225.76618 4427.130 744.4609 921.9063 351.2329
#> [4,]  88.92947 455.1498  89.18068  94.90145 4414.091 197.3155 243.6633 300.6923
#> [5,] 106.02126 574.9372 130.87536 139.97101 4750.962 661.0986 550.2493 317.6773
#> [6,]  85.86473 296.8580  94.32271 162.00773 2059.939 227.6188 488.9459 335.0749
#>           [,9]    [,10]
#> [1,] 229.93333 470.4000
#> [2,] 170.48213 620.2184
#> [3,] 236.01256 627.5401
#> [4,]  52.65169 321.3203
#> [5,] 166.41643 573.4860
#> [6,] 130.44251 615.3024
```
