#install packages
install.packages("DescTools")

#load libraries
library(readr)
library(data.table)
library(dplyr)
library(DescTools) # winsorize library

#load data
Amsterdam_listings <- read_csv("http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2023-12-12/data/listings.csv.gz")

#Adding the short stay and long stay apartment type variable
Amsterdam_listings$stay_type <- ifelse(Amsterdam_listings$minimum_nights < 7, "Short-stay", "Long-stay")
#Adding a dummy variable for the stay type
Amsterdam_listings$stay_type_dummy <- ifelse(Amsterdam_listings$stay_type == "Short-stay", 1, 0)

#Remove inconvenient symbols from the data
Amsterdam_listings$price <- as.numeric(gsub("[^0-9.]", "", Amsterdam_listings$price))

#Check for missing values 
sum(is.na(Amsterdam_listings$minimum_nights)) #there are no missing values for minimum_nights
sum(is.na(Amsterdam_listings$price)) #there are 296 missing prices which is 3,4% of the data
sum(is.na(Amsterdam_listings$property_type)) #there are no missing values for property_type
sum(is.na(Amsterdam_listings$room_type)) #there are no missing values for room_type

#filter dataset for only the variables we need and remove all the listings (rows) that doesnt have a price (NA, missing value)
filtered_dataset_Amsterdam <- Amsterdam_listings %>% select(id, listing_url, neighbourhood, property_type, room_type, price, minimum_nights, stay_type, stay_type_dummy, number_of_reviews, review_scores_rating, review_scores_accuracy, review_scores_cleanliness, review_scores_communication, review_scores_location, review_scores_value) %>% filter(!is.na(price)) %>% filter(number_of_reviews > 0)
                                       
#check for duplicates
sum(duplicated(filtered_dataset_Amsterdam)) #there are no duplicates in the dataset

#Check the data for extreme outliers of price
summary(filtered_dataset_Amsterdam$price) #there are some extreme outliers in the price variable
boxplot(filtered_dataset_Amsterdam$price, main="Boxplot of Price") #insight in the outliers

Q1 <- quantile(filtered_dataset_Amsterdam$price, 0.25, na.rm = TRUE) #Checking outliers by using the interquartile range method
Q3 <- quantile(filtered_dataset_Amsterdam$price, 0.75, na.rm = TRUE)
IQR <- Q3 - Q1

upper_bound <- Q3 + 1.5 * IQR
lower_bound <- Q1 - 1.5 * IQR
outliers <- filtered_dataset_Amsterdam$price[filtered_dataset_Amsterdam$price > upper_bound | filtered_dataset_Amsterdam$price < lower_bound]
outliers
percentage_outliers <- length(outliers) / length(filtered_dataset_Amsterdam$price) * 100
percentage_outliers #4.2 percent of the prices lies outside the bounds

#Winsorize prices by property type (0.05-0.95 percentiles)
##Filter data by property type
filtered_by_pt_ams <- split(filtered_dataset_Amsterdam, filtered_dataset_Amsterdam$property_type) 
##Winsorize price column with specified percentiles (function)
winsorize_price <- function(data, lower = 0.05, upper = 0.95) { 
  data$price <- with(data, pmin(pmax(price, quantile(price, lower)), quantile(price, upper)))
  return(data)
}
##Apply the winsorize function to each property type
winsorized_prices_ams <- lapply(filtered_by_pt_ams, winsorize_price)
##Combine the winsorized data into one overview
combined_ams <- do.call(rbind, winsorized_prices_ams)

boxplot(combined_ams$price, main="Boxplot of Price") #insight in the outliers after winsorized prices. 
boxplot(filtered_dataset_Amsterdam$price, main="Boxplot of Price") #insight in the outliers without winsorized prices.


###############


#Doing the same process for Tokyo
Tokyo_listings <- read_csv("http://data.insideairbnb.com/japan/kant%C5%8D/tokyo/2023-12-27/data/listings.csv.gz")

Tokyo_listings$stay_type <- ifelse(Tokyo_listings$minimum_nights < 7, "Short-stay", "Long-stay")
Tokyo_listings$stay_type_dummy <- ifelse(Tokyo_listings$stay_type == "Short-stay", 1, 0)

Tokyo_listings$price <- as.numeric(gsub("[^0-9.]", "", Tokyo_listings$price))

sum(is.na(Tokyo_listings$minimum_nights)) #there are no missing values for minimum_nights
sum(is.na(Tokyo_listings$price)) #there are 413 missing prices
sum(is.na(Tokyo_listings$property_type)) #there are no missing values for property_type
sum(is.na(Tokyo_listings$room_type)) #there are no missing values for room_type

filtered_dataset_Tokyo <- Tokyo_listings %>% select(id, listing_url, neighbourhood, property_type, room_type, price, minimum_nights, stay_type, stay_type_dummy, number_of_reviews, review_scores_rating, review_scores_accuracy, review_scores_cleanliness, review_scores_communication, review_scores_location, review_scores_value) %>% filter(!is.na(price)) %>% filter(number_of_reviews > 0)
sum(is.na(filtered_dataset_Tokyo$price)) #no missing value for prices anymore

