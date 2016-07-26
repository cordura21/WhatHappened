library(PerformanceAnalytics)
data(edhec)
edhec

rbinded <- data.frame(Var1=NA,Var2=NA,value=NA, id = NA)
for(iCount in 1:200){
  xxx <- cor(edhec)
  xxx <- as.data.frame(melt(xxx))
  xxx$id <- paste(xxx$Var1,xxx$Var2,sep = ' | ')
   rbinded <- rbind(rbinded,xxx)
}
rbinded <- tbl_df(rbinded)
rbinded$id
