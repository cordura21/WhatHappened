summary_Portfolio <- pnl_data %>%
  filter(Fecha >= year_start & Fecha  < the_date & variable == 'RentDiaria') %>%
  group_by(NombreFamilia) %>%
  summarise(pnl =sum(value))

Current_nav <- pnl_data %>%
  filter(Fecha == the_date) %>%
  arrange(variable) %>%
  filter(variable %in% c('RentDiaria','PorcRentDiaria','PatFamiliaFinal')) %>%
  select(NombreFamilia,variable,value) %>%
  dcast(NombreFamilia~variable)

summary_positions <- bulk_data_data %>%
  filter(Periodo == the_date) %>%
  dcast(AT13~variable,fun.aggregate = sum) %>%
  mutate(palanca = Exposure )

summary_positions_detail <- bulk_data %>%
  filter(Periodo == the_date) %>%
  dcast(AT13+AT12~variable,fun.aggregate = sum)
