library(reshape2)
bulk_data <- melt(data = bulk_data,id.vars = keep_columns_variable) %>%
  filter(value != 0) %>%
  tbl_df()

pnl_data <- melt(data = pnl_data,id.vars = c('Fecha','Familia','NombreFamilia')) %>%
  filter(value != 0) %>%
  tbl_df()


