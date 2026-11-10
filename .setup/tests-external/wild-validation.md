# Wild-bootstrap external validation

This private workflow implements the approved eight-condition comparison in `.setup/ai/specs/2026-11-09-wild-validation.md`.
It compares pairs, fixed-X wild and random-X wild bootstrap intervals (`pc`, `bc`, `bca`) for three standardized slopes, three signed semipartial correlations and R-squared.
The R wild sampler and public betaNB API are unchanged.
The population targets and data-generating process are specified independently of the estimators.

## Prepare and smoke-test

Run from the betaNB project directory.
The make file disables R startup files and uses one BLAS/OpenMP thread.
Preparation builds and installs only into a generated cache directory, using explicit package/dependency sources; it does not call `make project` or read machine credentials.
It requires the tools already in `docs.sif`: rProject, Rcpp, RcppArmadillo, roxygen2, devtools and testthat.
There are no new package runtime dependencies.

```bash
apptainer exec -B ~/work:$(readlink -f ~/work) -B /scratch/ibp5092 ~/work/sif/docs.sif make -f .setup/scripts/wild-validation.mk wild-prepare wild-check wild-smoke
```

`wild-check` uses injected failures and analytic fixtures; it does not run a coverage simulation.
`wild-smoke` runs exactly two replications of condition 1 with 49 bootstrap draws per sampler, exercising all nine sampler/interval combinations.
Smoke results test execution only and must not be interpreted as coverage evidence.
The runner reports cell times and an explicitly rough draw-count-scaled full-run estimate; this ignores changes in sample size, interval sorting costs, startup and filesystem behavior.
Benchmark a small shard of the slowest condition on a compute/local node before allocating resources for a full run.

## Full run: compute or local node only

Default full design: eight conditions, 1000 replications each, 1999 bootstrap draws for each of three samplers.
Invoke the following yourself on a compute or local node; do not run it on the submit node.
No SLURM job is submitted by this workflow.

```bash
apptainer exec -B ~/work:$(readlink -f ~/work) -B /scratch/ibp5092 ~/work/sif/docs.sif make -f .setup/scripts/wild-validation.mk wild-run
```

The run can be split into sequential shards using environment variables.
For example, this selects ten replications of condition 8 while retaining the full-run replication count and seed mapping:

```bash
BETANB_WILD_TASKS=8 BETANB_WILD_FROM=1 BETANB_WILD_TO=10 apptainer exec -B ~/work:$(readlink -f ~/work) -B /scratch/ibp5092 ~/work/sif/docs.sif make -f .setup/scripts/wild-validation.mk wild-run
```

| Environment variable | Default | Meaning |
|---|---|---|
| `BETANB_WILD_CACHE` | `.setup/data-cache/wild-validation` | Isolated builds and ready marker |
| `BETANB_WILD_OUT` | `<cache>/run`, or `<cache>/smoke` | Cell results, config and summaries |
| `BETANB_WILD_REPS` | `1000` | Total planned replications per condition |
| `BETANB_WILD_DRAWS` | `1999` | Bootstrap draws per sampler |
| `BETANB_WILD_TASKS` | all eight task IDs | Comma-separated conditions to execute |
| `BETANB_WILD_FROM` | `1` | First replication to execute |
| `BETANB_WILD_TO` | total planned replications | Last replication to execute |

Smoke mode fixes the design selection, replication count and draw count regardless of these run-size variables.
Choose a different output directory when changing total replication count, draw count, sources or R version.
Use node-local storage for temporary compute-node results where practical, and retain compact summaries/configuration with the durable run archive.
Do not upload raw cell files or generated builds to Overleaf.

## Seeds and resume

For condition `taskid`, replication `repid`, and stream `s`, the seed is:

```text
16 * ((taskid - 1) * 1000000 + repid - 1) + s
```

Streams 1–4 are data, pairs, wild fixed-X and wild random-X.
There are no collisions for eight conditions and up to one million replications; the maximum seed is below R's integer limit.
Seeds do not depend on execution order, shard size or bootstrap draw count.
Each cell uses one dataset and one fitted model for all three samplers; all effects and interval types reuse a sampler's single `NB()` result.
Failures are results and never cause an automatic retry with another seed.

`config.rds` records the design, targets, replication/draw counts, algorithm settings, R/package versions and explicit source fingerprints.
`task-NN-rep-NNNNNNN.rds` is written through a temporary file and atomic rename, with xz compression.
An existing cell is skipped only after validating its configuration, IDs, interval keys, seeds, truth and coverage flags.
Incomplete or incompatible cells stop the run rather than being overwritten.
An interrupted write cannot masquerade as a completed cell.

There is one writer per output directory, enforced by an atomic `.running` directory containing the hostname and process ID.
Do not run concurrent shards into the same directory.
After a process crash, inspect the recorded owner and confirm the process is gone before removing the abandoned lock; rerun the same shard and seed mapping.
Orphan temporary files are ignored by the reader; complete files remain resumable.
Changed validation/package sources require `wild-prepare` again, and existing results require a new output directory.

## Summary and interpretation

Summaries are also written after a run/shard.
To regenerate the full-run summary without resampling:

```bash
apptainer exec -B ~/work:$(readlink -f ~/work) -B /scratch/ibp5092 ~/work/sif/docs.sif make -f .setup/scripts/wild-validation.mk wild-summary
```

To summarize smoke results, set `BETANB_WILD_OUT` to their directory explicitly.
The summary action reads the stored replication/draw settings and requires matching current sources and R/package versions.
It refuses to summarize an active writer.

`summary.csv` has one row per condition, sampler, interval type, effect and parameter, including conditions not yet attempted.
`timing.csv` records each complete cell's elapsed seconds; raw cell RDS files retain stage errors, endpoint values and interval timing.

- `expected`, `attempted`, `missing`: planned, completed interval attempts, and unattempted replications.
- `valid`, `failed`: finite point estimate and finite ordered endpoints, or failure; infeasible finite endpoints remain visible rather than being clipped.
- `coverage_valid`: covered/valid, with `mcse_valid` based on that denominator.
- `coverage_all`: covered/attempted, with invalid attempts counted as uncovered and its own `mcse_all`; missing cells are reported separately.
- `interval_below_valid`: fraction of valid intervals whose upper endpoint is below the target.
- `interval_above_valid`: fraction of valid intervals whose lower endpoint is above the target.
- `mean_width_valid`, `failure_rate`, `infeasible_valid`: denominators are explicit in the names or are all attempts for failure rate.
- `mean_bootstrap_seconds`, `mean_interval_seconds`: per-group means. Bootstrap time repeats across effects/types; do not sum it over summary rows.

Both endpoints are inclusive for coverage.
The feasible ranges are [-1, 1] for signed sr and [0, 1] for R-squared; standardized multiple-regression slopes are not artificially restricted to [-1, 1].
No method is declared adequate or preferred from smoke output.
Source-reading conclusions and limits are recorded separately in `.setup/ai/research/2026-11-09-wild-bootstrap.md`.
