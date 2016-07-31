familia <- 'TOTAL T+ L'
report_date <- '2015-12-22'



# Get Data For The day ----------------------------------------------------

source('read.r')
library(dplyr)
carteras <- families_data %>%
  filter(Descripcion ==  familia) 
    

daily_data <- bulk_data %>%
 filter( Periodo == report_date) %>%
  filter(CarteraNom %in% carteras$CarteraNom) %>%
  filter(Exposure != 0) %>%
  arrange(desc(Exposure)) %>%
  mutate(LS_Flag = ifelse(Valuacion >= 0, 'Long','Short')) %>%
  select(LS_Flag,AT12,Valuacion,Margin,AT13)

nav <-  bulk_data %>%
  filter( Periodo == report_date) %>%
  filter(CarteraNom %in% carteras$CarteraNom) %>%
  group_by(Periodo) %>%
  summarise(sum(Valuacion))

daily_data <-  daily_data %>%
  mutate(daily_nav = nav$`sum(Valuacion)`) %>%
  mutate( perc_expo = round(Valuacion / daily_nav * 100,2)) %>%
mutate( perc_margin = round(Margin / Valuacion * 100,2)) %>%
  mutate(cum_expo = cumsum(perc_expo))

library(formattable)
daily_data %>% filter( perc_expo >= 1) %>% formattable()
