## ---- test-betaNB-beta-nb-est
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
      desc = paste(text, "multiple regression"),
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
        out <- BetaNB(object = nb)
        print.betanb(x = out)
        summary.betanb(object = out)
        print.summary.betanb(x = summary.betanb(object = out))
        coef.betanb(object = out)
        vcov.betanb(object = out)
        confint.betanb(object = out)
        confint.betanb(object = out, type = "bc")
        summary.betanb(object = out, type = "bc")
        print.summary.betanb(x = summary.betanb(object = out, type = "bc"))
        print.betanb(x = out, type = "bc")
        confint.betanb(object = out, type = "bca")
        summary.betanb(object = out, type = "bca")
        print.summary.betanb(x = summary.betanb(object = out, type = "bca"))
        print.betanb(x = out, type = "bca")
        testthat::expect_true(
          object = all(
            abs(
              x = coef.betanb(object = out) - c(
                .4951,
                .3915,
                .2632
              )
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "simple linear regression"),
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
        out <- BetaNB(object = nb)
        print.betanb(x = out)
        summary.betanb(object = out)
        print.summary.betanb(x = summary.betanb(object = out))
        coef.betanb(object = out)
        vcov.betanb(object = out)
        confint.betanb(object = out)
        confint.betanb(object = out, type = "bc")
        summary.betanb(object = out, type = "bc")
        print.summary.betanb(x = summary.betanb(object = out, type = "bc"))
        print.betanb(x = out, type = "bc")
        confint.betanb(object = out, type = "bca")
        summary.betanb(object = out, type = "bca")
        print.summary.betanb(x = summary.betanb(object = out, type = "bca"))
        print.betanb(x = out, type = "bca")
        testthat::expect_true(
          object = TRUE
        )
      }
    )
  },
  text = "test-betaNB-beta-nb-est",
  R = 5L,
  tol = 0.0001
)
