## ---- test-betaNB-beta-nb-std
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 tol) {
    message(text)
    if (!identical(Sys.getenv("NOT_CRAN"), "true") && !interactive()) {
      message("CRAN: tests skipped.")
      # nolint start
      return(invisible(NULL))
      # nolint end
    }
    set.seed(42)
    n <- 200
    x1 <- rnorm(n)
    x2 <- rbinom(n, size = 1, prob = 0.4)
    x3 <- rnorm(n) + 0.5 * x1
    y <- 0.4 * x1 + 0.3 * x2 - 0.2 * x3 + rnorm(n)
    df <- data.frame(y = y, x1 = x1, x2 = x2, x3 = x3)
    object <- lm(y ~ x1 + x2 + x3, data = df)
    b <- coef(object)[-1]
    sds <- sapply(df, sd)
    testthat::test_that(
      paste(text, "selective standardization"),
      {
        testthat::skip_on_cran()
        nb <- NB(object, R = 1000L, seed = 42)
        raw <- BetaNB(nb, std_y = FALSE, std_x = character(0))
        testthat::expect_true(all(abs(coef(raw) - b) <= tol))
        dummy <- BetaNB(nb, std_x = c("x1", "x3"))
        testthat::expect_true(
          abs(coef(dummy)["x2"] - b["x2"] / sds["y"]) <= tol
        )
        testthat::expect_true(
          all(
            abs(
              sqrt(diag(vcov(raw))) / sqrt(diag(vcov(object)))[-1] - 1
            ) <= 0.15
          )
        )
        for (type in c("pc", "bc", "bca")) {
          ci <- confint(raw, type = type)
          testthat::expect_true(all(ci[, 1] < b & b < ci[, 2]))
        }
      }
    )
  },
  text = "test-betaNB-beta-nb-std",
  tol = 1e-10
)
