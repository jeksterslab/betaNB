## ---- test-betaNB-r-sq-mc-est
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
    lm_summary <- summary(object)
    rsq <- lm_summary$r.squared
    adj <- lm_summary$adj.r.squared
    nb <- NB(object, R = R)
    out <- RSqNB(nb)
    print.betanb(out)
    summary.betanb(out)
    coef.betanb(out)
    vcov.betanb(out)
    confint.betanb(out)
    testthat::test_that(
      paste(text, "multiple regression", "coef"),
      {
        testthat::skip_on_cran()
        testthat::expect_true(
          all(
            abs(
              coef.betanb(out) - c(rsq, adj)
            ) <= tol
          )
        )
      }
    )
    object <- lm(QUALITY ~ NARTIC, data = df)
    lm_summary <- summary(object)
    rsq <- lm_summary$r.squared
    adj <- lm_summary$adj.r.squared
    nb <- NB(object, R = R)
    out <- RSqNB(nb)
    print.betanb(out)
    summary.betanb(out)
    coef.betanb(out)
    vcov.betanb(out)
    confint.betanb(out)
    testthat::test_that(
      paste(text, "simple regression"),
      {
        testthat::skip_on_cran()
        testthat::expect_true(
          all(
            abs(
              coef.betanb(out) - c(rsq, adj)
            ) <= tol
          )
        )
      }
    )
  },
  text = "test-betaNB-r-sq-mc-est",
  R = 5L,
  tol = 0.0001
)
