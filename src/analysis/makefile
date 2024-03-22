all: ../analysis/Amsterdam_lr_results.csv ../analysis/Tokyo_lr_results.csv ../analysis/London_lr_results.csv ../analysis/pricing_results.csv 

../analysis/Amsterdam_lr_results.csv ../analysis/Tokyo_lr_results.csv ../analysis/London_lr_results.csv ../analysis/pricing_results.csv: ../analysis/Analysis.R ../data-preparation/Amsterdam_aggregated_df.csv ../data-preparation/Tokyo_aggregated_df.csv ../data-preparation/London_aggregated_df.csv
	R --vanilla < ../analysis/Analysis.R


#clean:
#	R -e "unlink('../analysis/*.csv')"
	
# Define variables
RMD_DIR = ../output
PDF_DIR = ../output
RMD_FILE = $(RMD_DIR)/exploration_and_results.Rmd
PDF_FILE = $(PDF_DIR)/exploration_and_results.pdf

# Default target
all: $(PDF_FILE)

# Rule to generate the PDF from Rmd
$(PDF_FILE): $(RMD_FILE)
	Rscript -e 'rmarkdown::render("$<", output_dir = "$(PDF_DIR)")'

# Clean rule
#clean:
#	rm -f $(PDF_FILE)

# Phony targets
.PHONY: all 