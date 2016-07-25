summary_Portfolio <- pnl_data %>%
  filter(Fecha >= year_start & Fecha  < the_date & variable == 'RentDiaria') %>%
  group_by(NombreFamilia) %>%
  summarise(pnl =sum(value))

Current_nav <- pnl_data %>%
  filter(Fecha == the_date) %>%
  arrange(variable) %>%
  filter(variable %in% c('RentDiaria','PorcRentDiaria','PatFamiliaFinal'))

summary_positions <- bulk_data %>%
  filter(Periodo == the_date) %>%
  filter(variable == 'Exposure' & value !=0) %>%
  mutate(dir = ifelse())
  group_by(AT13) %>%
  summarize(sum(value))

summary_positions_detail <- bulk_data %>%
  filter(Periodo == the_date) %>%
  filter(variable == 'Exposure' & value !=0) %>%
  group_by(AT12) %>%
  summarize(sum(value))
