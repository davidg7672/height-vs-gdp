library(ggplot2)
library(readxl)

# Load Data
data <- read_excel("Data.xlsx", sheet = "Average Height in Inches")
gdp <- read_excel("Data.xlsx", sheet = "gdp-by-state-2025")

# Merge data on State
merged_data <- merge(data, gdp, by.x = "Region", by.y = "state")

# Scatterplot
ggplot(merged_data, aes(x = StateGDPPerCapita2022, y = `Average Height (inches)`, color = StateGDPPerCapita2022)) +
  geom_point(alpha = 1, size = 2) +
  scale_color_gradient(low = "blue", high = "red") +  # Gradient from low to high GDP
  labs(title = "Average Height vs. GDP per State",
       x = "GDP Per Capita",
       y = "Average Height (inches)",
       color = "GDP Per Capita") +
  theme_minimal() + 
  theme(plot.title = element_text(face = "bold", size = 12),  # Bold title
        plot.subtitle = element_text(size = 12, face = "italic"))  

