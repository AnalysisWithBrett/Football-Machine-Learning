# Storing original file, in case anything goes wrong
football <- la_liga_home

# Creating a new variable called conversion (percentage of shots converted to goals)

football1 <- football %>% 
  mutate(conversion = (gf / shots) * 100) %>% 
  dplyr::select(1,2,3,4,7,8,9,10,11,12,13,14,15,16)

# Converting some variables into factors
football1$outcome <- (as.factor(football1$outcome))
football1$team <- as.integer(as.factor(football1$team))
football1$opponent <- as.integer(as.factor(football1$opponent))
football1$where <- as.integer(as.factor(football1$where))
football1$competition <- as.integer(as.factor(football1$competition))
football1$round <- as.integer(football1$round)

# Splitting the data into training and testing
training <- football1 %>% 
  filter(round < 23)
dim(training)

# Creating rolling averages of 21 days for testing

testing <- football2 %>%
  group_by(team) %>%
  mutate(moving_shots = round(rollmean(shots, k=21, fill=NA, align='right')),
         moving_corners = round(rollmean(corners, k=21, fill=NA, align='right')),
         moving_fouls = round(rollmean(fouls, k=21, fill=NA, align='right')),
         moving_yellow = round(rollmean(yellow, k=21, fill=NA, align='right')),
         moving_red = round(rollmean(red, k=21, fill=NA, align='right')),
         moving_possession = round(rollmean(possession, k=21, fill=NA, align='right')),
         moving_oppo = round(rollmean(opponent_box, k=21, fill=NA, align='right')),
         moving_conversion = round(rollmean(conversion, k=21, fill=NA, align='right'))) %>% 
  dplyr::select(1:6,
                shots = moving_shots,
                corners = moving_corners,
                fouls = moving_fouls,
                yellow = moving_yellow,
                red = moving_red,
                possession = moving_possession,
                opponent_box = moving_oppo,
                conversion = moving_conversion) %>% 
  filter(round >= 23)

# Creating exponential rolling averages

testing <- football2 %>%
  group_by(team) %>%
  mutate(moving_shots = round(TTR::EMA(shots, k=21, fill=NA, align='right')),
         moving_corners = round(TTR::EMA(corners, k=21, fill=NA, align='right')),
         moving_fouls = round(TTR::EMA(fouls, k=21, fill=NA, align='right')),
         moving_yellow = round(TTR::EMA(yellow, k=21, fill=NA, align='right')),
         moving_red = round(TTR::EMA(red, k=21, fill=NA, align='right')),
         moving_possession = round(TTR::EMA(possession, k=21, fill=NA, align='right')),
         moving_oppo = round(TTR::EMA(opponent_box, k=21, fill=NA, align='right')),
         moving_conversion = round(TTR::EMA(conversion, k=21, fill=NA, align='right'))) %>% 
  dplyr::select(1:6,
                shots = moving_shots,
                corners = moving_corners,
                fouls = moving_fouls,
                yellow = moving_yellow,
                red = moving_red,
                possession = moving_possession,
                opponent_box = moving_oppo,
                conversion = moving_conversion) %>% 
  filter(round >= 23)