# Build an isolated betaNB installation without reading R startup files.
# Usage: make -f .setup/scripts/wild-validation.mk wild-prepare
root <- normalizePath(path = getwd())
helpers <- list.files(
  path = ".setup/tests-external/helpers", pattern = "\\.R$", full.names = TRUE
)
helper_env <- new.env(parent = globalenv())
for (file in helpers) {
  sys.source(file = file, envir = helper_env)
}
cache <- Sys.getenv(
  x = "BETANB_WILD_CACHE",
  unset = file.path(root, ".setup/data-cache/wild-validation")
)
dir.create(path = cache, recursive = TRUE, showWarnings = FALSE)
staging <- tempfile(pattern = "build-", tmpdir = cache)
build <- file.path(staging, "package")
lib <- file.path(staging, "library")
dir.create(path = build, recursive = TRUE)
dir.create(path = lib)
files <- c(
  "DESCRIPTION", "project.Rproj",
  list.files(path = "R", pattern = "\\.R$", full.names = TRUE),
  list.files(
    path = "tests", pattern = "\\.R$", full.names = TRUE,
    recursive = TRUE
  ),
  list.files(
    path = ".setup/r-dependencies", pattern = "\\.R$",
    recursive = TRUE, full.names = TRUE
  ),
  list.files(
    path = ".setup/cpp", pattern = "\\.(cpp|h|hpp)$|^Makevars(\\.win)?$",
    full.names = TRUE
  ),
  list.files(path = "data", pattern = "\\.rda$", full.names = TRUE)
)
for (file in files) {
  target <- file.path(build, file)
  dir.create(
    path = dirname(path = target), recursive = TRUE, showWarnings = FALSE
  )
  if (!file.copy(from = file, to = target)) {
    stop("Cannot prepare validation build: ", file)
  }
}
rProject::Dependencies(path = build)
dir.create(path = file.path(build, "src"))
cpp <- list.files(
  path = file.path(build, ".setup/cpp"), pattern = "\\.cpp$", full.names = TRUE
)
writeLines(
  text = unlist(x = lapply(X = cpp, FUN = readLines)),
  con = file.path(build, "src/source.cpp")
)
file.copy(
  from = file.path(build, ".setup/cpp", c("Makevars", "Makevars.win")),
  to = file.path(build, "src")
)
namespace <- file.path(build, "NAMESPACE")
file.create(namespace)
Rcpp::compileAttributes(pkgdir = build)
roxygen2::roxygenize(package.dir = build, roclets = "rd")
unlink(x = namespace)
devtools::document(pkg = build)
utils::install.packages(pkgs = build, repos = NULL, type = "source", lib = lib)
if (!file.exists(file = file.path(lib, "betaNB/DESCRIPTION"))) {
  stop("The isolated betaNB installation failed.")
}
ready <- list(
  library = normalizePath(path = lib),
  package = normalizePath(path = build),
  sources = helper_env$.WildValidationSources(root = root)
)
partial <- tempfile(pattern = ".ready-", tmpdir = cache)
saveRDS(object = ready, file = partial, compress = "xz")
if (!file.rename(from = partial, to = file.path(cache, "build-ready.rds"))) {
  stop("Cannot atomically record the validation build.")
}
cat("Prepared isolated betaNB library: ", ready$library, "\n", sep = "")
