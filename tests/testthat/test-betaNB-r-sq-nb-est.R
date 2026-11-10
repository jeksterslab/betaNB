## ---- test-betaNB-r-sq-mc-est
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
      desc = paste(text, "multiple regression", "coef"),
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
        lm_summary <- summary(object = object)
        rsq <- lm_summary$r.squared
        adj <- lm_summary$adj.r.squared
        nb <- NB(object = object, R = R)
        out <- RSqNB(object = nb)
        print.betanb(x = out)
        summary.betanb(object = out)
        coef.betanb(object = out)
        vcov.betanb(object = out)
        confint.betanb(object = out)
        testthat::expect_true(
          object = all(
            abs(
              x = coef.betanb(object = out) - c(rsq, adj)
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "simple regression"),
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
        lm_summary <- summary(object = object)
        rsq <- lm_summary$r.squared
        adj <- lm_summary$adj.r.squared
        nb <- NB(object = object, R = R)
        out <- RSqNB(object = nb)
        print.betanb(x = out)
        summary.betanb(object = out)
        coef.betanb(object = out)
        vcov.betanb(object = out)
        confint.betanb(object = out)
        testthat::expect_true(
          object = all(
            abs(
              x = coef.betanb(object = out) - c(rsq, adj)
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
