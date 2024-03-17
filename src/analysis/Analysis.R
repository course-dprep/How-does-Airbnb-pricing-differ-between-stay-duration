#load libraries
library(readr)
library(data.table)
library(dplyr)
library(broom)

#load the data

# Amsterdam_listings <- "../../data/ams_listings.csv.gz"
# Tokyo_listings <- "../../data/tyo_listings.csv.gz"
# London_listings <- "../../data/ldn_listings.csv.gz"


# Initialize an empty dataframe to store results
pricing_results <- data.frame()

# Loop through each city dataset
for (city_name in names(city_datasets)) {
  # Get the city dataset
  city_data <- city_datasets[[city_name]]$combined
  
  # Summarize pricing by stay_length
  pricing_summary <- city_data %>%
    group_by(stay_type) %>%
    summarize(mean_price = mean(price, na.rm = TRUE),
              median_price = median(price, na.rm = TRUE),
              min_price = min(price, na.rm = TRUE),
              max_price = max(price, na.rm = TRUE))
  
  # Add city name to the summary
  pricing_summary$city <- city_name
  
  # Append the summary to the results dataframe
  pricing_results <- bind_rows(pricing_results, pricing_summary)
}

# Print the combined results
print(pricing_results)


# Perform Linear Regression for each city
lr_results <- list()

# Loop through each city dataset
for (city_name in names(city_datasets)) {
  # Get the city dataset
  city_data <- city_datasets[[city_name]]
  
  # Perform Linear Regression with price as IV and stay_type as DV with moderators room_type and review_scores_rating
  lr_result <- lm(price ~ stay_type_dummy * room_type * review_scores_rating, data = city_data)
  
  # Store Linear Regression results in the list
  lr_results[[city_name]] <- tidy(lr_result)
}

# Print Linear Regression results for each city
for (city_name in names(lr_results)) {
  cat("City:", city_name, "\n")
  print(lr_results[[city_name]])
  cat("\n")
}
