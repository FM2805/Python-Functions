
#############################################################################################################
# Bootstrapping Function
# change "Data" and "newDF"
#############################################################################################################
set.seed(1)
boot_fun <- function(df) {
  
  #for(i in 1:5) {
  index <- sample(1:144,100,replace=F)
  Data <-Data[index,]
  Data_Subset<-Data_Subset[with(Data_Subset, order(Date, Data)), ]
  plot(Werte_Subset$Data,type='l')
  model <- gam(Data ~ s(Date,k="cs"),data=Werte_Subset)
  Fc <-predict(model, type="response", newdata='newDF')
}

reps <- lapply(seq_len(5000), boot_fun)
Prog <- lapply(reps,sum)
Prog <- unlist(Allzeit)
Intervall <- quantile(Prog,probs=c(0.95,0.05))