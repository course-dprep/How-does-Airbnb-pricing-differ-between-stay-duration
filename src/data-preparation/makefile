all: ../../output/Amsterdam_aggregated_df.csv ../../output/Tokyo_aggregated.csv ../../output/London_aggregated.csv ../../output/airbnb_listings_distribution.png ../../output/stay_category_distribution.png ../../output/room_type_distribution.png

#download the datasets
../../data/Amsterdam_listings.csv.gz ../../data/Tokyo_listings.csv.gz ../../data/London_listings.csv.gz: download_datasets.R
	R --vanilla < download_datasets.R

#data exploration
../../output/airbnb_listings_distribution.png ../../output/stay_category_distribution.png ../../output/room_type_distribution.png: ../data-preparation/data-exploration.R ../../data/Amsterdam_listings.csv.gz ../../data/Tokyo_listings.csv.gz ../../data/London_listings.csv.gz
	R --vanilla < ../data-preparation/data-exploration.R

# data preparation
../../output/Amsterdam_aggregated_df.csv ../../output/Tokyo_aggregated.csv ../../output/London_aggregated.csv: ../data-preparation/data-preparation.R ../../data/Amsterdam_listings.csv.gz ../../data/Tokyo_listings.csv.gz ../../data/London_listings.csv.gz
	R --vanilla < ../data-preparation/data-preparation.R

clean:
	R -e "unlink('../../output/*.csv')"
	R -e "unlink('../../output/*.png')"

