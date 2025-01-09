## ---- test-betaNB-delta-r-sq-nb-est
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 R,
                 tol) {
    message(text)
    if (!exists("nas1982")) {
      try(
        data(
          "nas1982",
          package = "betaNB"
        ),
        silent = TRUE
      )
    }
    df <- nas1982
    object <- lm(QUALITY ~ NARTIC + PCTGRT + PCTSUPP, data = df)
    nb <- NB(object, R = R)
    out <- DeltaRSqNB(nb)
    print.betanb(out)
    summary.betanb(out)
    coef.betanb(out)
    vcov.betanb(out)
    confint.betanb(out)
    object <- lm(QUALITY ~ NARTIC, data = df)
    testthat::test_that(
      paste(text, "improvement in R-squared"),
      {
        testthat::skip_on_cran()
        testthat::expect_true(
          all(
            abs(
              coef.betanb(out) - c(
                .1859,
                .1177,
                .0569
              )
            ) <= tol
          )
        )
      }
    )
    nb <- NB(object, R = R)
    testthat::test_that(
      paste(text, "error"),
      {
        testthat::skip_on_cran()
        testthat::expect_error(
          DeltaRSqNB(nb)
        )
      }
    )
  },
  text = "test-betaNB-delta-r-sq-nb-est",
  R = 5L,
  tol = 0.0001
)
