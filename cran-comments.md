## Release summary

This is a minor update (1.0.7 -> 1.1.0).

- New functions: `FSqNB()` and `SCorSqNB()`.
- The wild bootstrap in `NB()` (`type = "wild"`), modified percentile intervals and adjusted differences in `DeltaRSqNB()`, and selective standardization through `std_y` and `std_x`.
- The bootstrap and the effect sizes are computed in C++.
- The `thetahatstar` and `jackknife` elements are now matrices.
- No exported function was removed or renamed.

## Test environments

- Linux (x86_64, Apptainer image), R 4.6.2: `R CMD check --as-cran`, Status: TODO (the maintainer confirms after `make all`).
- win-builder (R-devel): TODO (the maintainer runs this before submission).
- R-hub: TODO (the maintainer runs this before submission).

## R CMD check results

TODO: write the Linux result here (0 errors | 0 warnings | 0 notes expected). The win-builder and R-hub results go here.

## Reverse dependencies

TODO: confirm with `tools::package_dependencies(packages = "betaNB", reverse = TRUE)` before submission.
