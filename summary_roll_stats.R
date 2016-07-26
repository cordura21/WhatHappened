library(TTR)
library(RcppRoll)
period_returns <- pnl_data %>%
  filter(NombreFamilia == chosen_families[1]) %>%
  dcast(Fecha ~ variable) %>%
  tbl_df() %>%
  mutate(avgPat =TTR::runMean(PatFamilia,10),
         logReturns = log(PorcRentDiaria+1),
         return_5d = RcppRoll::roll_sumr(RentDiaria,5,na.rm = TRUE),
         return_20d = RcppRoll::roll_sumr(RentDiaria,20,na.rm = TRUE),
         return_60d = RcppRoll::roll_sumr(RentDiaria,20,na.rm = TRUE),
         return_90d = RcppRoll::roll_sumr(RentDiaria,90,na.rm = TRUE),
         return_120d = RcppRoll::roll_sumr(RentDiaria,120,na.rm = TRUE),
         return_250d = RcppRoll::roll_sumr(RentDiaria,250,na.rm = TRUE)) %>%
  mutate(
    p_return_5d = exp(RcppRoll::roll_sumr(logReturns,5,na.rm = TRUE))-1,
    p_return_20d = exp(RcppRoll::roll_sumr(logReturns,20,na.rm = TRUE))-1,
    p_return_60d = exp(RcppRoll::roll_sumr(logReturns,20,na.rm = TRUE))-1,
    p_return_90d = exp(RcppRoll::roll_sumr(logReturns,90,na.rm = TRUE))-1,
    p_return_120d = exp(RcppRoll::roll_sumr(logReturns,120,na.rm = TRUE))-1,
    p_return_250d = exp(RcppRoll::roll_sumr(logReturns,250,na.rm = TRUE))-1) %>%
  filter(Fecha == max(Fecha)) %>% t()

         