#' Stable Seeds Independent of Run Sharding
#' @author Ivan Jacob Agaloos Pesigan
#' @param taskid Condition ID, one through eight.
#' @param repid Replication ID, one through one million.
#' @param stream One for data, two through four for the three samplers.
#' @return Integer seed; no retry or reseeding is performed.
#' @examples
#' .WildValidationSeed(taskid = 1, repid = 1, stream = 1)
#' @noRd
.WildValidationSeed <- function(taskid, repid, stream) {
  values <- c(taskid, repid, stream)
  stopifnot(
    length(x = values) == 3, all(is.finite(x = values)),
    all(values == floor(x = values)),
    taskid >= 1, taskid <= 8, repid >= 1, repid <= 1000000,
    stream >= 1, stream <= 4
  )
  as.integer(x = 16 * ((taskid - 1) * 1000000 + repid - 1) + stream)
}
