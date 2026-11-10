#' Read Only Complete, Compatible External Cell Records
#' @author Ivan Jacob Agaloos Pesigan
#' @param file Cell RDS path.
#' @param config Expected configuration.
#' @param taskid Expected condition ID.
#' @param repid Expected replication ID.
#' @return Validated cell; errors never trigger silent replacement.
#' @examples
#' # Called by .WildValidationRun() on existing cell files.
#' @noRd
.WildValidationRead <- function(file, config, taskid, repid) {
  stopifnot(
    taskid %in% config$design$taskid, repid >= 1,
    repid <= config$n_rep
  )
  cell <- readRDS(file = file)
  if (!identical(x = cell$config, y = config)) {
    stop("Incompatible validation configuration: ", file)
  }
  required <- c(
    "effect", "parameter", "truth", "minimum", "maximum", "estimate",
    "lower", "upper", "valid", "infeasible", "status", "error", "covered",
    "interval_below", "interval_above", "width", "taskid", "repid", "attempt",
    "seed_data", "seed_boot", "sampler", "type", "bootstrap_elapsed",
    "interval_elapsed"
  )
  rows <- cell$results
  grid <- expand.grid(
    sampler = config$samplers, type = config$types,
    target = seq_len(length.out = nrow(x = config$truth)),
    stringsAsFactors = FALSE
  )
  expected <- paste(
    grid$sampler, grid$type, config$truth$effect[grid$target],
    config$truth$parameter[grid$target],
    sep = ":"
  )
  if (!is.data.frame(x = rows) || !all(required %in% names(x = rows)) ||
    nrow(x = rows) != length(x = expected) ||
    !identical(x = cell$taskid, y = taskid) ||
    !identical(x = cell$repid, y = repid) ||
    !identical(x = cell$attempt, y = 1L)) {
    stop("Incomplete validation cell: ", file)
  }
  actual <- paste(
    rows$sampler, rows$type, rows$effect, rows$parameter,
    sep = ":"
  )
  valid <- rows$status == "ok" & is.finite(x = rows$estimate) &
    is.finite(x = rows$lower) & is.finite(x = rows$upper) &
    rows$lower <= rows$upper
  truth_index <- match(
    x = paste(rows$effect, rows$parameter),
    table = paste(config$truth$effect, config$truth$parameter)
  )
  seeds <- vapply(
    X = match(x = rows$sampler, table = config$samplers) + 1L,
    FUN = function(stream) {
      .WildValidationSeed(taskid = taskid, repid = repid, stream = stream)
    },
    FUN.VALUE = integer(length = 1)
  )
  checks <- c(
    setequal(x = actual, y = expected), !anyDuplicated(x = actual),
    all(rows$taskid == taskid), all(rows$repid == repid),
    all(rows$attempt == 1L), all(rows$seed_boot == seeds),
    all(rows$seed_data == .WildValidationSeed(
      taskid = taskid, repid = repid, stream = 1
    )),
    identical(x = rows$truth, y = config$truth$truth[truth_index]),
    identical(x = rows$minimum, y = config$truth$minimum[truth_index]),
    identical(x = rows$maximum, y = config$truth$maximum[truth_index]),
    is.character(x = rows$status), is.character(x = rows$error),
    !anyNA(x = rows$error),
    all(rows$status %in% c(
      "ok", "invalid_interval", "fit_error",
      "bootstrap_error", "effect_error", "interval_error"
    )),
    identical(x = rows$valid, y = valid),
    identical(
      x = rows$covered,
      y = valid & rows$lower <= rows$truth & rows$upper >= rows$truth
    ),
    identical(
      x = rows$infeasible,
      y = valid & (rows$lower < rows$minimum | rows$upper > rows$maximum)
    ),
    identical(x = rows$interval_below, y = valid & rows$upper < rows$truth),
    identical(x = rows$interval_above, y = valid & rows$lower > rows$truth),
    identical(
      x = rows$width,
      y = ifelse(test = valid, yes = rows$upper - rows$lower,
        no = NA_real_
      )
    ),
    all(is.finite(x = rows$bootstrap_elapsed)),
    all(rows$bootstrap_elapsed >= 0),
    all(is.finite(x = rows$interval_elapsed)), all(rows$interval_elapsed >= 0),
    is.numeric(x = cell$data_signature), length(x = cell$data_signature) == 20,
    all(is.finite(x = cell$data_signature)),
    length(x = cell$elapsed) == 1, is.finite(x = cell$elapsed),
    cell$elapsed >= 0
  )
  if (!isTRUE(x = all(checks))) {
    stop("Malformed validation cell: ", file)
  }
  cell
}
