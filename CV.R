########################
# Function for Leave-One-Out Cross Validation.
# Example with a Generalized Additive Model.
# Replace 'df', 'Target', 'x', 'Var' and 'model_list'
########################

CV_Score <- function(my_model) {
  for (i in 1:length(df$'Target')-1){ 
    # Define the data frame without the respective year
    df.newframe <- subset(df,'Var'!='x'-i)
    #Estimate model for remaining sample
    b1<- gam(my_model,data=df.newframe)
    #Get Subset for which we want to predict and calc. y_hat
    df.specific<-subset(df,'Var'=='x'-i)
    y_hat <-predict(b1,type="response",newdata=new)
    y_real <- df.specific$'Target'
    #Get the squared error and calculate the mean
    error_sq <- (y_real-y_hat)^2
    m_value[i] = mean(error_sq)
  }
  #Calculate Mean of the Mean Squared Error as the final CV score 
  CV_Score <- mean(m_value)
  return(CV_Score)
}  

m_value<-rep(NA,length(df$'Target')-1)
CV<-rep(NA,'models')
model_list <- c(my_model1, my_model2,my_model3, my_model4,..)
k = 1
for (my_model in model_list) {
  CV[k] <-CV_Score(my_model)
  k = k+1
}
