# Linear discriminant analysis

#Creating lda with the full model
lda_model <- lda(outcome ~ opponent + possession + opponent_box +
                   conversion, data = training)
plot(lda_model)
summary(lda_model)

#Prediction of outcome
p <- predict(lda_model, testing)


#Creating a biplot
ggord(lda_model, training$outcome, ylim = c(-5, 5))


# Confusion matrix and accuracy of the training data
p1 <- predict(lda_model, training)$class
tab <- table(Predicted = p1, Actual = training$outcome)
tab



# With testing data
lda.pred <- predict(lda_model, testing)$class
tab1 <- table(Predicted = lda.pred, Actual = testing$outcome)
tab1

#Finding the lda accuracy
mean(testing$outcome == lda.pred )

#LDA
#Win
98/(160)
#Lose
132/(160)
#Draw
18/(66)


# Creating dataframe for lda predicted outcome with actual outcome

lda.outcome <- data.frame(pred.outcome = lda.pred, 
                          outcome = testing$outcome,
                          team = football_actual$team,
                          opponent = football_actual$opponent,
                          where = football_actual$where,
                          round = testing$round,
                          competition = football_actual$competition) 


#Giving points to each outcome

lda.football <- rbind(first.set, lda.outcome) %>% 
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
lda.league <- lda.football %>% 
  filter(competition == "league") %>% 
  group_by(team) %>% 
  dplyr::summarise(pred.points = sum(pred.points),
                   actual.points = sum(actual.points))


View(lda.league)
