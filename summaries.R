# Now, the details
details <- bulk_data %>% filter(Periodo == the_date$end) %>%
  filter(variable  == 'Exposure') %>%
  group_by(AT13) %>%
  summarize(value = sum(value)) %>%
  mutate(variable = 'Exposure')

details <- rbind( details,
                  bulk_data %>% filter(Periodo == the_date$end) %>%
  filter(variable  == 'LongExposure') %>%
  group_by(AT13) %>%
  summarize(value = sum(value)) %>%
  mutate(variable = 'Longs')
)

details <- rbind( details,
                  bulk_data %>% filter(Periodo == the_date$end) %>%
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

details_by_assets <- bulk_data %>% filter(Periodo == the_date$end) %>%
  filter(variable  == 'Exposure') %>%
  group_by(AT12,AT13) %>%
  summarize(value = sum(value)) %>%
  mutate(variable = 'Exposure')

details_by_assets <- rbind( details_by_assets,
                  bulk_data %>% filter(Periodo == the_date$end) %>%
                    filter(variable  == 'LongExposure') %>%
                    group_by(AT12,AT13) %>%
                    summarize(value = sum(value)) %>%
                    mutate(variable = 'Longs')
)

details_by_assets <- rbind( details_by_assets,
                  bulk_data %>% filter(Periodo == the_date$end) %>%
                    filter(variable  == 'ShortExposure') %>%
                    group_by(AT12,AT13) %>%
                    summarize(value = sum(value)) %>%
                    mutate(variable = 'Shorts')
)

details_by_assets <- rbind( details_by_assets,
                  bulk_data %>% filter(Periodo == the_date$end) %>%
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
  filter(variable == 'Valuacion' & Periodo == the_date$end) %>% 
  group_by() %>%summarise(value = sum(value))
leverage_metrics$ratio <- with(leverage_metrics,total_expo / nav)

leverage_metrics$non_treasuries_expo <- bulk_data %>%
  filter(AT12 != "Short Term Gov Inv Grade Bond" & 
           variable == 'Exposure' & Periodo == the_date) %>%
  summarize(sum(value))

leverage_metrics$leverage_non_treasuries <- with(leverage_metrics,non_treasuries_expo / nav)


leverage_metrics$margin <-  bulk_data %>%
  filter(variable == 'Valuacion' & Periodo == the_date$end & AT12 == "Cash Margin Accounts") %>% 
  group_by() %>%summarise(value = sum(value))

leverage_metrics$margin_to_equity <- with(leverage_metrics,margin / nav)


periodic_stats <- bulk_data %>%
  select(Periodo,variable,the_date$end) %>%
  dcast(Periodo ~ variable,fun.aggregate = sum) %>%
  tbl_df() %>%
  summary()