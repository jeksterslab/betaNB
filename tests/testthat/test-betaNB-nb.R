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
    testthat::skip_on_cran()
    message(text)

    set.seed(seed = 42)

    testthat::test_that(
      desc = paste(text, "means"),
      code = {
        set.seed(seed = 42)
        sigmacapx <- diag(x = p)
        beta <- rep(x = beta, times = p)
        sigmasq <- (
          1 - (
            tcrossprod(x = beta, y = sigmacapx) %*% beta
          )
        )
        sigmaysq <- .Vec(
          x = sigmasq + crossprod(
            x = beta,
            y = sigmacapx
          ) %*% beta
        )
        sigmayx <- .Vec(
          x = crossprod(
            x = beta,
            y = sigmacapx
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
        theta <- .Vech(x = sigmacap)
        x <- scale(
          x = matrix(
            data = stats::rnorm(
              n = n * p
            ),
            nrow = n,
            ncol = p
          )
        )
        y <- (
          x %*% beta
        ) + stats::rnorm(
          n = n,
          sd = sqrt(x = sigmasq)
        )
        df <- cbind(
          y,
          x
        )
        colnames(x = df) <- c(
          "y",
          paste0("x", seq_len(length.out = p))
        )
        df <- as.data.frame(x = df)
        object <- stats::lm(formula = y ~ ., data = df)
        nb <- NB(object = object, R = R)
        nb <- colMeans(x = nb$thetahatstar)
        testthat::expect_true(
          object = all(
            abs(
              x = nb - theta
            ) <= tol
          )
        )
        print.nb(x = NB(object = object, R = 6))
      }
    )
  },
  text = "test-betaNB-nb",
  tol = 0.05,
  n = 1000L,
  p = 2,
  beta = 0.5,
  R = 100L
)
