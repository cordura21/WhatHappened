# First, Portfolio main numbers
summ <- data.frame(date = NA,period = NA,
                   cartera = NA,variable = NA,stat = NA, value = NA)

summ <- pnl_data %>%
  filter(Fecha == the_date$end & variable == 'RentDiaria') %>%
  group_by(NombreFamilia) %>%
  summarise(pnl =sum(value)) %>%
  mutate( date = as.Date(the_date$end), period = 'Latest', cartera = NombreFamilia,
          variable = 'Resultado', stat = 'final',value = pnl ) %>%
  select(date,period,cartera,variable,stat,value)

summ <-rbind(summ, pnl_data %>%
               filter(Fecha == the_date$end & variable == 'PatFamiliaFinal') %>%
               group_by(NombreFamilia) %>%
               summarise(pnl =sum(value)) %>%
               mutate( date = as.Date(the_date$end), period = 'Latest', cartera = NombreFamilia,
                       variable = 'Patrimonio', stat = 'Final',value = pnl ) %>%
               select(date,period,cartera,variable,stat,value)
)

summ <-rbind(summ, pnl_data %>%
               filter(Fecha == the_date$end & variable == 'PorcRentDiaria') %>%
               group_by(NombreFamilia) %>%
               summarise(pnl =sum(value)) %>%
               mutate( date = as.Date(the_date$end), period = 'Latest', cartera = NombreFamilia,
                       variable = 'Resultado %', stat = 'Final',value = pnl ) %>%
               select(date,period,cartera,variable,stat,value)
)
