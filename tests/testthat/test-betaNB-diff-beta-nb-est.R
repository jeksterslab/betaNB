## ---- test-betaNB-diff-beta-nb-est
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
    out <- DiffBetaNB(nb)
    print.betanb(out)
    summary.betanb(out)
    coef.betanb(out)
    vcov.betanb(out)
    confint.betanb(out)
    testthat::test_that(
      paste(text, "differences of standardized slopes"),
      {
        testthat::expect_true(
          all(
            abs(
              coef.betanb(out) - c(
                .4951 - .3915,
                .4951 - .2632,
                .3915 - .2632
              )
            ) <= tol
          )
        )
      }
    )
    object <- lm(QUALITY ~ NARTIC, data = df)
    nb <- NB(object, R = R)
    testthat::test_that(
      paste(text, "error"),
      {
        testthat::expect_error(
          DiffBetaNB(nb)
        )
      }
    )
  },
  text = "test-betaNB-diff-beta-nb-est",
  R = 5L,
  tol = 0.0001
)
