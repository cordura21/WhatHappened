library(dplyr)
data_file_names <- c('data','bulk_nuevo.RDS','pnl.RDS','familias.RDS')
bulk_data <- readRDS(file.path(data_file_names[1],data_file_names[2]))
bulk_data <- tbl_df(bulk_data)

pnl_data <- readRDS(file.path(data_file_names[1],data_file_names[3]))
pnl_data <- tbl_df(pnl_data)

families_data <- readRDS(file.path(data_file_names[1],data_file_names[4]))
families_data <- tbl_df(families_data)

