# Launch the ShinyApp (Do not remove this comment)

library(iSEE)
library(iSEEindex)
library(BiocFileCache)

bfc <- BiocFileCache(cache = tempdir())

csvsource <- "https://raw.githubusercontent.com/Bioconductor/isee.bioconductor.org/refs/heads/devel/config.csv"

# Read and parse the CSV data
csv_data <- read.csv(csvsource)

dataset_fun <- function() {
  # Get unique datasets from the CSV
  unique_datasets <- unique(csv_data[, c("datasetID", "datasetTitle", "datasetURI", "datasetDescription")])
  
  if (nrow(unique_datasets) == 0) {
    return(list())
  }
  
  datasets_list <- lapply(seq_len(nrow(unique_datasets)), function(i) {
    list(id = unique_datasets$datasetID[i],
         title = unique_datasets$datasetTitle[i],
         uri = unique_datasets$datasetURI[i],
         description = unique_datasets$datasetDescription[i])
  })
  
  return(datasets_list)
}

initial_fun <- function() {
  # Create initial configurations from CSV
  if (nrow(csv_data) == 0) {
    return(list())
  }
  
  configs_list <- lapply(seq_len(nrow(csv_data)), function(i) {
    list(id = paste0(csv_data$datasetID[i], "_", csv_data$configID[i]),
         title = csv_data$configTitle[i],
         datasets = csv_data$datasetID[i],
         uri = csv_data$configURI[i],
         description = csv_data$configDescription[i])
  })
  
  return(configs_list)
}

iSEEindex(bfc, FUN.datasets=dataset_fun, FUN.initial=initial_fun)
