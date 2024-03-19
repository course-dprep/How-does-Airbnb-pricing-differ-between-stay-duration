#Load libraries
library(tidyverse)
library(dplyr)

dir.create("../../data")

# create a list of urls that we want to download and the names we want to give them
list_urls <- list(c(url='http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2023-12-12/data/listings.csv.gz'), 
                  c(url='http://data.insideairbnb.com/united-kingdom/england/london/2023-12-10/data/listings.csv.gz'),
                  c(url='http://data.insideairbnb.com/japan/kant%C5%8D/tokyo/2023-12-27/data/listings.csv.gz')
)

#names for earch dataset
names <- c('Amsterdam_listings', 'London_listings', 'Tokyo_listings')

for (i in 1:length(list_urls)) { 
  download.file(list_urls[[i]]['url'],  # Access the 'url' element with single brackets
                paste0("../../data/", names[i], ".csv.gz"), 
                mode = "wb")
}



