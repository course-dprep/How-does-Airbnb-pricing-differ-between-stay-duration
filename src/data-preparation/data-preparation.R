#install packages
install.packages("DescTools")

#load libraries
library(readr)
library(data.table)
library(dplyr)
library(DescTools) # winsorize library

#loop through each city dataset
process_city_data <- function(city_url) {
  # Read data
  city_listings <- read_csv(city_url)
  
  # Adding the short stay and long stay apartment type variable
  city_listings$stay_type <- ifelse(city_listings$minimum_nights < 7, "Short-stay", "Long-stay")
  city_listings$stay_type_dummy <- ifelse(city_listings$stay_type == "Short-stay", 1, 0)
  
  # Remove inconvenient symbols from the data
  city_listings$price <- as.numeric(gsub("[^0-9.]", "", city_listings$price))
  
  # Filter dataset for only the variables we need and remove listings without a price
  filtered_dataset <- city_listings %>%
    select(id, listing_url, neighbourhood, property_type, room_type, price, minimum_nights, stay_type, stay_type_dummy, number_of_reviews, review_scores_rating, review_scores_accuracy, review_scores_cleanliness, review_scores_communication, review_scores_location, review_scores_value) %>%
    filter(!is.na(price)) %>%
    filter(number_of_reviews > 0)
  
  # Check for duplicates
  sum(duplicated(filtered_dataset))
  
  # Check the data for extreme outliers of price
  Q1 <- quantile(filtered_dataset$price, 0.25, na.rm = TRUE)
  Q3 <- quantile(filtered_dataset$price, 0.75, na.rm = TRUE)
  IQR <- Q3 - Q1
  
  upper_bound <- Q3 + 1.5 * IQR
  lower_bound <- Q1 - 1.5 * IQR
  outliers <- filtered_dataset$price[filtered_dataset$price > upper_bound | filtered_dataset$price < lower_bound]
  percentage_outliers <- length(outliers) / length(filtered_dataset$price) * 100
  
  # Winsorize prices by property type (0.05-0.95 percentiles)
  filtered_by_pt <- split(filtered_dataset, filtered_dataset$property_type)
  winsorized_prices <- lapply(filtered_by_pt, winsorize_price)
  combined <- do.call(rbind, winsorized_prices)
  
  # Return processed data with outliers deleted
  return(list(filtered_dataset = filtered_dataset, outliers = outliers, percentage_outliers = percentage_outliers, combined = combined))
}

# List of city URLs
city_urls <- c(
  "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2023-12-12/data/listings.csv.gz",
  "http://data.insideairbnb.com/japan/kant%C5%8D/tokyo/2023-12-27/data/listings.csv.gz",
  "http://data.insideairbnb.com/united-kingdom/england/london/2023-12-10/data/listings.csv.gz"
)

# Process data for each city
city_datasets <- lapply(city_urls, process_city_data)

# Access processed data for each city

names(city_datasets) <- c("Amsterdam", "Tokyo", "London")
