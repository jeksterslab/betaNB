## ---- test-external-betaNB-nb-wild-coverage
lapply(
  X = 1,
  FUN = function(i, text) {
    message(text)
    request <- validation_request
    print(x = .WildValidationRun(
      config = request$config, output = request$output,
      taskids = request$taskids, repids = request$repids
    ))
  },
  text = "test-external-betaNB-nb-wild-coverage"
)
