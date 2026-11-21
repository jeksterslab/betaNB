## Release summary

This is a minor update (1.0.7 -> 1.1.0).

- New functions: `FSqNB()` and `SCorSqNB()`.
- The wild bootstrap in `NB()` (`type = "wild"`), modified percentile intervals and adjusted differences in `DeltaRSqNB()`, and selective standardization through `std_y` and `std_x`.
- The bootstrap and the effect sizes are computed in C++.
- The `thetahatstar` and `jackknife` elements are now matrices.
- No exported function was removed or renamed.

## Test environments

- Linux (x86_64, Apptainer image), R 4.6.2: `R CMD check --as-cran`, Status: 2 NOTEs (environment only, see below).
- win-builder (R-devel): TODO (the maintainer runs this before submission).
- R-hub: TODO (the maintainer runs this before submission).

## R CMD check results

Linux (R 4.6.2): 0 errors | 0 warnings | 2 notes.

- Compilation flags (`-Wdate-time`, `-Werror=format-security`, `-Wformat`): they come from the distribution's R build, not from the package's `Makevars`.
- HTML validation skipped: no `tidy` in the test environment.

TODO: add the win-builder and R-hub results.

## Reverse dependencies

betaNB has three reverse dependencies on CRAN, all `Suggests`: betaDelta, betaMC, and betaSandwich.

I checked the CRAN versions betaDelta 1.0.7, betaMC 1.3.4, and betaSandwich 1.0.9 against betaNB 1.1.0 with `R CMD check`: Status OK for all three (0 errors | 0 warnings | 0 notes). None of them calls betaNB in code, tests, or vignettes.
