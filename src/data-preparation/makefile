../../data/Amsterdam_listings.csv.gz ../../data/London_listings.csv.gz ../../Tokyo_listings.csv.gz: download-datasets.R
	R --vanilla < ../src/data-preparation/download-datasets.R

Amsterdam_aggregated_df.csv London_aggregated_df.csv Tokyo_aggregated_df.csv: data-preparation.R
	R --vanilla < ../src/data-preparation/data-preparation.R

	
clean:
	R -e "unlink('*pdf')"
	R -e "unlink('*png')"
	R -e "unlink('*csv')"
	
