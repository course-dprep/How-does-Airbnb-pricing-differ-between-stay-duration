#load libraries
library(readr)
library(data.table)
library(dplyr)
library(broom)

#load data
Amsterdam_listings <- read_csv("listings.csv")
Tokyo_listings <- read_csv("listings_tokyo.csv")
London_listings <- read_csv("listings_london.csv")

# create a list of city datasets
city_datasets <- list(Amsterdam = filtered_dataset_Amsterdam, Tokyo = filtered_dataset_Tokyo, London = filtered_dataset_London)


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



# Perform ANOVA for each city
anova_results <- list()

# Loop through each city dataset
for (city_name in names(city_datasets)) {
  # Get the city dataset
  city_data <- city_datasets[[city_name]]
  
  # Perform ANOVA with price as IV and stay_type as DV with moderators room_type and review_scores_rating
  anova_result <- lm(stay_type_dummy ~ price * room_type * review_scores_rating, data = city_data) %>%
    anova()
  
  # Store ANOVA results in the list
  anova_results[[city_name]] <- tidy(anova_result)
}

# Print ANOVA results for each city
for (city_name in names(anova_results)) {
  cat("City:", city_name, "\n")
  print(anova_results[[city_name]])
  cat("\n")
}
