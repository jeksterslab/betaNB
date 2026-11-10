#' Fingerprint Only Explicit Validation and Package Sources
#' @author Ivan Jacob Agaloos Pesigan
#' @param root Project directory.
#' @return Named MD5 vector using project-relative source paths.
#' @examples
#' .WildValidationSources(root = getwd())
#' @noRd
.WildValidationSources <- function(root) {
  directories <- c(
    "R", ".setup/r-dependencies", ".setup/cpp",
    ".setup/tests-external/helpers", ".setup/scripts"
  )
  files <- c("DESCRIPTION", unlist(x = lapply(
    X = directories,
    FUN = function(directory) {
      paths <- list.files(
        path = file.path(root, directory),
        pattern = "\\.(R|cpp|h|hpp)$|^Makevars(\\.win)?$",
        recursive = TRUE, full.names = FALSE
      )
      if (directory == ".setup/scripts") {
        paths <- paths[grepl(pattern = "^wild-validation", x = paths)]
      }
      file.path(directory, paths)
    }
  )))
  files <- sort(x = unique(x = files))
  hashes <- tools::md5sum(files = file.path(root, files))
  names(x = hashes) <- files
  hashes
}
