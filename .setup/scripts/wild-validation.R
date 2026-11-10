# Run external validation checks, selected cells, or summaries.
# Usage: make -f .setup/scripts/wild-validation.mk wild-<action>
# Actions: check, smoke, run, summary.
root <- normalizePath(path = getwd())
args <- commandArgs(trailingOnly = TRUE)
stopifnot(
  length(x = args) == 1, args %in% c("check", "smoke", "run", "summary")
)
action <- args[[1]]
helper_env <- new.env(parent = globalenv())
for (file in list.files(
  path = ".setup/tests-external/helpers", pattern = "\\.R$", full.names = TRUE
)) {
  sys.source(file = file, envir = helper_env)
}
cache <- Sys.getenv(
  x = "BETANB_WILD_CACHE",
  unset = file.path(root, ".setup/data-cache/wild-validation")
)
ready_file <- file.path(cache, "build-ready.rds")
if (!file.exists(file = ready_file)) {
  stop("Run make -f .setup/scripts/wild-validation.mk wild-prepare first.")
}
ready <- readRDS(file = ready_file)
current_sources <- helper_env$.WildValidationSources(root = root)
if (!identical(x = ready$sources, y = current_sources)) {
  stop("Validation sources changed; rerun the wild-prepare target.")
}
.libPaths(new = c(ready$library, .libPaths()))
loadNamespace(package = "betaNB", lib.loc = ready$library)
helper_env$validation_root <- root
if (action == "check") {
  testthat::test_file(
    path = ".setup/tests-external/test-external-betaNB-wild-validation.R",
    reporter = "summary", env = helper_env, stop_on_failure = TRUE
  )
} else {
  n_rep <- as.integer(x = Sys.getenv(x = "BETANB_WILD_REPS", unset = "1000"))
  draws <- as.integer(x = Sys.getenv(x = "BETANB_WILD_DRAWS", unset = "1999"))
  if (action == "smoke") {
    n_rep <- 2L
    draws <- 49L
  }
  output <- Sys.getenv(
    x = "BETANB_WILD_OUT",
    unset = file.path(cache, if (action == "smoke") {
      "smoke"
    } else {
      "run"
    })
  )
  if (action == "summary") {
    stored <- readRDS(file = file.path(output, "config.rds"))
    n_rep <- stored$n_rep
    draws <- stored$R
  }
  config <- helper_env$.WildValidationConfig(
    root = root, n_rep = n_rep, R = draws
  )
  if (action == "summary" && !identical(x = config, y = stored)) {
    stop("Stored results use a different configuration or source version.")
  }
  if (action != "summary") {
    tasks <- Sys.getenv(x = "BETANB_WILD_TASKS", unset = "")
    tasks <- if (nzchar(x = tasks)) {
      as.integer(x = strsplit(x = tasks, split = ",", fixed = TRUE)[[1]])
    } else {
      config$design$taskid
    }
    first <- as.integer(x = Sys.getenv(x = "BETANB_WILD_FROM", unset = "1"))
    last <- as.integer(x = Sys.getenv(
      x = "BETANB_WILD_TO", unset = as.character(x = n_rep)
    ))
    stopifnot(
      !is.na(x = first), !is.na(x = last), first >= 1, first <= last,
      last <= n_rep
    )
    if (action == "smoke") {
      tasks <- 1L
      first <- 1L
      last <- 2L
    }
    helper_env$validation_request <- list(
      config = config, output = output, taskids = tasks,
      repids = seq.int(from = first, to = last)
    )
    sys.source(
      file = ".setup/tests-external/test-external-betaNB-nb-wild-coverage.R",
      envir = helper_env
    )
  }
  if (dir.exists(paths = file.path(output, ".running"))) {
    stop("Validation is running; summarize after the active run finishes.")
  }
  paths <- list.files(
    path = output, pattern = "^task-[0-9]+-rep-[0-9]+\\.rds$", full.names = TRUE
  )
  cells <- lapply(
    X = paths,
    FUN = function(path) {
      fields <- strsplit(
        x = sub(
          pattern = "\\.rds$", replacement = "", x = basename(path = path)
        ),
        split = "-", fixed = TRUE
      )[[1]]
      helper_env$.WildValidationRead(
        file = path, config = config, taskid = as.integer(x = fields[[2]]),
        repid = as.integer(x = fields[[4]])
      )
    }
  )
  summary <- helper_env$.WildValidationSummary(cells = cells, config = config)
  partial <- tempfile(pattern = ".summary-", tmpdir = output)
  utils::write.csv(x = summary, file = partial, row.names = FALSE)
  if (!file.rename(from = partial, to = file.path(output, "summary.csv"))) {
    stop("Cannot atomically write summary.csv.")
  }
  timing <- if (length(x = cells) > 0) {
    do.call(what = "rbind", args = lapply(
      X = cells, FUN = function(cell) {
        data.frame(
          taskid = cell$taskid, repid = cell$repid, seconds = cell$elapsed
        )
      }
    ))
  } else {
    data.frame(
      taskid = integer(length = 0), repid = integer(length = 0),
      seconds = numeric(length = 0)
    )
  }
  partial <- tempfile(pattern = ".timing-", tmpdir = output)
  utils::write.csv(x = timing, file = partial, row.names = FALSE)
  if (!file.rename(from = partial, to = file.path(output, "timing.csv"))) {
    stop("Cannot atomically write timing.csv.")
  }
  cat("Saved summary: ", file.path(output, "summary.csv"), "\n", sep = "")
  cat("Complete cells: ", length(x = cells), "; interval attempts: ",
    sum(vapply(
      X = cells, FUN = function(cell) {
        nrow(x = cell$results)
      },
      FUN.VALUE = integer(length = 1)
    )), "\n",
    sep = ""
  )
  if (action == "smoke") {
    smoke_results <- do.call(what = "rbind", args = lapply(
      X = cells, FUN = function(cell) {
        cell$results
      }
    ))
    if (length(x = cells) != 2 || any(!smoke_results$valid)) {
      stop(
        "Smoke execution has missing cells or failed/invalid intervals; ",
        "inspect the saved cell records."
      )
    }
    cat("Smoke execution: all 126 interval attempts are valid.\n")
    mean_seconds <- mean(x = timing$seconds)
    cat("Mean smoke cell seconds: ", mean_seconds, "\n", sep = "")
    cat("Rough full-run hours (linear draw-count scaling, not a bound): ",
      mean_seconds * 8000 * 1999 / 49 / 3600, "\n",
      sep = ""
    )
    cat("Smoke results do not establish coverage; ",
      "benchmark n = 250 separately.\n",
      sep = ""
    )
  }
}
