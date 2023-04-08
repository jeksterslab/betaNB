## ---- test-external-betaNB-delta-r-sq-nb
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
    nb <- DeltaRSqNB(object = NB(object, R = R, seed = 42))
    pc <- confint(nb, type = "pc")
    bc <- confint(nb, type = "bc")
    bca <- confint(nb, type = "bca")
    foo <- function(data, i) {
      df <- as.data.frame(data[i, ])
      colnames(df) <- c(
        "y",
        paste0("x", seq_len(p))
      )
      lm_process <- .ProcessLM(
        lm(
          formula = y ~ .,
          data = df
        )
      )
      return(
        .SPCor(
          betastar = lm_process$betastar,
          sigmacapx = lm_process$sigmacapx
        )^2
      )
    }
    set.seed(42)
    boot.out <- boot::boot(df, foo, R = R)
    for (i in seq_len(p)) {
      boot <- boot::boot.ci(
        boot.out = boot.out,
        type = c("perc", "bca"),
        index = i
      )
      pc_ll <- boot$percent[4]
      pc_ul <- boot$percent[5]
      bca_ll <- boot$bca[4]
      bca_ul <- boot$bca[5]
      testthat::test_that(
        paste(text, "index", i),
        {
          testthat::expect_true(
            all(
              abs(
                c(
                  pc_ll,
                  bca_ll,
                  pc_ul,
                  bca_ul
                ) - c(
                  pc[i, 1],
                  bca[i, 1],
                  pc[i, 2],
                  bca[i, 2]
                )
              ) <= tol
            )
          )
        }
      )
    }
  },
  text = "test-external-betaNB-delta-r-sq-nb",
  tol = 0.01,
  n = 1000L,
  p = 3,
  beta = 0.5,
  R = 1000L
)
