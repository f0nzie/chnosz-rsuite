
<!-- README.md is generated from README.Rmd. Please edit that file -->

# chnosz-rsuite

The goal of chnosz-rsuite is to provide a reproducible R platform for
building the CHNOSZ vignettes. This comes in handy when new packages are
released or a new version of R available and the applications do not run
due to dependencies.

## To build the notebooks

### Install rsuite

Install first the client `rsuite` and package `rsuite`.

Download `rsuite` from here: <https://rsuite.io/>

### Build the notebooks

From the terminal, in the folder `chnosz-rsuite`, run the following
command:

To build the first notebook:

    Rscript R/01-intro.R

To build the second notebook:

    Rscript R/02-eos.R

To build all the notebooks:

    Rscript R/compile_rmd.R

Or to build individual notebooks:

    Rscript R/compile_rmd.R --which="01-intro.R"

\`
