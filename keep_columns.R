keep_columns_variable <- c('CarteraNom',
                  'Periodo',
                  'EspecieNombre',
                  'AT12',
                  'AT13')
keep_columns_value <- 
                  c('Valuacion',
                    'Exposure',
                  'LongExposure',
                  'ShortExposure',
                  'Resultado')

bulk_data <- bulk_data[,c(keep_columns_variable,keep_columns_value)]
pnl_data <- pnl_data %>% filter(NombreFamilia %in% chosen_families)
