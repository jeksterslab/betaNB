#' One Paired External Comparison Replication
#' @author Ivan Jacob Agaloos Pesigan
#' @param config Validated configuration.
#' @param taskid Design condition ID.
#' @param repid Replication ID.
#' @param sampler Bootstrap function; injectable for failure/data-sharing tests.
#' @return Cell record with 63 interval attempts, seeds and timing.
#' @examples
#' config <- .WildValidationConfig(root = getwd(), n_rep = 2, R = 49)
#' .WildValidationCell(config = config, taskid = 1, repid = 1)
#' @noRd
.WildValidationCell <- function(config, taskid, repid, sampler = betaNB::NB) {
  started <- proc.time()
  condition <- config$design[config$design$taskid == taskid, ]
  seed_data <- .WildValidationSeed(taskid = taskid, repid = repid, stream = 1)
  data <- .WildValidationData(
    condition = condition, config = config, seed = seed_data
  )
  fit <- tryCatch(
    expr = stats::lm(formula = y ~ x1 + x2 + x3, data = data),
    error = function(e) {
      e
    }
  )
  results <- list()
  functions <- list(
    beta = betaNB::BetaNB, sr = betaNB::SCorNB,
    rsq = betaNB::RSqNB
  )
  for (j in seq_along(along.with = config$samplers)) {
    name <- config$samplers[[j]]
    seed_boot <- .WildValidationSeed(
      taskid = taskid, repid = repid, stream = j + 1
    )
    boot_start <- proc.time()
    nb <- if (inherits(x = fit, what = "error")) {
      fit
    } else {
      tryCatch(
        expr = sampler(
          object = fit, R = config$R, seed = seed_boot,
          type = if (j == 1) {
            "pairs"
          } else {
            "wild"
          },
          x = if (j == 2) {
            "fixed"
          } else {
            "random"
          },
          hc = config$hc, weights = config$weights
        ),
        error = function(e) {
          e
        }
      )
    }
    boot_elapsed <- (proc.time() - boot_start)[["elapsed"]]
    for (effect in names(x = functions)) {
      targets <- config$truth[config$truth$effect == effect, ]
      object <- if (inherits(x = nb, what = "error")) {
        nb
      } else {
        tryCatch(
          expr = functions[[effect]](object = nb, alpha = config$alpha),
          error = function(e) {
            e
          }
        )
      }
      for (type in config$types) {
        ci_start <- proc.time()
        ci <- if (inherits(x = object, what = "error")) {
          object
        } else {
          tryCatch(
            expr = stats::confint(
              object = object, parm = targets$parameter,
              level = 1 - config$alpha, type = type
            ),
            error = function(e) {
              e
            }
          )
        }
        interval_elapsed <- (proc.time() - ci_start)[["elapsed"]]
        rows <- if (inherits(x = ci, what = "error")) {
          stage <- if (inherits(x = fit, what = "error")) {
            "fit_error"
          } else if (inherits(x = nb, what = "error")) {
            "bootstrap_error"
          } else if (inherits(x = object, what = "error")) {
            "effect_error"
          } else {
            "interval_error"
          }
          .WildValidationResult(
            truth = targets, status = stage, error = conditionMessage(c = ci)
          )
        } else {
          .WildValidationResult(
            truth = targets,
            estimate = stats::coef(object = object)[targets$parameter],
            lower = ci[, 1], upper = ci[, 2]
          )
        }
        rows$taskid <- taskid
        rows$repid <- repid
        rows$attempt <- 1L
        rows$seed_data <- seed_data
        rows$seed_boot <- seed_boot
        rows$sampler <- name
        rows$type <- type
        rows$bootstrap_elapsed <- boot_elapsed
        rows$interval_elapsed <- interval_elapsed
        results[[length(x = results) + 1L]] <- rows
      }
    }
  }
  list(
    config = config, taskid = taskid, repid = repid, attempt = 1L,
    data_signature = c(
      colMeans(x = data), as.vector(x = crossprod(x = as.matrix(x = data)))
    ),
    elapsed = (proc.time() - started)[["elapsed"]],
    results = do.call(what = "rbind", args = results)
  )
}
