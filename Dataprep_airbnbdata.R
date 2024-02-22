library(readr)
listings <- read_csv("listings.csv")
View(listings)

library(dplyr)

# Assume your Airbnb data is stored in a dataframe called 'airbnb_data'

# Create a new column to classify listings as short-term or long-term based on minimum nights
listings$stay_type <- ifelse(listings$minimum_nights < 7, "Short-stay", "Long-stay")
head(listings)


# Summarize pricing by stay_length
pricing_summary <- listing %>%
  group_by(stay_length) %>%
  summarize(mean_price = mean(price),
            median_price = median(price),
            min_price = min(price),
            max_price = max(price))

# Print summary statistics
print(pricing_summary)

