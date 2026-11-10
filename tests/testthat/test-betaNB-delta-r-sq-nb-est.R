## ---- test-betaNB-delta-r-sq-nb-est
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 R,
                 tol) {
    testthat::skip_on_cran()
    message(text)

    set.seed(seed = 42)

    testthat::test_that(
      desc = paste(text, "improvement in R-squared"),
      code = {
        if (!exists(x = "nas1982")) {
          try(
            expr = utils::data(
              "nas1982",
              package = "betaNB"
            ),
            silent = TRUE
          )
        }
        df <- nas1982
        object <- stats::lm(
          formula = QUALITY ~ NARTIC + PCTGRT + PCTSUPP,
          data = df
        )
        nb <- NB(object = object, R = R)
        out <- DeltaRSqNB(object = nb)
        print.betanb(x = out)
        summary.betanb(object = out)
        coef.betanb(object = out)
        vcov.betanb(object = out)
        confint.betanb(object = out)
        testthat::expect_true(
          object = all(
            abs(
              x = coef.betanb(object = out) - c(
                .1859,
                .1177,
                .0569
              )
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "error"),
      code = {
        if (!exists(x = "nas1982")) {
          try(
            expr = utils::data(
              "nas1982",
              package = "betaNB"
            ),
            silent = TRUE
          )
        }
        df <- nas1982
        object <- stats::lm(formula = QUALITY ~ NARTIC, data = df)
        nb <- NB(object = object, R = R)
        testthat::expect_error(
          object = DeltaRSqNB(object = nb)
        )
      }
    )
  },
  text = "test-betaNB-delta-r-sq-nb-est",
  R = 5L,
  tol = 0.0001
)
