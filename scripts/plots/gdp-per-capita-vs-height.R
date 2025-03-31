library(ggplot2)
library(readxl)
library(dplyr)
library(scales)

setwd("/Users/davidsosa/Code/school/regression-analysis/projects/height-vs-gdp/data/new_data")
gdp_per_state <- read_excel("Data.xlsx", sheet = "gdp_per_state")
avg_male_height <- read_excel("Data.xlsx", sheet="Average Male Height 2022")
avg_female_height <- read_excel("Data.xlsx", sheet="Average Female Height 2022")

merged_data <- merge(gdp_per_state, avg_male_height, by="State")
data <- merge(merged_data, avg_female_height, by="State")

ggplot(merged_data, aes(x = GDP, y = `Average Male Height 2022`)) +
  geom_point(size = 2, alpha = 0.6) +
  
##########################
data_long <- data %>%
  select(State, GDP, `Average Height cm.x`, `Average Height cm.y`) %>%
  pivot_longer(cols = c(`Average Height cm.x`, `Average Height cm.y`),
               names_to = "Gender",
               values_to = "Height_cm") %>%
  mutate(Gender = ifelse(Gender == "Average Height cm.x", "Male", "Female"))

data_long$GDP_adjusted <- ifelse(data_long$GDP >= 1e9, data_long$GDP / 1e9, data_long$GDP / 1e6)


ggplot(data_long, aes(x = GDP_adjusted, y = Height_cm, color = Gender)) +
  geom_point(size = 3, alpha = 0.7) +
  scale_x_continuous(labels = scales::comma) +  # Format large numbers
  labs(title = "GDP vs. Average Height",
       x = "GDP (Billions/Millions)",
       y = "Average Height (cm)") +
  theme_minimal()
