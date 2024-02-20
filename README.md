
# Using Machine Learning to Predict Football Outcomes
This is a personal project. This project is focused on applying my data skills and knowledge in machine learning after reading the book "Introduction to Statistical Learning with Applications to R".

#### -- Project Status: Almost Done

## Project Intro/Objective
This project leverages machine learning tools to predict the outcome of football matches, determining whether a team will win, lose, or draw, based on various factors such as the opponent they face and their past performance. Inspired by the concepts outlined in "Introduction to Statistical Learning with Applications in R," this project serves as an application of data skills and knowledge gained from studying statistical learning.

The primary objective of this project is to demonstrate the practical application of machine learning algorithms in predicting football match outcomes. By analyzing simulated data from the football manager game and employing predictive modeling techniques, I aim to develop accurate predictions that can aid in decision-making processes for various stakeholders such as sports analysts, betting enthusiasts, and team managers.

### Methods Used
* Inferential Statistics
* Machine Learning (K-Nearest Neighbour, Linear Discriminant Analysis, Multinomial Regression, and Random Forest)
* Data Visualization
* Predictive Modeling
* Data Cleaning and Manipulation
* Model Selection

### Technologies
* R 
* Microsoft Power BI

## Project Objective
* Model Comparison: Assess the performance of different machine learning algorithms such as multinomial regression, linear discriminant analysis, random forests, and K-nearest neighbour. Compare their predictive capabilities to determine the most accurate and reliable model for football outcome prediction.

* Variable Selection: Utilize feature selection techniques to identify the most influential variables for prediction. Explore the significance of factors like team performance metrics, opponent strength, historical match data, and time-series indicators (e.g., exponential moving averages) in improving prediction accuracy.

* Time-series Analysis: Investigate various time-series methods, including exponential moving averages, to fill gaps in data and enhance predictive modeling. Determine the optimal time-series approach that maximizes prediction accuracy while accounting for the dynamic nature of football matches.

### Methodology
1. Data Collection and Preprocessing: Gather football match data, from Football Manager 2024 including relevant variables and time-series indicators. Clean and preprocess the data to ensure consistency and accuracy.

2. Preparing Training and Testing set: Split the processesed data into half, so in this case the first 20 league games should be in the training set, while the other is in the testing set. In addition, create new columns for time-series methods to predict the values for certain predictors like corners taken, ball possession, shots, etc.

3. Variable Optimization: Employ feature selection techniques and time-series analysis to identify the most influential variables and time-series methods for prediction accuracy.

4. Model Training and Evaluation: Train multiple machine learning models using the prepared dataset. Evaluate the performance of each model using appropriate metrics such as accuracy, precision, recall, and F1 score.
  
5. Model Comparison: Compare the performance of different machine learning algorithms and time-series methods to select the most suitable combination for football outcome prediction.

## Getting Started

1. Clone this repo (for help see this [tutorial](https://help.github.com/articles/cloning-a-repository/)).
2. Raw Data is being kept [here](Repo folder containing raw data) within this repo.
    
3. Data processing/transformation scripts are being kept [here](Repo folder containing data processing scripts/notebooks)
4. etc...

*If your project is well underway and setup is fairly complicated (ie. requires installation of many packages) create another "setup.md" file and link to it here*  

5. Follow setup [instructions](Link to file)


## Contact
* Feel free to contact me with any questions or if you are interested in contributing!
