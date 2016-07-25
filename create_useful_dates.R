the_date <- max(bulk_data$Periodo)
library(lubridate)
mtd_start <- the_date
month(mtd_start) <- month(mtd_start)
day(mtd_start) <- 1
year_start <- the_date
month(year_start) <- 1
day(year_start) <- 1
