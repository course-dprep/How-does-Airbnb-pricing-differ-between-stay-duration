Amsterdam_listings.csv.gz London_listings.csv.gz Tokyo_listings.csv.gz: 
	R --vanilla < ../src/data-preparation/download-datasets.R

Amsterdam_aggregated_df.csv London_aggregated_df.csv Tokyo_aggregated_df.csv:
	R --vanilla < ../src/data-preparation/data-preparation.R

	
clean:
	R -e "unlink('*pdf')"
	R -e "unlink('*png')"
	R -e "unlink('*csv')"
	
