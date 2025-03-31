library(ggplot2)
library(readxl)
library(dplyr)
library(scales)

setwd("/Users/davidsosa/Code/school/regression-analysis/projects/height-vs-gdp/data/new_data")
gdp_per_state <- read_excel("Data.xlsx", sheet = "gdp_per_state")
avg_height_state <- read_excel("Data.xlsx", sheet = "Average Height in Inches")
data <- merge(gdp_per_state, avg_height_state, by ="State")

data$GDP_adjusted <- ifelse(data$GDP >= 1e9, data$GDP / 1e9, data$GDP / 1e6)

ggplot(data, aes(x = GDP_adjusted, y = `Average Height (inches)`, color = GDP_adjusted)) +
  geom_point(size = 4,alpha = 0.8) + 
  scale_color_gradient(low = "lightblue", high = "blue") +
  labs(title = "GDP vs Average Height in Each State",
       x = "GDP (Billions)",
       y = "Height (inches)",
       color = "GDP Scale",
       size = "GDP Scale") +
  theme_minimal() +
  theme(
      legend.position = "none",
      plot.title = element_text(size = 16, face = "bold", family = "Arial"),  # Title bold
      axis.title = element_text(size = 14, face = "bold", family = "Arial"),  # Axis labels bold
      axis.text = element_text(size = 12, family = "Arial"),  # Axis numbers
      legend.title = element_text(size = 12, face = "bold", family = "Arial"),  # Legend bold
      legend.text = element_text(size = 11, family = "Arial")  # Legend values
    )


