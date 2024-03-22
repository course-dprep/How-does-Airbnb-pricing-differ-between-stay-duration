#load libraries
library(dplyr)
library(ggplot2)

# Load the raw city listings 
Amsterdam_listings <- read_csv("../../data/Amsterdam_listings.csv.gz")
Tokyo_listings <- read_csv("../../data/Tokyo_listings.csv.gz")
London_listings <- read_csv("../../data/London_listings.csv.gz")

# Combine the DataFrames into a single DataFrame
combined_listings <- rbind(Amsterdam_listings, Tokyo_listings, London_listings)

# Add a "City" column for clarity 
combined_listings$City <- c(rep("Amsterdam", nrow(Amsterdam_listings)),
                            rep("Tokyo", nrow(Tokyo_listings)),
                            rep("London", nrow(London_listings)))

###Listings_per_city###
# Count the number of listings per city
listings_per_city <- combined_listings %>%
  group_by(City) %>%
  summarize(num_listings = n())

# Create the bar chart
ggplot(listings_per_city, aes(x = reorder(City, num_listings), y = num_listings)) +
  geom_bar(stat = "identity", fill= c("plum", "forestgreen", "deepskyblue4")) +
  labs(x = "City", y = "Number of Listings", 
       title = "Airbnb Listings Distribution Across Cities") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_text(aes(label = num_listings), vjust = -0.5, color = "black", size = 3) 

# Save the plot as a PNG file
ggsave("../data-preparation/airbnb_listings_distribution.png", width = 8, height = 6, dpi = 300)

###Stay_type###
# Create a new column for the stay length category
combined_listings$stay_category <- ifelse(combined_listings$minimum_nights < 7, 
                                          "short-stay", "long-stay")

# Create the histogram
ggplot(combined_listings, aes(x = stay_category, fill = City)) +
  geom_bar(position = "dodge") +  
  labs(x = "Stay Category", y = "Number of Listings",
       title = "Distribution of Short-Stay and Long-Stay Listings Across Cities") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_manual(values = c("plum", "forestgreen", "deepskyblue4"))

# save the historgram as a PNG file
ggsave("../data-preparation/stay_category_distribution.png", width = 8, height = 6, dpi = 300)

###Room_type###
# Get counts of room types per city
room_type_counts <- combined_listings %>% 
  group_by(City, room_type) %>%
  summarize(count = n())

# Create a faceted bar chart 
ggplot(room_type_counts, aes(x = room_type, y = count, fill = City)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Room Type", y = "Count",  
       title = "Count of Room Types in Each City") +
  facet_wrap(~ City) +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_manual(values = c("plum", "forestgreen", "deepskyblue4")) 

# save the plot as a PNG file
ggsave("../data-preparation/room_type_distribution.png", width = 8, height = 6, dpi = 300)
