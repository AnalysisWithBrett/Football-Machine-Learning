#Running the model
training_multinom <- multinom(outcome ~ shots + conversion, data = training_multi)
summary(training_multinom)

#Coefficients divided by SD to get z-value
z <- summary(training_multinom)$coefficients/summary(training_multinom)$standard.errors
z


# 2-tailed z test
p <- (1 - pnorm(abs(z), 0, 1)) * 2
p


## extract the coefficients from the model and exponentiate
exp(coef(training_multinom))


#calculate predicted probabilities for each of our outcome levels using the fitted function
head(pp <- fitted(training_multinom))


# Predict the class with the highest probability
predicted_classes_multi <- predict(training_multinom, 
                                   newdata = testing_multi[,c(6,13)], 
                                   type = "class")

#Accuracy of multinomial data
mean(predicted_classes_multi == testing_multi$outcome)
table(predicted = predicted_classes_multi, actual = testing_multi$outcome)


#Calculation
#Wins
119/(160)
#Draw
3/(66)
#Lose
135/(160)


# Creating dataframe for multinomial predicted outcome with actual outcome

multinom.outcome <- data.frame(pred.outcome = predicted_classes_multi, 
                               outcome = testing$outcome,
                               team = football_actual$team,
                               opponent = football_actual$opponent,
                               where = football_actual$where,
                               round = testing$round,
                               competition = football_actual$competition) 


#Giving points to each outcome

multinom.football <- rbind(first.set, multinom.outcome) %>% 
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
multinom.league <- multinom.football %>% 
  filter(competition == "league") %>% 
  group_by(team) %>% 
  dplyr::summarise(pred.points = sum(pred.points),
                   actual.points = sum(actual.points))



## store the predicted probabilities for each value of outcome and write
pp.pred <- cbind(testing_multi2, predict(training_multinom, newdata = testing_multi2, type = "probs", se = TRUE))


## calculate the mean probabilities within each level of outcome
by(pp.pred[,8:10], pp.pred$team, colMeans)
dim(pp.pred)

pp.pred2 <- pp.pred  %>% 
  dplyr::select(1, 2, 8:10)

pp.pred2


## melt data set to long for ggplot2
lpp <- melt(pp.pred2, id.vars = c("team", "opponent"), value.name = "probability") %>% 
  filter(team == c("Athletic Bilbao"))
View(lpp)

## plot predicted probabilities across write values for each level of ses
## facetted by program type
ggplot(lpp, aes(x = opponent, y = probability, colour = team)) + geom_point() + 
  facet_grid(variable ~ .) +
  theme.my.own() +
  theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust=1))


#Running the model
training_multinom2 <- multinom(outcome ~ team + shots, data = training_multi)


testing_multi3 <- data.frame(team = rep(c("Valencia", "Atletico Madrid", "Real Madrid", "Real Betis", "Celta de Vigo",
                                          "Rayo Vallecano"), each = 31),
                             shots = rep(c(0:30)))


## store the predicted probabilities for each value of outcome and write
pp.pred3 <- cbind(testing_multi3, predict(training_multinom2, newdata = testing_multi3, type = "probs", se = TRUE))


## calculate the mean probabilities within each level of outcome
by(pp.pred3[,3:5], pp.pred3$team, colMeans)
dim(pp.pred3)


## melt data set to long for ggplot2
lpp2 <- melt(pp.pred3, id.vars = c("team", "shots"), value.name = "probability")
lpp2

## plot predicted probabilities across write values for each level of ses
## facetted by program type
ggplot(lpp2, aes(x = shots, y = probability, colour = team)) + geom_line() + 
  facet_grid(variable ~ .) +
  theme.my.own() +
  theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust=1))
