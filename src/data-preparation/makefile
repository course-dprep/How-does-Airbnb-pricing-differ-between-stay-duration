all: ../data-preparation/Amsterdam_aggregated_df.csv ../data-preparation/Tokyo_aggregated.csv ../data-preparation/London_aggregated.csv ../../data-preparation/airbnb_listings_distribution.png ../../data-preparation/stay_category_distribution.png ../../data-preparation/room_type_distribution.png

#download the datasets
../../data/Amsterdam_listings.csv.gz ../../data/Tokyo_listings.csv.gz ../../data/London_listings.csv.gz: download_datasets.R
	R --vanilla < download_datasets.R

#data exploration
../../data-preparation/airbnb_listings_distribution.png ../../data-preparation/stay_category_distribution.png ../../data-preparation/room_type_distribution.png: ../data-preparation/data-exploration.R ../../data/Amsterdam_listings.csv.gz ../../data/Tokyo_listings.csv.gz ../../data/London_listings.csv.gz
	R --vanilla < ../data-preparation/data-exploration.R
# data preparation
../data-preparation/Amsterdam_aggregated_df.csv ../data-preparation/Tokyo_aggregated.csv ../data-preparation/London_aggregated.csv: ../data-preparation/data-preparation.R ../../data/Amsterdam_listings.csv.gz ../../data/Tokyo_listings.csv.gz ../../data/London_listings.csv.gz
	R --vanilla < ../data-preparation/data-preparation.R

