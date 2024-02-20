#Random forest
rf.model <- randomForest ( outcome ~ opponent + opponent_box + possession + conversion, data = training, 
                           mtry = 1, importance = TRUE ,
                           ntree = 2000)

#How well does this bagged model perform on the test set?
rf.predict <- predict ( rf.model , newdata = testing[,c(3,12,13,14)])
mean(rf.predict == testing$outcome)



#Matrix to see predicted against actual
table(predicted = rf.predict,actual = testing$outcome)


#Calculation
#Wins
98/(160)
#Lose
112/(160)
#Draw
25/(66)


#view the importance of each variable
importance(rf.model)


#Plotting to show the importance of variables
varImpPlot ( rf.model )


# Creating dataframe for lda predicted outcome with actual outcome

rf.outcome <- data.frame(pred.outcome = rf.predict, 
                         outcome = testing$outcome,
                         team = football_actual$team,
                         opponent = football_actual$opponent,
                         where = football_actual$where,
                         round = testing$round,
                         competition = football_actual$competition) 



#Finding the error from each round
rf.round <- rf.outcome %>% 
  group_by(round) %>% 
  summarise(error.round = mean(pred.outcome==outcome))
View(rf.round)


#Giving points to each outcome

rf.football <- rbind(first.set, rf.outcome) %>% 
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
rf.league <- rf.football %>% 
  filter(competition == "league") %>% 
  group_by(team) %>% 
  dplyr::summarise(pred.points = sum(pred.points),
                   actual.points = sum(actual.points))


View(rf.league)