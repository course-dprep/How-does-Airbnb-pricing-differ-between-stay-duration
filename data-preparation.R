#load libraries
library(readr)
library(data.table)
library(dplyr)

#load data
listings <- read_csv("listings.csv")

#Adding the short stay and long stay apartment type variable
listings$stay_type <- ifelse(listings$minimum_nights < 7, "Short-stay", "Long-stay")

#Adding other useful variables
listings$price_per_night <- round(listings$price / listings$minimum_nights, 2) #Adding the price per night


#filter dataset for only the variables we need
filtered_dataset <- listings %>% select(id, listing_url, neighbourhood, property_type, room_type, price, minimum_nights, stay_type, number_of_reviews, review_scores_rating, review_scores_accuracy, review_scores_cleanliness, review_scores_communication, review_scores_location, review_scores_value, price_per_night) 
                                       

#check for duplicates
duplicated(listings)
sum(duplicated(listings)) #there are no duplicates in the dataset


#Remove inconvenient symbols from the data
listings$price <- as.numeric(gsub("[^0-9.]", "", listings$price))

#Check the data for extreme outliers of price
summary(listings$price) #there are some extreme outliers in the price variable
boxplot(listings$price, main="Boxplot of Price") #insight in the outliers

Q1 <- quantile(listings$price, 0.25, na.rm = TRUE) #Checking outliers by using the interquartile range method
Q3 <- quantile(listings$price, 0.75, na.rm = TRUE)
IQR <- Q3 - Q1

upper_bound <- Q3 + 1.5 * IQR
lower_bound <- Q1 - 1.5 * IQR
outliers <- listings$price[listings$price > upper_bound | listings$price < lower_bound]
outliers
percentage_outliers <- length(outliers) / length(listings$price) * 100
percentage_outliers #7.5 percent of the prices lies outside the bounds

#Check for missing values 
sum(is.na(listings$minimum_nights)) #there are no missing values for minimum_nights
sum(is.na(listings$price)) #there are 296 missing prices which is 3,4% of the data
sum(is.na(listings$property_type)) #there are no missing values for property_type
sum(is.na(listings$room_type)) #there are no missing values for room_type


