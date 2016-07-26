the_date <- list(start = max(bulk_data$Periodo), end = max(bulk_data$Periodo) )

library(lubridate)
mtd_start <- the_date
month(mtd_start) <- month(mtd_start)
day(mtd_start) <- 1
year_start <- the_date
month(year_start) <- 1
day(year_start) <- 1

duration(interval(the_date$start-100,the_date$end))
pnl_data %>% filter(Fecha %within% interval(the_date$start,the_date$end))
