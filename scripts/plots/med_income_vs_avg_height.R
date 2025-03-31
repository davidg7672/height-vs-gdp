library(ggplot2)
library(readxl)
library(dplyr)
library(scales)

setwd("/Users/davidsosa/Code/school/regression-analysis/projects/height-vs-gdp/data/new_data")
height_data_by_state <- read_excel("Data.xlsx", sheet = "Average Height in Inches")
median_house_income_by_state <- read_excel("Data.xlsx", sheet = "Median Household Income")
merged_data <- merge(height_data_by_state, median_house_income_by_state, by = "State")

merged_data$MedianAnnualHouseholdIncome <- as.numeric(gsub("[$,]", "", merged_data$MedianAnnualHouseholdIncome))


ggplot(merged_data, aes(x = MedianAnnualHouseholdIncome, y = `Average Height (inches)`, color = MedianAnnualHouseholdIncome)) +
  geom_point(size = 3) +
  scale_color_gradient(low="lightblue", high="blue") +
  labs(title = "Median Household Income vs Average Height Per State",
       x = "Median Household Income",
       y = "Height (inches)",
       fill = "Gender") +
  scale_x_continuous(labels = comma) +  # Format x-axis with commas
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(size = 20, face = "bold", family = "Arial"),  # Title bold
    axis.title = element_text(size = 16, face = "bold", family = "Arial"),  # Axis labels bold
    axis.text = element_text(size = 12, family = "Arial"),  # Axis numbers
    legend.title = element_text(size = 12, face = "bold", family = "Arial"),  # Legend bold
    legend.text = element_text(size = 11, family = "Arial")  # Legend values
  )
