## ---- test-betaNB-beta-nb-est
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
    out <- BetaNB(nb)
    print.betanb(out)
    summary.betanb(out)
    coef.betanb(out)
    vcov.betanb(out)
    confint.betanb(out)
    confint.betanb(out, type = "bc")
    summary.betanb(out, type = "bc")
    print.betanb(out, type = "bc")
    confint.betanb(out, type = "bca")
    summary.betanb(out, type = "bca")
    print.betanb(out, type = "bca")
    testthat::test_that(
      paste(text, "multiple regression"),
      {
        testthat::expect_true(
          all(
            abs(
              coef.betanb(out) - c(
                .4951,
                .3915,
                .2632
              )
            ) <= tol
          )
        )
      }
    )
    object <- lm(QUALITY ~ NARTIC, data = df)
    nb <- NB(object, R = R)
    out <- BetaNB(nb)
    print.betanb(out)
    summary.betanb(out)
    coef.betanb(out)
    vcov.betanb(out)
    confint.betanb(out)
    confint.betanb(out, type = "bc")
    summary.betanb(out, type = "bc")
    print.betanb(out, type = "bc")
    confint.betanb(out, type = "bca")
    summary.betanb(out, type = "bca")
    print.betanb(out, type = "bca")
  },
  text = "test-betaNB-beta-nb-est",
  R = 5L,
  tol = 0.0001
)
