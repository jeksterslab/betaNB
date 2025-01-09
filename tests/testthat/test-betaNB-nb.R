## ---- test-betaNB-nb
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 tol,
                 n,
                 p,
                 beta,
                 R) {
    message(text)
    set.seed(42)
    sigmacapx <- diag(p)
    beta <- rep(x = beta, times = p)
    sigmasq <- (
      1 - (
        tcrossprod(beta, sigmacapx) %*% beta
      )
    )
    sigmaysq <- .Vec(
      sigmasq + crossprod(
        beta,
        sigmacapx
      ) %*% beta
    )
    sigmayx <- .Vec(
      crossprod(
        beta,
        sigmacapx
      )
    )
    sigmacap <- matrix(
      data = 0.0,
      nrow = p + 1,
      ncol = p + 1
    )
    sigmacap[1, 1] <- sigmaysq
    sigmacap[1, 2:(p + 1)] <- sigmacap[2:(p + 1), 1] <- sigmayx
    sigmacap[2:(p + 1), 2:(p + 1)] <- sigmacapx
    theta <- .Vech(sigmacap)
    x <- scale(
      matrix(
        data = stats::rnorm(
          n = n * p
        ),
        nrow = n,
        ncol = p
      )
    )
    y <- (
      x %*% beta
    ) + rnorm(
      n = n,
      sd = sqrt(sigmasq)
    )
    df <- cbind(
      y,
      x
    )
    colnames(df) <- c(
      "y",
      paste0("x", seq_len(p))
    )
    df <- as.data.frame(df)
    object <- lm(y ~ ., data = df)
    nb <- NB(object, R = R)
    nb <- colMeans(
      do.call(
        what = "rbind",
        args = lapply(
          X = nb$thetahatstar,
          FUN = function(i) {
            return(
              .Vech(i)
            )
          }
        )
      )
    )
    testthat::test_that(
      paste(text, "means"),
      {
        testthat::skip_on_cran()
        testthat::expect_true(
          all(
            abs(
              nb - theta
            ) <= tol
          )
        )
      }
    )
    print.nb(NB(object, R = 6))
  },
  text = "test-betaNB-nb",
  tol = 0.05,
  n = 1000L,
  p = 2,
  beta = 0.5,
  R = 100L
)
