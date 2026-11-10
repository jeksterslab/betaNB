## ---- test-betaNB-mpc-ci-mat
lapply(
  X = 1,
  FUN = function(i, text) {
    testthat::skip_on_cran()
    index <- seq_len(length.out = 80)
    basis <- qr.Q(qr = qr(x = cbind(
      1, sin(x = index), cos(x = index),
      sin(x = index / 3), cos(x = index / 4)
    ))) * sqrt(x = 80)
    data <- data.frame(
      y = 0.9 * basis[, 2] + 0.3 * basis[, 3] +
        0.04 * basis[, 4] + basis[, 5],
      x1 = basis[, 2], x2 = basis[, 3], x3 = basis[, 4]
    )
    fit <- stats::lm(formula = y ~ x1 + x2 + x3, data = data)
    nb <- NB(object = fit, R = 40L, seed = 712)
    out <- DeltaRSqNB(object = nb, alpha = c(0.05, 0.001))
    adjusted <- DeltaRSqNB(object = nb, alpha = 0.05, adj = TRUE)
    coefficient_table <- summary(object = fit)$coefficients[-1, ]

    testthat::test_that(
      desc = paste(text, "sample F tests equal coefficient t tests"),
      code = {
        f_stat <- .DeltaRSqF(lm_process = nb$lm_process)
        testthat::expect_equal(
          object = unname(obj = f_stat),
          expected = unname(obj = coefficient_table[, "t value"]^2)
        )
        testthat::expect_equal(
          object = unname(obj = stats::pf(
            q = f_stat, df1 = 1, df2 = stats::df.residual(object = fit),
            lower.tail = FALSE
          )),
          expected = unname(obj = coefficient_table[, "Pr(>|t|)"])
        )
      }
    )

    testthat::test_that(
      desc = paste(text, "only nonsignificant unadjusted lower limits change"),
      code = {
        pc <- .CI(object = out, type = "pc")
        mpc <- .CI(object = out, type = "mpc")
        expected <- pc
        expected[c("x2", "x3"), 4] <- 0
        expected["x3", 5] <- 0
        testthat::expect_equal(object = mpc, expected = expected)
        testthat::expect_true(object = all(mpc[, 4:7] >= 0 & mpc[, 4:7] <= 1))
        testthat::expect_equal(
          object = unname(obj = stats::confint(
            object = out, parm = "x2", level = 0.999, type = "mpc"
          )[, 1]),
          expected = 0
        )
        testthat::expect_equal(
          object = unclass(x = summary(
            object = out, alpha = 0.05, type = "mpc"
          ))[, 4:5],
          expected = .CI(object = out, alpha = 0.05, type = "mpc")[, 4:5]
        )
      }
    )

    testthat::test_that(
      desc = paste(text, "adjusted estimates match full and reduced fits"),
      code = {
        reference <- vapply(
          X = nb$lm_process$xnames,
          FUN = function(name) {
            reduced <- stats::lm(
              formula = stats::reformulate(
                termlabels = setdiff(x = nb$lm_process$xnames, y = name),
                response = "y"
              ),
              data = data
            )
            summary(object = fit)$adj.r.squared -
              summary(object = reduced)$adj.r.squared
          },
          FUN.VALUE = numeric(length = 1)
        )
        testthat::expect_equal(object = adjusted$est, expected = reference)
        testthat::expect_identical(
          object = adjusted$fun, expected = "DeltaRSqAdjNB"
        )
        testthat::expect_true(object = adjusted$est[["x3"]] < 0)
        testthat::expect_equal(
          object = dim(x = adjusted$thetahatstar),
          expected = dim(x = out$thetahatstar)
        )
        set.seed(seed = 712)
        samples <- lapply(
          X = seq_len(length.out = 3),
          FUN = function(j) {
            sample.int(n = 80, size = 80, replace = TRUE)
          }
        )
        for (j in seq_len(length.out = 3)) {
          for (rows in list(samples[[j]], index[-j])) {
            subset <- data[rows, ]
            full <- stats::lm(formula = y ~ x1 + x2 + x3, data = subset)
            reference <- vapply(
              X = nb$lm_process$xnames,
              FUN = function(name) {
                reduced <- stats::lm(
                  formula = stats::reformulate(
                    termlabels = setdiff(x = nb$lm_process$xnames, y = name),
                    response = "y"
                  ),
                  data = subset
                )
                summary(object = full)$adj.r.squared -
                  summary(object = reduced)$adj.r.squared
              },
              FUN.VALUE = numeric(length = 1)
            )
            actual <- if (length(x = rows) == 80) {
              adjusted$thetahatstar[j, ]
            } else {
              adjusted$jackknife[j, ]
            }
            testthat::expect_equal(object = actual, expected = reference)
          }
        }
      }
    )

    testthat::test_that(
      desc = paste(text, "adjusted replacements cover all decision branches"),
      code = {
        controlled <- adjusted
        controlled$thetahatstar <- cbind(
          x1 = seq(from = -0.02, to = 0.2, length.out = 40),
          x2 = seq(from = 0.01, to = 0.2, length.out = 40),
          x3 = seq(from = -0.03, to = 0.1, length.out = 40)
        )
        pc <- .CI(object = controlled, type = "pc")
        expected <- pc
        expected["x1", 4] <- 0.001
        expected["x3", 4] <- 0
        testthat::expect_equal(
          object = .CI(object = controlled, type = "mpc"), expected = expected
        )
        testthat::expect_equal(
          object = stats::confint(
            object = controlled, level = 0.95, type = "mpc"
          )[, 1],
          expected = expected[, 4]
        )
        testthat::expect_output(
          object = print(x = summary(object = adjusted, type = "mpc")),
          regexp = "Improvement in adjusted R-squared"
        )
        # A positive adjusted lower limit is retained even without rejection.
        controlled$thetahatstar[, "x3"] <-
          controlled$thetahatstar[, "x2"]
        testthat::expect_equal(
          object = .CI(object = controlled, type = "mpc")["x3", ],
          expected = .CI(object = controlled, type = "pc")["x3", ]
        )
        # At the test threshold itself the decision is nonsignificant.
        threshold <- stats::pf(
          q = .DeltaRSqF(lm_process = nb$lm_process)[["x2"]],
          df1 = 1, df2 = nb$lm_process$df, lower.tail = FALSE
        )
        testthat::expect_identical(
          object = .CI(object = out, alpha = threshold, type = "mpc")["x2", 4],
          expected = 0
        )
      }
    )

    testthat::test_that(
      desc = paste(text, "other effects reject mpc and seeds are preserved"),
      code = {
        for (fun in list(BetaNB, RSqNB, SCorNB, PCorNB, DiffBetaNB, FSqNB)) {
          other <- fun(object = nb)
          testthat::expect_error(
            object = stats::confint(object = other, type = "mpc"),
            regexp = "only for Delta R-squared"
          )
          testthat::expect_error(
            object = summary(object = other, type = "mpc"),
            regexp = "only for Delta R-squared"
          )
        }
        set.seed(seed = 631)
        rng <- .Random.seed
        invisible(x = DeltaRSqNB(object = nb, adj = TRUE))
        invisible(x = .CI(object = adjusted, type = "mpc"))
        testthat::expect_identical(object = .Random.seed, expected = rng)
        repeated <- NB(object = fit, R = 40L, seed = 712)
        testthat::expect_identical(
          object = repeated$thetahatstar, expected = nb$thetahatstar
        )
        testthat::expect_identical(
          object = DeltaRSqNB(object = repeated, adj = TRUE)$thetahatstar,
          expected = adjusted$thetahatstar
        )
        for (type in c("pc", "bc", "bca")) {
          testthat::expect_equal(
            object = .CI(object = out, type = type),
            expected = .CIMat(
              thetahatstar = out$thetahatstar, thetahat = out$est,
              alpha = out$args$alpha, type = type, jackknife = out$jackknife
            )
          )
          testthat::expect_equal(
            object = .CI(object = adjusted, type = type),
            expected = .CIMat(
              thetahatstar = adjusted$thetahatstar, thetahat = adjusted$est,
              alpha = adjusted$args$alpha, type = type,
              jackknife = adjusted$jackknife
            )
          )
        }
      }
    )
  },
  text = "test-betaNB-mpc-ci-mat"
)
