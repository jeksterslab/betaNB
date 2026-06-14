## ---- test-betaNB-s-cor-nb-est
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 R,
                 tol) {
    message(text)

    set.seed(42)

    if (!identical(Sys.getenv("NOT_CRAN"), "true") && !interactive()) {
      message("CRAN: tests skipped.")
      # nolint start
      return(invisible(NULL))
      # nolint end
    }

    testthat::test_that(
      paste(text, "semipartial correlation coefficients"),
      {
        testthat::skip_on_cran()
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
        out <- SCorNB(nb)
        print.betanb(out)
        summary.betanb(out)
        coef.betanb(out)
        vcov.betanb(out)
        confint.betanb(out)
        testthat::expect_true(
          all(
            abs(
              coef.betanb(out) - c(
                .4312,
                .3430,
                .2385
              )
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "error"),
      {
        testthat::skip_on_cran()
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
        object <- lm(QUALITY ~ NARTIC, data = df)
        nb <- NB(object, R = R)
        testthat::expect_error(
          SCorNB(nb)
        )
      }
    )
  },
  text = "test-betaNB-s-cor-nb-est",
  R = 5L,
  tol = 0.0001
)
