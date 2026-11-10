#' Summarize Valid Intervals and All Attempts Separately
#' @author Ivan Jacob Agaloos Pesigan
#' @param cells List of complete cells read by `.WildValidationRead()`.
#' @param config Expected configuration, including planned replication count.
#' @return Summary including unattempted cells, failures, coverage MCSE
#'   and interval width.
#' @examples
#' # The make summary target reads existing cells without resampling.
#' @noRd
.WildValidationSummary <- function(cells, config) {
  rows <- if (length(x = cells) > 0) {
    do.call(what = "rbind", args = lapply(
      X = cells, FUN = function(cell) {
        cell$results
      }
    ))
  } else {
    NULL
  }
  grid <- expand.grid(
    taskid = config$design$taskid, sampler = config$samplers,
    type = config$types, target = seq_len(length.out = nrow(x = config$truth)),
    stringsAsFactors = FALSE
  )
  summaries <- lapply(
    X = seq_len(length.out = nrow(x = grid)),
    FUN = function(i) {
      key <- grid[i, ]
      truth <- config$truth[key$target, ]
      subset <- if (is.null(x = rows)) {
        data.frame()
      } else {
        rows[rows$taskid == key$taskid & rows$sampler == key$sampler &
          rows$type == key$type & rows$effect == truth$effect &
          rows$parameter == truth$parameter, , drop = FALSE]
      }
      attempted <- nrow(x = subset)
      valid <- sum(subset$valid)
      covered <- sum(subset$covered)
      coverage <- if (valid > 0) {
        covered / valid
      } else {
        NA_real_
      }
      data.frame(
        taskid = key$taskid, sampler = key$sampler, type = key$type,
        effect = truth$effect, parameter = truth$parameter, truth = truth$truth,
        expected = config$n_rep, attempted = attempted,
        missing = config$n_rep - attempted, valid = valid,
        failed = attempted - valid, covered = covered,
        coverage_valid = coverage,
        coverage_all = if (attempted > 0) {
          covered / attempted
        } else {
          NA_real_
        },
        mcse_valid = if (valid > 0) {
          sqrt(x = coverage * (1 - coverage) / valid)
        } else {
          NA_real_
        },
        mcse_all = if (attempted > 0) {
          rate <- covered / attempted
          sqrt(x = rate * (1 - rate) / attempted)
        } else {
          NA_real_
        },
        interval_below_valid = if (valid > 0) {
          sum(subset$interval_below) / valid
        } else {
          NA_real_
        },
        interval_above_valid = if (valid > 0) {
          sum(subset$interval_above) / valid
        } else {
          NA_real_
        },
        mean_width_valid = if (valid > 0) {
          mean(x = subset$width[subset$valid])
        } else {
          NA_real_
        },
        failure_rate = if (attempted > 0) {
          (attempted - valid) / attempted
        } else {
          NA_real_
        },
        infeasible_valid = if (valid > 0) {
          sum(subset$infeasible) / valid
        } else {
          NA_real_
        },
        mean_bootstrap_seconds = if (attempted > 0) {
          mean(x = subset$bootstrap_elapsed)
        } else {
          NA_real_
        },
        mean_interval_seconds = if (attempted > 0) {
          mean(x = subset$interval_elapsed)
        } else {
          NA_real_
        }
      )
    }
  )
  summary <- do.call(what = "rbind", args = summaries)
  condition <- config$design[match(
    x = summary$taskid,
    table = config$design$taskid
  ), ]
  summary$n <- condition$n
  summary$distribution <- condition$distribution
  summary$gamma <- condition$gamma
  summary
}
