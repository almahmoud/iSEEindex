# Launch the ShinyApp (Do not remove this comment)

library(iSEE)
library(iSEEindex)
library(BiocFileCache)

bfc <- BiocFileCache(cache = tempdir())

dataset_fun <- function() {
  list(list(id="ReprocessedAllenData",
            title="ReprocessedAllenData",
            uri="https://raw.githubusercontent.com/csoneson/iSEE-example-data/refs/heads/main/allen/allen_sce.rds",
            description="Reprocessed Allen Data.\n"))
}
initial_fun <- function() {
  list(list(id="ReprocessedAllenData_Config1",
            title="InitialConfig1",
            dataset="ReprocessedAllenData",
            uri="https://raw.githubusercontent.com/csoneson/iSEE-example-data/refs/heads/main/allen/allen_initial_1.R",
            description="PCA plot + feature assay plot"),
       list(id="ReprocessedAllenData_Config2",
            title="InitialConfig2",
            dataset="ReprocessedAllenData",
            uri="https://raw.githubusercontent.com/csoneson/iSEE-example-data/refs/heads/main/allen/allen_initial_2.R",
            description="tSNE plot + column data table + feature assay plot"))
}
iSEEindex(bfc, FUN.datasets=dataset_fun, FUN.initial=initial_fun)
