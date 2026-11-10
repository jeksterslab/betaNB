#' Run or Resume Selected External Comparison Cells
#' @author Ivan Jacob Agaloos Pesigan
#' @param config Validated comparison configuration.
#' @param output Results directory, separate for smoke and full runs.
#' @param taskids Condition IDs; NULL selects all eight.
#' @param repids Replication IDs; NULL selects all configured replications.
#' @param sampler Bootstrap function, injectable for correctness tests.
#' @return Counts and wall time; writes atomic compressed cell files.
#' @examples
#' # The make smoke target selects task 1 and two replications.
#' @noRd
.WildValidationRun <- function(config, output, taskids = NULL, repids = NULL,
                               sampler = betaNB::NB) {
  started <- proc.time()
  if (is.null(x = taskids)) {
    taskids <- config$design$taskid
  }
  if (is.null(x = repids)) {
    repids <- seq_len(length.out = config$n_rep)
  }
  stopifnot(
    length(x = taskids) > 0, !anyDuplicated(x = taskids),
    all(taskids %in% config$design$taskid),
    length(x = repids) > 0, !anyDuplicated(x = repids),
    all(repids >= 1 & repids <= config$n_rep & repids == floor(x = repids))
  )
  dir.create(path = output, recursive = TRUE, showWarnings = FALSE)
  lock <- file.path(output, ".running")
  if (!dir.create(path = lock, showWarnings = FALSE)) {
    stop(
      "Validation lock exists: ", lock,
      ". Inspect the process before removing an abandoned lock."
    )
  }
  on.exit(expr = unlink(x = lock, recursive = TRUE), add = TRUE)
  writeLines(
    text = paste(Sys.info()[["nodename"]], Sys.getpid()),
    con = file.path(lock, "owner")
  )
  config_file <- file.path(output, "config.rds")
  if (file.exists(file = config_file)) {
    if (!identical(x = readRDS(file = config_file), y = config)) {
      stop(
        "Incompatible validation configuration; ",
        "choose a new output directory."
      )
    }
  } else {
    partial <- tempfile(pattern = ".config-", tmpdir = output)
    saveRDS(object = config, file = partial, compress = "xz")
    if (!file.rename(from = partial, to = config_file)) {
      stop("Cannot atomically write validation configuration.")
    }
  }
  completed <- 0L
  resumed <- 0L
  for (taskid in as.integer(x = taskids)) {
    for (repid in as.integer(x = repids)) {
      path <- file.path(output, sprintf(
        fmt = "task-%02d-rep-%07d.rds",
        taskid, repid
      ))
      if (file.exists(file = path)) {
        invisible(x = .WildValidationRead(
          file = path, config = config, taskid = taskid, repid = repid
        ))
        resumed <- resumed + 1L
      } else {
        cell <- .WildValidationCell(
          config = config, taskid = taskid, repid = repid, sampler = sampler
        )
        partial <- tempfile(pattern = ".cell-", tmpdir = output)
        saveRDS(object = cell, file = partial, compress = "xz")
        if (file.info(paths = partial)$size >= 50 * 1024^2) {
          stop("Validation cell exceeds 50 MB: ", partial)
        }
        invisible(x = .WildValidationRead(
          file = partial, config = config, taskid = taskid, repid = repid
        ))
        if (!file.rename(from = partial, to = path)) {
          stop("Cannot atomically write validation cell: ", path)
        }
        completed <- completed + 1L
      }
      message("taskid: ", taskid, " repid: ", repid, " saved/resumed")
    }
  }
  list(
    completed = completed, resumed = resumed,
    elapsed = (proc.time() - started)[["elapsed"]]
  )
}
