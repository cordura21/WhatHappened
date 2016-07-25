chosen_families <- c('TOTAL T+ L',
               'BETA',
               'Alfa Total',
               'FUTUROS ADMINISTRADOS')

chosen_families_filter <- families_data %>%
  filter(Descripcion %in% chosen_families)
  
