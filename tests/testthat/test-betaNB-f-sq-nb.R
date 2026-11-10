## ---- test-betaNB-f-sq-nb
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 tol) {
    testthat::skip_on_cran()
    message(text)
    testthat::test_that(
      desc = paste(text, "f-squared"),
      code = {
        object <- stats::lm(
          formula = QUALITY ~ NARTIC + PCTGRT + PCTSUPP,
          data = nas1982
        )
        rsq <- summary(object = object)$r.squared
        nb <- NB(object = object, R = 100L, seed = 42)
        out <- FSqNB(object = nb)
        sr <- stats::coef(object = SCorNB(object = nb))
        testthat::expect_true(
          object = abs(
            x = stats::coef(object = out)[["fsq"]] - rsq / (1 - rsq)
          ) <= tol
        )
        testthat::expect_true(
          object = all(
            abs(x = stats::coef(object = out)[-1] - sr^2 / (1 - rsq)) <= tol
          )
        )
        draws <- as.matrix(x = nb$es$rsq)[, 1]
        testthat::expect_true(
          object = all(
            abs(x = out$thetahatstar[, "fsq"] - draws / (1 - draws)) <= tol
          )
        )
      }
    )
  },
  text = "test-betaNB-f-sq-nb",
  tol = 1e-10
)
