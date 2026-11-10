## ---- test-external-betaNB-wild-validation
lapply(
  X = 1,
  FUN = function(i, text) {
    testthat::skip_on_cran()
    config <- .WildValidationConfig(root = validation_root, n_rep = 2L, R = 49L)
    temporary <- tempfile(pattern = "betanb-validation-check-")
    dir.create(path = temporary)
    on.exit(expr = unlink(x = temporary, recursive = TRUE), add = TRUE)

    testthat::test_that(
      desc = paste(text, "population targets follow independent known values"),
      code = {
        truth <- .WildValidationTruth(sigma_x = diag(x = 3), b = c(0.5, 0, 0))
        testthat::expect_equal(
          object = truth$truth,
          expected = c(1 / sqrt(x = 5), 0, 0, 1 / sqrt(x = 5), 0, 0, 0.2)
        )
        testthat::expect_equal(object = nrow(x = config$design), expected = 8)
        testthat::expect_equal(object = nrow(x = config$truth), expected = 7)
        testthat::expect_error(
          object = .WildValidationConfig(root = validation_root, n_rep = 0),
          regexp = "n_rep"
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "seeds do not depend on run order or block size"),
      code = {
        grid <- expand.grid(
          taskid = 1:8, repid = c(1L, 2L, 1000000L),
          stream = 1:4
        )
        seeds <- vapply(
          X = seq_len(length.out = nrow(x = grid)),
          FUN = function(j) {
            .WildValidationSeed(
              taskid = grid$taskid[[j]],
              repid = grid$repid[[j]], stream = grid$stream[[j]]
            )
          },
          FUN.VALUE = integer(length = 1)
        )
        testthat::expect_false(object = anyDuplicated(x = seeds) > 0)
        testthat::expect_true(object = all(seeds < .Machine$integer.max))
        testthat::expect_identical(
          object = .WildValidationSeed(taskid = 8, repid = 1000000, stream = 4),
          expected = 127999988L
        )
        testthat::expect_error(
          object = .WildValidationSeed(taskid = 1, repid = 1000001, stream = 1)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "random predictors retain sample moment variation"),
      code = {
        data <- .WildValidationData(
          condition = config$design[1, ], config = config, seed = 42
        )
        testthat::expect_identical(
          object = data,
          expected = .WildValidationData(
            condition = config$design[1, ], config = config, seed = 42
          )
        )
        testthat::expect_false(object = all(colMeans(x = data[-1]) == 0))
        testthat::expect_false(
          object = all(diag(x = stats::cov(x = data[-1])) == 1)
        )
        hetero <- .WildValidationData(
          condition = config$design[5, ], config = config, seed = 42
        )
        testthat::expect_identical(object = data[-1], expected = hetero[-1])
        skew <- .WildValidationData(
          condition = config$design[3, ], config = config, seed = 42
        )
        testthat::expect_equal(object = dim(x = skew), expected = c(100L, 4L))
      }
    )
    testthat::test_that(
      desc = paste(text, "shares data and retains failures"),
      code = {
        seen <- list()
        sampler <- function(object, R, seed, type, x, hc, weights) {
          seen[[length(x = seen) + 1L]] <<- list(
            data = stats::model.frame(formula = object), seed = seed,
            type = type, x = x
          )
          stop("injected bootstrap failure")
        }
        cell <- .WildValidationCell(
          config = config, taskid = 1L, repid = 1L, sampler = sampler
        )
        testthat::expect_length(object = seen, n = 3)
        testthat::expect_identical(
          object = seen[[1]]$data, expected = seen[[2]]$data
        )
        testthat::expect_identical(
          object = seen[[1]]$data, expected = seen[[3]]$data
        )
        testthat::expect_equal(object = nrow(x = cell$results), expected = 63)
        testthat::expect_true(
          object = all(cell$results$status == "bootstrap_error")
        )
        testthat::expect_true(
          object = all(!cell$results$valid & !cell$results$covered)
        )
        testthat::expect_true(
          object = all(cell$results$error == "injected bootstrap failure")
        )
        testthat::expect_identical(object = seen[[2]]$x, expected = "fixed")
        testthat::expect_identical(object = seen[[3]]$x, expected = "random")
      }
    )
    testthat::test_that(
      desc = paste(text, "invalid and infeasible endpoints are not clipped"),
      code = {
        truth <- config$truth[rep(x = 7, times = 6), ]
        truth$truth <- 0.5
        rows <- .WildValidationResult(
          truth = truth, estimate = 0.5,
          lower = c(0.4, 0.6, 0.2, 0.4, 0.8, -0.1),
          upper = c(0.6, 0.8, 0.4, Inf, 0.7, 0.6)
        )
        testthat::expect_identical(
          object = rows$valid,
          expected = c(TRUE, TRUE, TRUE, FALSE, FALSE, TRUE)
        )
        testthat::expect_identical(
          object = rows$covered,
          expected = c(TRUE, FALSE, FALSE, FALSE, FALSE, TRUE)
        )
        testthat::expect_true(object = rows$interval_above[[2]])
        testthat::expect_true(object = rows$interval_below[[3]])
        testthat::expect_true(object = rows$infeasible[[6]])
        testthat::expect_equal(object = rows$lower[[6]], expected = -0.1)
        testthat::expect_true(object = is.infinite(x = rows$upper[[4]]))
      }
    )
    testthat::test_that(
      desc = paste(text, "coverage denominators include failures"),
      code = {
        summary_config <- config
        summary_config$n_rep <- 3L
        rows <- .WildValidationResult(
          truth = config$truth[rep(x = 7, times = 3), ],
          estimate = config$truth$truth[[7]],
          lower = c(0, 0.9, NA_real_), upper = c(0.8, 1, NA_real_)
        )
        rows$taskid <- 1L
        rows$sampler <- "pairs"
        rows$type <- "pc"
        rows$bootstrap_elapsed <- 1
        rows$interval_elapsed <- 0.01
        summary <- .WildValidationSummary(
          cells = list(list(results = rows)), config = summary_config
        )
        target <- summary[summary$taskid == 1 & summary$sampler == "pairs" &
          summary$type == "pc" & summary$effect == "rsq", ]
        testthat::expect_equal(object = target$attempted, expected = 3)
        testthat::expect_equal(object = target$valid, expected = 2)
        testthat::expect_equal(object = target$failed, expected = 1)
        testthat::expect_equal(object = target$coverage_valid, expected = 0.5)
        testthat::expect_equal(object = target$coverage_all, expected = 1 / 3)
        testthat::expect_equal(
          object = target$mcse_valid, expected = sqrt(x = 0.125)
        )
        testthat::expect_equal(
          object = target$mean_width_valid, expected = 0.45
        )
        testthat::expect_true(
          object = all(summary$missing[summary$taskid == 2] == 3)
        )
      }
    )
    testthat::test_that(
      desc = paste(text, "resume validates files without drawing again"),
      code = {
        output <- file.path(temporary, "resume")
        calls <- 0L
        sampler <- function(object, R, seed, type, x, hc, weights) {
          calls <<- calls + 1L
          stop("injected failure")
        }
        first <- .WildValidationRun(
          config = config, output = output, taskids = 1L, repids = 1L,
          sampler = sampler
        )
        second <- .WildValidationRun(
          config = config, output = output, taskids = 1L, repids = 1L,
          sampler = sampler
        )
        testthat::expect_equal(object = first$completed, expected = 1)
        testthat::expect_equal(object = second$resumed, expected = 1)
        testthat::expect_equal(object = second$completed, expected = 0)
        testthat::expect_equal(object = calls, expected = 3)
        path <- file.path(output, "task-01-rep-0000001.rds")
        before <- tools::md5sum(files = path)
        incompatible <- config
        incompatible$R <- 99L
        testthat::expect_error(
          object = .WildValidationRun(
            config = incompatible, output = output, taskids = 1L, repids = 1L
          ),
          regexp = "Incompatible"
        )
        testthat::expect_identical(
          object = tools::md5sum(files = path), expected = before
        )
        full <- readRDS(file = path)
        cell <- full
        cell$results <- cell$results[-1, ]
        saveRDS(object = cell, file = path, compress = "xz")
        corrupt <- tools::md5sum(files = path)
        testthat::expect_error(
          object = .WildValidationRun(
            config = config, output = output, taskids = 1L, repids = 1L
          ),
          regexp = "Incomplete"
        )
        testthat::expect_identical(
          object = tools::md5sum(files = path), expected = corrupt
        )
        testthat::expect_false(
          object = dir.exists(paths = file.path(output, ".running"))
        )
        full$results$width[[1]] <- 1
        saveRDS(object = full, file = path, compress = "xz")
        testthat::expect_error(
          object = .WildValidationRead(
            file = path, config = config, taskid = 1L, repid = 1L
          ),
          regexp = "Malformed"
        )
      }
    )
  },
  text = "test-external-betaNB-wild-validation"
)
