# Finding the best k value for KNN
# Data preparation for k value
k_values <- c(1:100)



# Calculate accuracy for each k value

accuracy_values <- sapply(k_values, function(k) {
  knn.pred <- knn(train = training[,c(3,12,13,14)],  #oyou can also change this
                  test = testing[,c(3,12,13,14)], 
                  cl = training$outcome, 
                  k = k)
  1 - mean(knn.pred != testing$outcome)
})


# Create a data frame for plotting
accuracy_data <- data.frame(K = k_values, Full = accuracy_values,
                            Model4 = accuracy_values4,
                            Model3 = accuracy_values3,
                            Model2 = accuracy_values2)


# Plotting to find the best k
ggplot(accuracy_data, aes(x = K, y = Full)) +
  geom_line(color = "lightblue", size = 1) +
  geom_point(color = "lightgreen", size = 3) +
  labs(title = "Model Accuracy for Different K Values",
       x = "Number of Neighbors (K)",
       y = "Accuracy") +
  theme.my.own()

# Finding the best K
accuracy_data[which.max(accuracy_data$Model4), ]


# Fitting to KNN model with k = k
(knn.pred <- knn(train = training[,c(3,12,13,14)], 
                 test = testing[,c(3,12,13,14)],
                 cl = training$outcome, 
                 k = 55 ))
plot(knn.pred)


# Confusion Matrix 
cm <- table(predicted = knn.pred, actual = testing$outcome) 

cm #if there are zeroes around the diagonal then it has no error

mean(testing$outcome == knn.pred ) #measurement for error

#Calculation
#Win
112/(160)
#Lose
126/(160)
#Draw
8/(66)


# Extracting real data for second half

football_actual <- football %>% 
  filter(round > 22)

football_actual2 <- football %>% 
  filter(round < 23)

# Creating dataframe for knn predicted outcome with actual outcome

knn.outcome <- data.frame(pred.outcome = knn.pred, 
                          outcome = testing$outcome,
                          team = football_actual$team,
                          where = football_actual$where,
                          opponent = football_actual$opponent,
                          round = testing$round,
                          competition = football_actual$competition) 


# Joining the first half of data with second half of data
first.set <- data.frame(pred.outcome = training$outcome,
                        outcome = training$outcome,
                        team = football_actual2$team,
                        opponent = football_actual2$opponent,
                        where = football_actual2$where,
                        round = football_actual2$round,
                        competition = football_actual2$competition)

#Giving points to each outcome

knn.football <- rbind(first.set, knn.outcome) %>% 
  mutate(pred.points = case_when(
    pred.outcome == "W" ~ 3,
    pred.outcome == "D" ~ 1,
    pred.outcome == "L" ~ 0
  ),
  actual.points = case_when(
    outcome == "W" ~ 3,
    outcome == "D" ~ 1,
    outcome == "L" ~ 0
  ))


# Creating football league rankings with knn data
knn.league <- knn.football %>% 
  filter(competition == "league") %>% 
  group_by(team) %>% 
  dplyr::summarise(pred.points = sum(pred.points),
                   actual.points = sum(actual.points))
