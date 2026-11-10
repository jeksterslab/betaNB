# Run inside docs.sif from the betaNB project directory.
export R_ENVIRON_USER = /dev/null
export R_PROFILE_USER = /dev/null
export R_ENVIRON = /dev/null
export R_PROFILE = /dev/null
export NOT_CRAN = true
export OMP_NUM_THREADS = 1
export OPENBLAS_NUM_THREADS = 1
export MKL_NUM_THREADS = 1

.PHONY: wild-prepare wild-check wild-smoke wild-run wild-summary

wild-prepare:
	Rscript --vanilla .setup/scripts/wild-validation-prepare.R

wild-check:
	Rscript --vanilla .setup/scripts/wild-validation.R check

wild-smoke:
	Rscript --vanilla .setup/scripts/wild-validation.R smoke

wild-run:
	Rscript --vanilla .setup/scripts/wild-validation.R run

wild-summary:
	Rscript --vanilla .setup/scripts/wild-validation.R summary
