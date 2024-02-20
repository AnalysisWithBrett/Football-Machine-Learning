#Performing best subset selection

regfit.full <- regsubsets ( outcome ~ ., data = football1,
                            nvmax = 10)
summary ( regfit.full )

(reg.summary <- summary ( regfit.full ))

names (reg.summary)

#Looking at the R-squared on each model
reg.summary$rsq


#Adusted R-squared graph
plot ( reg.summary $ adjr2 , xlab = " Number of Variables ",
       ylab = " Adjusted RSq ", type = "l")

#Visualising the model selection
plot ( regfit.full , scale = "adjr2")

#Finding the model with the maximum adjusted R-squared
which.max ( reg.summary $ adjr2 )

#storing adjusted R-square into dataframe
adjrs <- data.frame(reg.summary$adjr2)