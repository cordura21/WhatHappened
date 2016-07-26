# First, Portfolio main numbers
summ <- data.frame(date = NA,period = NA,
                   cartera = NA,variable = NA,stat = NA, value = NA)

summ <- pnl_data %>%
  filter(Fecha == the_date & variable == 'RentDiaria') %>%
  group_by(NombreFamilia) %>%
  summarise(pnl =sum(value)) %>%
  mutate( date = the_date, period = 'Latest', cartera = NombreFamilia,
          variable = 'Resultado', stat = 'final',value = pnl ) %>%
  select(date,period,cartera,variable,stat,value)

summ <-rbind(summ, pnl_data %>%
  filter(Fecha == the_date & variable == 'PatFamiliaFinal') %>%
  group_by(NombreFamilia) %>%
  summarise(pnl =sum(value)) %>%
  mutate( date = the_date, period = 'Latest', cartera = NombreFamilia,
          variable = 'Patrimonio', stat = 'Final',value = pnl ) %>%
  select(date,period,cartera,variable,stat,value)
)

summ <-rbind(summ, pnl_data %>%
               filter(Fecha == the_date & variable == 'PorcRentDiaria') %>%
               group_by(NombreFamilia) %>%
               summarise(pnl =sum(value)) %>%
               mutate( date = the_date, period = 'Latest', cartera = NombreFamilia,
                       variable = 'Resultado %', stat = 'Final',value = pnl ) %>%
               select(date,period,cartera,variable,stat,value)
  )

# Now, the details
details <- bulk_data %>% filter(Periodo == the_date) %>%
  filter(variable  == 'Exposure') %>%
  group_by(AT13) %>%
  summarize(value = sum(value)) %>%
  mutate(variable = 'Exposure')

details <- rbind( details,
                  bulk_data %>% filter(Periodo == the_date) %>%
  filter(variable  == 'LongExposure') %>%
  group_by(AT13) %>%
  summarize(value = sum(value)) %>%
  mutate(variable = 'Longs')
)

details <- rbind( details,
                  bulk_data %>% filter(Periodo == the_date) %>%
                    filter(variable  == 'ShortExposure') %>%
                    group_by(AT13) %>%
                    summarize(value = sum(value)) %>%
                    mutate(variable = 'Shorts')
)

details <- rbind( details,
                  bulk_data %>% filter(Periodo == the_date) %>%
                    filter(variable  == 'Resultado') %>%
                    group_by(AT13) %>%
                    summarize(value = sum(value)) %>%
                    mutate(variable = 'Resultado')
)

details_by_assets <- bulk_data %>% filter(Periodo == the_date) %>%
  filter(variable  == 'Exposure') %>%
  group_by(AT12,AT13) %>%
  summarize(value = sum(value)) %>%
  mutate(variable = 'Exposure')

details_by_assets <- rbind( details_by_assets,
                  bulk_data %>% filter(Periodo == the_date) %>%
                    filter(variable  == 'LongExposure') %>%
                    group_by(AT12,AT13) %>%
                    summarize(value = sum(value)) %>%
                    mutate(variable = 'Longs')
)

details_by_assets <- rbind( details_by_assets,
                  bulk_data %>% filter(Periodo == the_date) %>%
                    filter(variable  == 'ShortExposure') %>%
                    group_by(AT12,AT13) %>%
                    summarize(value = sum(value)) %>%
                    mutate(variable = 'Shorts')
)

details_by_assets <- rbind( details_by_assets,
                  bulk_data %>% filter(Periodo == the_date) %>%
                    filter(variable  == 'Resultado') %>%
                    group_by(AT12,AT13) %>%
                    summarize(value = sum(value)) %>%
                    mutate(variable = 'Resultado')
)

library(reshape2)
details_by_assets <- dcast(details_by_assets,AT12+AT13 ~ variable,fun.aggregate = sum) %>%
  select(AT12,AT13,Exposure,Resultado,Longs,Shorts) %>%
  arrange(desc(Exposure))

details <- dcast(details,AT13 ~ variable,fun.aggregate = sum) %>%
  select(AT13,Exposure,Resultado,Longs,Shorts) %>%
  arrange(desc(Exposure))

leverage_metrics <- list()
leverage_metrics$total_expo <- sum(details$Exposure)

leverage_metrics$nav <- bulk_data %>%
  filter(variable == 'Valuacion' & Periodo == the_date) %>% 
  group_by() %>%summarise(value = sum(value))
leverage_metrics$ratio <- with(leverage_metrics,total_expo / nav)

leverage_metrics$non_treasuries_expo <- bulk_data %>%
  filter(AT12 != "Short Term Gov Inv Grade Bond" & 
           variable == 'Exposure' & Periodo == the_date) %>%
  summarize(sum(value))

leverage_metrics$leverage_non_treasuries <- with(leverage_metrics,non_treasuries_expo / nav)


leverage_metrics$margin <-  bulk_data %>%
  filter(variable == 'Valuacion' & Periodo == the_date & AT12 == "Cash Margin Accounts") %>% 
  group_by() %>%summarise(value = sum(value))

leverage_metrics$margin_to_equity <- with(leverage_metrics,margin / nav)


periodic_stats <- bulk_data %>%
  select(Periodo,variable,value) %>%
  dcast(Periodo ~ variable,fun.aggregate = sum) %>%
  tbl_df() %>%
  summary()


View(bulk_data %>%
  filter(variable  == 'Exposure') %>%
  group_by(AT13) %>%
  summarise(max(value),min(value),mean(value)))



View(bulk_data %>%
       filter(variable  == 'Resultado') %>%
       group_by(AT12,Periodo) %>%
       summarise(value = sum(value)) %>%
       arrange(desc(value))  %>%
       filter(row_number() == 1) )

View(bulk_data %>%
       filter(variable  == 'Resultado') %>%
       group_by(AT12,Periodo) %>%
       summarise(value = sum(value)) %>%
       arrange(value)  %>%
       filter(row_number() == 1) )


