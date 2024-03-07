#load libraries
library(readr)
library(data.table)
library(dplyr)

#load data
Amsterdam_listings <- read_csv("ams_listings.csv")

#Adding the short stay and long stay apartment type variable
Amsterdam_listings$stay_type <- ifelse(Amsterdam_listings$minimum_nights < 7, "Short-stay", "Long-stay")
#Adding a dummy variable for the stay type
Amsterdam_listings$stay_type_dummy <- ifelse(Amsterdam_listings$stay_type == "Short-stay", 1, 0)

#Remove inconvenient symbols from the data
Amsterdam_listings$price <- as.numeric(gsub("[^0-9.]", "", Amsterdam_listings$price))

#filter dataset for only the variables we need
filtered_dataset_Amsterdam <- Amsterdam_listings %>% select(id, listing_url, neighbourhood, property_type, room_type, price, minimum_nights, stay_type, stay_type_dummy, number_of_reviews, review_scores_rating, review_scores_accuracy, review_scores_cleanliness, review_scores_communication, review_scores_location, review_scores_value) 
                                       

#check for duplicates
duplicated(Amsterdam_listings)
sum(duplicated(Amsterdam_listings)) #there are no duplicates in the dataset



#Check the data for extreme outliers of price
summary(Amsterdam_listings$price) #there are some extreme outliers in the price variable
boxplot(Amsterdam_listings$price, main="Boxplot of Price") #insight in the outliers

Q1 <- quantile(Amsterdam_listings$price, 0.25, na.rm = TRUE) #Checking outliers by using the interquartile range method
Q3 <- quantile(Amsterdam_listings$price, 0.75, na.rm = TRUE)
IQR <- Q3 - Q1

upper_bound <- Q3 + 1.5 * IQR
lower_bound <- Q1 - 1.5 * IQR
outliers <- Amsterdam_listings$price[Amsterdam_listings$price > upper_bound | Amsterdam_listings$price < lower_bound]
outliers
percentage_outliers <- length(outliers) / length(Amsterdam_listings$price) * 100
percentage_outliers #7.5 percent of the prices lies outside the bounds

#Check for missing values 
sum(is.na(Amsterdam_listings$minimum_nights)) #there are no missing values for minimum_nights
sum(is.na(Amsterdam_listings$price)) #there are 296 missing prices which is 3,4% of the data
sum(is.na(Amsterdam_listings$property_type)) #there are no missing values for property_type
sum(is.na(Amsterdam_listings$room_type)) #there are no missing values for room_type






#Doing the same process for Tokyo
Tokyo_listings <- read_csv("tyo_listings.csv")

Tokyo_listings$stay_type <- ifelse(Tokyo_listings$minimum_nights < 7, "Short-stay", "Long-stay")
Tokyo_listings$stay_type_dummy <- ifelse(Tokyo_listings$stay_type == "Short-stay", 1, 0)

Tokyo_listings$price <- as.numeric(gsub("[^0-9.]", "", Tokyo_listings$price))

filtered_dataset_Tokyo <- Tokyo_listings %>% select(id, listing_url, neighbourhood, property_type, room_type, price, minimum_nights, stay_type, stay_type_dummy, number_of_reviews, review_scores_rating, review_scores_accuracy, review_scores_cleanliness, review_scores_communication, review_scores_location, review_scores_value) 

duplicated(Tokyo_listings)
sum(duplicated(Tokyo_listings)) #there are no duplicates in the dataset


summary(Tokyo_listings$price) #there are some extreme outliers in the price variable
boxplot(Tokyo_listings$price, main="Boxplot of Price") #insight in the outliers

Q1 <- quantile(Tokyo_listings$price, 0.25, na.rm = TRUE) #Checking outliers by using the interquartile range method
Q3 <- quantile(Tokyo_listings$price, 0.75, na.rm = TRUE)
IQR <- Q3 - Q1

upper_bound <- Q3 + 1.5 * IQR
lower_bound <- Q1 - 1.5 * IQR
outliers <- Tokyo_listings$price[Tokyo_listings$price > upper_bound | Tokyo_listings$price < lower_bound]
outliers
percentage_outliers <- length(outliers) / length(Tokyo_listings$price) * 100
percentage_outliers #9.7 percent of the prices lies outside the bounds

sum(is.na(Tokyo_listings$minimum_nights)) #there are no missing values for minimum_nights
sum(is.na(Tokyo_listings$price)) #there are 413 missing prices
sum(is.na(Tokyo_listings$property_type)) #there are no missing values for property_type
sum(is.na(Tokyo_listings$room_type)) #there are no missing values for room_type





#Doing the same process for London
London_listings <- read_csv("ldn_lisitings.csv")

London_listings$stay_type <- ifelse(London_listings$minimum_nights < 7, "Short-stay", "Long-stay")
London_listings$stay_type_dummy <- ifelse(London_listings$stay_type == "Short-stay", 1, 0)

London_listings$price <- as.numeric(gsub("[^0-9.]", "", London_listings$price))

filtered_dataset_London <- London_listings %>% select(id, listing_url, neighbourhood, property_type, room_type, price, minimum_nights, stay_type, stay_type_dummy, number_of_reviews, review_scores_rating, review_scores_accuracy, review_scores_cleanliness, review_scores_communication, review_scores_location, review_scores_value) 

duplicated(London_listings)
sum(duplicated(London_listings)) #there are no duplicates in the dataset


summary(London_listings$price) #there are some extreme outliers in the price variable
boxplot(London_listings$price, main="Boxplot of Price") #insight in the outliers

Q1 <- quantile(London_listings$price, 0.25, na.rm = TRUE) #Checking outliers by using the interquartile range method
Q3 <- quantile(London_listings$price, 0.75, na.rm = TRUE)
IQR <- Q3 - Q1

upper_bound <- Q3 + 1.5 * IQR
lower_bound <- Q1 - 1.5 * IQR
outliers <- London_listings$price[London_listings$price > upper_bound | London_listings$price < lower_bound]
outliers
percentage_outliers <- length(outliers) / length(London_listings$price) * 100
percentage_outliers #11,8 percent of the prices lies outside the bounds

sum(is.na(London_listings$minimum_nights)) #there are no missing values for minimum_nights
sum(is.na(London_listings$price)) #there are 4180 missing prices
sum(is.na(London_listings$property_type)) #there are no missing values for property_type
sum(is.na(London_listings$room_type)) #there are no missing values for room_type
