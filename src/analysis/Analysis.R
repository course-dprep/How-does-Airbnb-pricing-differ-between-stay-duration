#load libraries
library(readr)
library(data.table)
library(dplyr)
library(broom)

# create a list of city datasets
city_datasets <- list(Amsterdam = combined_ams, Tokyo = combined_tyo, London = combined_ldn)

# Initialize an empty dataframe to store results
pricing_results <- data.frame()

# Loop through each city dataset
for (city_name in names(city_datasets)) {
  # Get the city dataset
  city_data <- city_datasets[[city_name]]
  
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

# Plot the pricing,stay_type,room_type data for each city
library(ggplot2)

plot_ams <- ggplot(combined_ams, aes(x = stay_type, y = price)) +
  geom_point() +
  facet_wrap(~ room_type) + ggtitle("Amsterdam")
plot_ams

plot_tyo <- ggplot(combined_tyo, aes(x = stay_type, y = price)) +
  geom_point() +
  facet_wrap(~ room_type) + ggtitle("Tokyo")
plot_tyo

plot_ldn <- ggplot(combined_ldn, aes(x = stay_type, y = price)) +
  geom_point() +
  facet_wrap(~ room_type) + ggtitle("London")
plot_ldn