library(readxl)
library(tidyr)
library(ggplot2)
library(janitor)
library(dplyr)

setwd("/Users/davidsosa/Code/school/regression-analysis/projects/height-vs-gdp/data/new_data")

# running two separate regression men and women
average_height_male = read_excel("Data.xlsx", sheet = "Average Male Height 2022")
average_height_female = read_excel("Data.xlsx", sheet = "Average Female Height 2022")
demographics = read_excel("Data.xlsx", sheet = "demographic of each state")
foreign_born_percentage = read_excel("Data.xlsx", sheet="State_Nativity_Data")
merged_data_male = average_height_male
merged_data_female = average_height_female

# income by state
income_state_by_state = read_excel("Data.xlsx", sheet = "income")

# merged income
merged_data_male$income <- income_state_by_state$`Median Income Male`[match(merged_data_male$State, income_state_by_state$State2)]
merged_data_female$income <- income_state_by_state$`Median Income Female`[match(merged_data_female$State, income_state_by_state$State2)]

# merging state nativity
merged_data_male$foreign_born <- foreign_born_percentage$`Foreign-Born`[match(merged_data_male$State, foreign_born_percentage$State)]
merged_data_female$foreign_born <- foreign_born_percentage$`Foreign-Born`[match(merged_data_female$State, foreign_born_percentage$State)]

# race/demographics merging
race_raw_data <- read_excel("Data.xlsx", sheet = "demographic of each state")

demographic <- race_raw_data |>
  select(State = Column1, White = Column2, Black = Column3, Hispanic = Column4, Asian = Column5) |>
  filter(State != "United States") |>
  mutate(across(where(is.character), as.numeric, .names = "num_{.col}"))

new_data <- read.csv("cleaned_regression_data.csv")
data <- read.csv("cleaned_regression_data.csv")


data$Log_Male_Income <- log(data$Median_Income_Male)
data$Log_Female_Income <- log(data$Median_Income_Female)

model_male <- lm(Log_Male_Income ~ Average_Height +
              Pct_Bachelors_or_more + White + Black + Hispanic + Asian +
              Foreign.Born, data = data)


model_female <- lm(Log_Female_Income ~ Average_Height  +
                   Pct_Bachelors_or_more + White + Black + Hispanic + Asian +
                   Foreign.Born, data = data)
summary(model_male)
summary(model_female)



data$White <- scale(data$White, scale = FALSE)

######################
setwd("/Users/davidsosa/Code/school/regression-analysis/projects/height-vs-gdp/data/new_data")
# move data
data <- read.csv("combined_gender_income_data.csv")

# Make Gender a factor
data$Gender <- as.factor(data$Gender)

# Run model with Gender as a variable
model <- lm(Log_Income ~ Gender + Average_Height + Pct_Bachelors_or_more + White + Black + Hispanic + Asian + Foreign.Born, data = data)
summary(model)
