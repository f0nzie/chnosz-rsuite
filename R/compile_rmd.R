# Detect proper script_path (you cannot use args yet as they are build with tools in set_env.r)
script_path <- (function() {
  args <- commandArgs(trailingOnly = FALSE)
  script_path <- dirname(sub("--file=", "", args[grep("--file=", args)]))
  if (!length(script_path)) {
    return("R")
  }
  if (grepl("darwin", R.version$os)) {
    base <- gsub("~\\+~", " ", base) # on MacOS ~+~ in path denotes whitespace
  }
  return(normalizePath(script_path))
})()

# Setting .libPaths() to point to libs folder
source(file.path(script_path, "set_env.R"), chdir = T)

config <- load_config()
args <- args_parser()

# ------------------------------------------------

library(chnosz.rsuite)

project_root <- rprojroot::find_rstudio_root_file()
rmd_src_dir <- file.path(project_root, "work", "RMD")
rmd_out_dir <- file.path(project_root, "export", "rmd_out")

setwd(rmd_src_dir)

# delete _main.Rmd if it was created before
if (file.exists("_main.Rmd")) {
  file.remove("_main.Rmd")
}

rmd_files <- list.files(".", "*.Rmd$")

logdebug(getwd())
print(rmd_files)



# function to print RMD files. Set the output folder
knit_rmd <- function(rmds) {
  for (rmd in rmds) {
    loginfo("Knitting notebook %s", rmd)
    logdebug(file.exists(rmd))
    rmarkdown::render(rmd, output_dir = rmd_out_dir)
  }
}

# function to handle what to do with the arguments
kniter <- function(which) {
  if (which == "all") {
    print(rmd_files)
    rmd_built <- list.files(".", "*.Rmd$")
    knit_rmd(rmd_built)
  } else {
    print(which)
    rmd_built <- which
    knit_rmd(which)
  }
  rmd_built
}

# retrieve the arguments from the command line
rmd_built <- kniter(
  which = args$get(name = "which", required = FALSE, default = "all")
)


loginfo("Finished knitting [%d] notebooks", length(rmd_built))
