############################################################
library(readxl)
library(dplyr)

setwd("/Users/davidsosa/Code/school/regression-analysis/projects/height-vs-gdp/data/new_data")
data <- read_excel("new_clean_data.xlsx", sheet = 1)

# Clean the data: keep only needed columns
data_clean <- data %>%
  select(State, Male_Income, Male_Log_Income, Female_Log_Income, Female_Income, `fixed male height`, `Female Height Fixed`, Pct_Bachelors_or_more, White, Black, Hispanic, Asian, Foreign.Born)

# Rename columns for easier coding
colnames(data_clean) <- c("State", "Male_Income", "Male_Log_Income", "Female_Log_Income", "Female_Income", "Male_Height", "Female_Height", "Pct_Bachelors_or_more", "White", "Black", "Hispanic", "Asian", "Foreign_Born")

# Run regression 1: Male height
model_male <- lm(Male_Log_Income ~ Male_Height + Pct_Bachelors_or_more + White + Black + Hispanic + Asian + Foreign_Born, data = data_clean)
summary(model_male)
plot(model_male)


############################################################
# Run regression 2: Female height
model_female <- lm(Female_Log_Income ~ Female_Height + Pct_Bachelors_or_more + White + Black + Hispanic + Asian + Foreign_Born, data = data_clean)
summary(model_female)


model_male <- lm(Male_Income ~ Male_Height + Pct_Bachelors_or_more + White + Black + Hispanic + Asian + Foreign_Born, data = data_clean)
summary(model_male)
model_female <- lm(Female_Income ~ Female_Height + Pct_Bachelors_or_more + White + Black + Hispanic + Asian + Foreign_Born, data = data_clean)
summary(model_female)
