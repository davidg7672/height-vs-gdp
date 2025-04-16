install.packages("haven")
library(haven)

setwd("/Users/davidsosa/Code/school/regression-analysis/projects/height-vs-gdp/scripts/data_engineering")
data <- read_xpt("DEMO_L.xpt")

write.csv(data, "converted_data.csv", row.names = FALSE)