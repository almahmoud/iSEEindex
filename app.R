# Launch the ShinyApp (Do not remove this comment)

library(iSEE)
library(iSEEindex)
library(BiocFileCache)

bfc <- BiocFileCache(cache = tempdir())

csvsourcedata <- "https://raw.githubusercontent.com/Bioconductor/isee.bioconductor.org/refs/heads/devel/config-dataset.csv"
csvsourceinitial <- "https://raw.githubusercontent.com/Bioconductor/isee.bioconductor.org/refs/heads/devel/config-initial.csv"

# Read and parse the CSV data
csv_data <- read.csv(csvsourcedata)
csv_initial <- read.csv(csvsourceinitial)

dataset_fun <- function() {
  # datasetID column must be unique
  stopifnot(all(!duplicated(csv_data$datasetID)))

  if (nrow(csv_data) == 0) {
    return(list())
  }

  datasets_list <- lapply(seq_len(nrow(csv_data)), function(i) {
    list(id = csv_data$datasetID[i],
         title = csv_data$datasetTitle[i],
         uri = csv_data$datasetURI[i],
         description = csv_data$datasetDescription[i])
  })

  return(datasets_list)
}

initial_fun <- function() {
  # Create initial configurations from CSV
  if (nrow(csv_initial) == 0) {
    return(list())
  }

  configs_list <- lapply(seq_len(nrow(csv_initial)), function(i) {
    list(id = paste0(csv_initial$datasetID[i], "_", csv_initial$configID[i]),
         title = csv_initial$configTitle[i],
         datasets = csv_initial$datasetID[i],
         uri = csv_initial$configURI[i],
         description = csv_initial$configDescription[i])
  })

  return(configs_list)
}

iSEEindex(bfc, FUN.datasets=dataset_fun, FUN.initial=initial_fun)
