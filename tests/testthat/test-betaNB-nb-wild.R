## ---- test-betaNB-nb-wild
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 n,
                 R) {
    testthat::skip_on_cran()
    message(text)

    set.seed(seed = 42)
    x1 <- stats::rnorm(n = n)
    x2 <- stats::rnorm(n = n)
    y <- 1 + 0.5 * x1 + 0.3 * x2 + exp(x = 0.5 * x1) * stats::rnorm(n = n)
    data <- data.frame(y = y, x1 = x1, x2 = x2)
    object <- stats::lm(formula = y ~ x1 + x2, data = data)
    lm_process <- .ProcessLM(object = object)

    testthat::test_that(
      desc = paste(text, "pairs is the default and unchanged"),
      code = {
        nb_default <- NB(object = object, R = R, seed = 1)
        nb_pairs <- NB(object = object, R = R, seed = 1, type = "pairs")
        testthat::expect_identical(
          object = nb_default$thetahatstar,
          expected = nb_pairs$thetahatstar
        )
        set.seed(seed = 1)
        testthat::expect_identical(
          object = nb_pairs$thetahatstar,
          expected = .NBVechCovDraws(x = lm_process$x, R = R)
        )
      }
    )

    testthat::test_that(
      desc = paste(text, "weights have mean 0 and variance 1"),
      code = {
        set.seed(seed = 1)
        for (weights in c("rademacher", "mammen", "webb", "normal")) {
          v <- .WildWeights(size = 2e5, weights = weights)
          testthat::expect_equal(
            object = mean(x = v),
            expected = 0,
            tolerance = 0.02
          )
          testthat::expect_equal(
            object = mean(x = v^2),
            expected = 1,
            tolerance = 0.02
          )
        }
        v <- .WildWeights(size = 2e5, weights = "mammen")
        testthat::expect_equal(
          object = mean(x = v^3),
          expected = 1,
          tolerance = 0.05
        )
        testthat::expect_error(object = .WildWeights(size = 2, weights = "x"))
      }
    )

    testthat::test_that(
      desc = paste(
        text,
        "fixed regressors keep the covariance of the regressors"
      ),
      code = {
        nb <- NB(object = object, R = R, seed = 1, type = "wild", x = "fixed")
        k <- lm_process$k
        testthat::expect_identical(
          object = dim(x = nb$thetahatstar),
          expected = c(as.integer(x = R), as.integer(x = k * (k + 1) / 2))
        )
        # columns of the regressors: all but the first k (y row of vech)
        sxx <- .Vech(x = lm_process$sigmacapx)
        sxx_draws <- nb$thetahatstar[, -seq_len(length.out = k), drop = FALSE]
        testthat::expect_equal(
          object = unname(obj = sxx_draws[1, ]),
          expected = sxx,
          tolerance = 1e-10
        )
        testthat::expect_equal(
          object = apply(X = sxx_draws, MARGIN = 2, FUN = stats::sd),
          expected = rep(x = 0, times = length(x = sxx)),
          tolerance = 1e-10
        )
        # the layout equals the pairs layout
        testthat::expect_identical(
          object = dim(x = nb$thetahatstar),
          expected = dim(x = NB(object = object, R = R, seed = 1)$thetahatstar)
        )
      }
    )

    testthat::test_that(
      desc = paste(
        text,
        "fixed wild covariance of slopes is the HC covariance"
      ),
      code = {
        for (hc in c("hc0", "hc3")) {
          nb <- NB(
            object = object,
            R = 20000L,
            seed = 2,
            type = "wild",
            x = "fixed",
            hc = hc
          )
          k <- lm_process$k
          sigmacapx <- lm_process$sigmacapx
          # slopes of every draw: Sxx^{-1} Sxy
          sxy <- nb$thetahatstar[, 2:k, drop = FALSE]
          slopes <- t(x = solve(a = sigmacapx, b = t(x = sxy)))
          xc <- sweep(
            x = lm_process$x[, -1, drop = FALSE],
            MARGIN = 2,
            STATS = colMeans(x = lm_process$x[, -1, drop = FALSE])
          )
          s <- .WildScale(
            h = stats::hatvalues(model = object),
            k = k,
            df = lm_process$df,
            type = hc
          )
          e <- stats::residuals(object = object)
          bread <- solve(a = crossprod(x = xc))
          hc_cov <- bread %*% crossprod(x = xc * (s * e)) %*% bread
          testthat::expect_equal(
            object = unname(obj = stats::cov(x = slopes)),
            expected = unname(obj = hc_cov),
            tolerance = 0.06
          )
        }
      }
    )

    testthat::test_that(
      desc = paste(text, "every hc, weights, and x runs and reproduces"),
      code = {
        for (hc in c("hc0", "hc1", "hc2", "hc3", "hc4", "hc4m", "hc5")) {
          for (x in c("random", "fixed")) {
            a <- NB(
              object = object,
              R = 20,
              seed = 3,
              type = "wild",
              hc = hc,
              x = x
            )
            b <- NB(
              object = object,
              R = 20,
              seed = 3,
              type = "wild",
              hc = hc,
              x = x
            )
            testthat::expect_identical(
              object = a$thetahatstar,
              expected = b$thetahatstar
            )
            testthat::expect_true(object = all(is.finite(x = a$thetahatstar)))
          }
        }
        for (weights in c("rademacher", "mammen", "webb", "normal")) {
          nb <- NB(
            object = object,
            R = 20,
            seed = 3,
            type = "wild",
            weights = weights
          )
          testthat::expect_true(object = all(is.finite(x = nb$thetahatstar)))
        }
        testthat::expect_error(
          object = NB(object = object, R = 20, type = "wild", hc = "x")
        )
      }
    )

    testthat::test_that(
      desc = paste(text, "effect size functions accept wild draws"),
      code = {
        for (x in c("random", "fixed")) {
          nb <- NB(object = object, R = 100, seed = 4, type = "wild", x = x)
          for (fun in c(
            BetaNB, RSqNB, SCorNB, PCorNB, DeltaRSqNB, DiffBetaNB, FSqNB
          )) {
            out <- fun(object = nb, alpha = 0.05)
            testthat::expect_true(
              object = all(
                is.finite(x = stats::confint(object = out, level = 0.95))
              )
            )
          }
        }
      }
    )

    testthat::test_that(
      desc = paste(text, "a leverage of 1 stops hc2 to hc5"),
      code = {
        d <- data
        d$x1[1] <- 1000
        d$g <- as.numeric(x = seq_len(length.out = n) == 1)
        fit <- stats::lm(formula = y ~ x1 + g, data = d)
        testthat::expect_error(
          object = NB(object = fit, R = 10, type = "wild", hc = "hc3")
        )
        testthat::expect_error(
          object = NB(object = fit, R = 10, type = "wild", hc = "hc5")
        )
        testthat::expect_no_error(
          object = NB(object = fit, R = 10, type = "wild", hc = "hc0")
        )
      }
    )

    testthat::test_that(
      desc = paste(text, "scale matches betaSandwich"),
      code = {
        testthat::skip_if_not_installed(pkg = "betaSandwich")
        h <- stats::hatvalues(model = object)
        for (hc in c("hc0", "hc2", "hc3", "hc4", "hc4m", "hc5")) {
          q <- utils::getFromNamespace(x = ".QMat", ns = "betaSandwich")(
            h = h,
            k = lm_process$k,
            type = hc
          )
          testthat::expect_equal(
            object = .WildScale(
              h = h,
              k = lm_process$k,
              df = lm_process$df,
              type = hc
            )^2,
            expected = q
          )
        }
      }
    )
  },
  text = "test-betaNB-nb-wild",
  n = 100,
  R = 200L
)
