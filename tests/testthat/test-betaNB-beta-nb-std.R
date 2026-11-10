## ---- test-betaNB-beta-nb-std
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 tol) {
    testthat::skip_on_cran()
    message(text)
    set.seed(seed = 42)
    n <- 200
    x1 <- stats::rnorm(n = n)
    x2 <- stats::rbinom(n = n, size = 1, prob = 0.4)
    x3 <- stats::rnorm(n = n) + 0.5 * x1
    y <- 0.4 * x1 + 0.3 * x2 - 0.2 * x3 + stats::rnorm(n = n)
    df <- data.frame(y = y, x1 = x1, x2 = x2, x3 = x3)
    object <- stats::lm(formula = y ~ x1 + x2 + x3, data = df)
    b <- stats::coef(object = object)[-1]
    sds <- sapply(X = df, FUN = stats::sd)
    testthat::test_that(
      desc = paste(text, "selective standardization"),
      code = {
        nb <- NB(object = object, R = 1000L, seed = 42)
        raw <- BetaNB(
          object = nb,
          std_y = FALSE,
          std_x = character(length = 0)
        )
        testthat::expect_true(
          object = all(abs(x = stats::coef(object = raw) - b) <= tol)
        )
        dummy <- BetaNB(object = nb, std_x = c("x1", "x3"))
        testthat::expect_true(
          object = abs(
            x = stats::coef(object = dummy)["x2"] - b["x2"] / sds["y"]
          ) <= tol
        )
        testthat::expect_true(
          object = all(
            abs(
              x = sqrt(
                x = diag(x = stats::vcov(object = raw))
              ) / sqrt(x = diag(x = stats::vcov(object = object)))[-1] - 1
            ) <= 0.15
          )
        )
        for (type in c("pc", "bc", "bca")) {
          ci <- stats::confint(object = raw, type = type)
          testthat::expect_true(object = all(ci[, 1] < b & b < ci[, 2]))
        }
      }
    )
  },
  text = "test-betaNB-beta-nb-std",
  tol = 1e-10
)
