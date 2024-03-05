#load libraries
library(readr)
library(data.table)
library(dplyr)

#load data
listings <- read_csv("listings.csv")

# Create a new column to classify listings as short-term or long-term based on minimum nights
listings$stay_type <- ifelse(listings$minimum_nights < 7, "Short-stay", "Long-stay")

# Remove non-numeric characters from price
listings$price <- as.numeric(gsub("[^0-9.]", "", listings$price))

# Summarize pricing by stay_length
pricing_summary <- listings %>%
  group_by(stay_type) %>%
  summarize(mean_price = mean(price, na.rm = TRUE),
            median_price = median(price, na.rm = TRUE),
            min_price = min(price, na.rm = TRUE),
            max_price = max(price, na.rm = TRUE))

# Print summary statistics
print(pricing_summary)

