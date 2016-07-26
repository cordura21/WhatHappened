source('read.R')
source('set_filters.R')
source('keep_columns.R')
source('tide_up_data.R')
source('create_useful_dates.R')

source('summaries.R')

View(
bulk_data %>% filter(Periodo == '2016-01-14' & 
                       variable == 'Exposure' & CarteraNom == 'T-Donchian')
)
