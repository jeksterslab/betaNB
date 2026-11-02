#' Nonparametric Bootstrap Covariance Matrices
#'
#' Draws bootstrap samples of the rows of `x`
#' with the same random number stream as
#' `lapply(seq_len(R), function(i) sample.int(n = n, size = n,
#' replace = TRUE))`
#' and returns the half-vectorized sample covariance matrix
#' of each bootstrap sample, computed in C++.
#' Bootstrap samples are processed in blocks of `block` samples
#' to bound memory.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Numeric matrix.
#'   Data.
#' @param R Positive integer.
#'   Number of bootstrap samples.
#' @param block Positive integer.
#'   Number of bootstrap samples processed at a time
#'   (reduced so that at most about `1e7` indices are held at once).
#' @return Returns an `R` by `k * (k + 1) / 2` numeric matrix,
#'   where `k` is the number of columns of `x`.
#'
#' @family Bootstrap Functions
#' @keywords nBootstrap internal
#' @noRd
.NBVechCovDraws <- function(x,
                            R = 5000L,
                            block = 1000L) {
  n <- dim(x)[1]
  # at most about 1e7 indices in memory at a time
  block <- max(
    1L,
    min(
      block,
      as.integer(1e7 %/% n)
    )
  )
  starts <- seq(
    from = 1L,
    to = R,
    by = block
  )
  out <- lapply(
    X = starts,
    FUN = function(start) {
      size <- min(block, R - start + 1L)
      idx <- vapply(
        X = seq_len(size),
        FUN = function(i) {
          sample.int(
            n = n,
            size = n,
            replace = TRUE
          )
        },
        FUN.VALUE = integer(n)
      )
      .NBVechCov(
        x = x,
        idx = matrix(
          data = idx,
          nrow = n
        )
      )
    }
  )
  do.call(
    what = "rbind",
    args = out
  )
}