sum(duplicated(filtered_dataset_Tokyo)) #there are no duplicates in the dataset

summary(filtered_dataset_Tokyo$price) #there are some extreme outliers in the price variable
boxplot(filtered_dataset_Tokyo$price, main="Boxplot of Price") #insight in the outliers

Q1 <- quantile(filtered_dataset_Tokyo$price, 0.25, na.rm = TRUE) #Checking outliers by using the interquartile range method
Q3 <- quantile(filtered_dataset_Tokyo$price, 0.75, na.rm = TRUE)
IQR <- Q3 - Q1

upper_bound <- Q3 + 1.5 * IQR
lower_bound <- Q1 - 1.5 * IQR
outliers <- filtered_dataset_Tokyo$price[filtered_dataset_Tokyo$price > upper_bound | filtered_dataset_Tokyo$price < lower_bound]
outliers
percentage_outliers <- length(outliers) / length(filtered_dataset_Tokyo$price) * 100
percentage_outliers #6.9 percent of the prices lies outside the bounds

#Winsorize prices by property type (0.05-0.95 percentiles)
##Filter data by property type
filtered_by_pt_tyo <- split(filtered_dataset_Tokyo, filtered_dataset_Tokyo$property_type) 

##Apply the winsorize function to each property type
winsorized_prices_tyo <- lapply(filtered_by_pt_tyo, winsorize_price) #winsorize_price() function is already defined in the Amsterdam section. so re-use.
##Combine the winsorized data into one overview
combined_tyo <- do.call(rbind, winsorized_prices_tyo)

boxplot(combined_tyo$price, main="Boxplot of Price") #insight in the outliers after winsorized prices. 
boxplot(filtered_dataset_Tokyo$price, main="Boxplot of Price") #insight in the outliers without winsorized prices.



###############



#Doing the same process for London
London_listings <- read_csv("http://data.insideairbnb.com/united-kingdom/england/london/2023-12-10/data/listings.csv.gz")

London_listings$stay_type <- ifelse(London_listings$minimum_nights < 7, "Short-stay", "Long-stay")
London_listings$stay_type_dummy <- ifelse(London_listings$stay_type == "Short-stay", 1, 0)

London_listings$price <- as.numeric(gsub("[^0-9.]", "", London_listings$price))

sum(is.na(London_listings$minimum_nights)) #there are no missing values for minimum_nights
sum(is.na(London_listings$price)) #there are 4180 missing prices
sum(is.na(London_listings$property_type)) #there are no missing values for property_type
sum(is.na(London_listings$room_type)) #there are no missing values for room_type

filtered_dataset_London <- London_listings %>% select(id, listing_url, neighbourhood, property_type, room_type, price, minimum_nights, stay_type, stay_type_dummy, number_of_reviews, review_scores_rating, review_scores_accuracy, review_scores_cleanliness, review_scores_communication, review_scores_location, review_scores_value) %>% filter(!is.na(price)) %>% filter(number_of_reviews > 0)
sum(is.na(filtered_dataset_London$price)) #no missing value for prices anymore

sum(duplicated(filtered_dataset_London)) #there are no duplicates in the dataset

summary(filtered_dataset_London$price) #there are some extreme outliers in the price variable
boxplot(filtered_dataset_London$price, main="Boxplot of Price") #insight in the outliers

Q1 <- quantile(filtered_dataset_London$price, 0.25, na.rm = TRUE) #Checking outliers by using the interquartile range method
Q3 <- quantile(filtered_dataset_London$price, 0.75, na.rm = TRUE)
IQR <- Q3 - Q1

upper_bound <- Q3 + 1.5 * IQR
lower_bound <- Q1 - 1.5 * IQR
outliers <- filtered_dataset_London$price[filtered_dataset_London$price > upper_bound | filtered_dataset_London$price < lower_bound]
outliers

percentage_outliers <- length(outliers) / length(filtered_dataset_London$price) * 100
percentage_outliers #7,6 percent of the prices lies outside the bounds

#Winsorize prices by property type (0.05-0.95 percentiles)
##Filter data by property type
filtered_by_pt_ldn <- split(filtered_dataset_London , filtered_dataset_London$property_type) 

##Apply the winsorize function to each property type
winsorized_prices_ldn <- lapply(filtered_by_pt_ldn, winsorize_price) #winsorize_price() function is already defined in the Amsterdam section. so re-use.
##Combine the winsorized data into one overview
combined_ldn <- do.call(rbind, winsorized_prices_ldn)

boxplot(combined_ldn$price, main="Boxplot of Price") #insight in the outliers after winsorized prices. 
boxplot(filtered_dataset_London$price, main="Boxplot of Price") #insight in the outliers without winsorized prices.
