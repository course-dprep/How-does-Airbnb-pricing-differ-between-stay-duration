all: ../../output/Amsterdam_lr_results.csv ../../output/Tokyo_lr_results.csv ../../output/London_lr_results.csv ../../output/pricing_results.csv 

../../output/Amsterdam_lr_results.csv ../../output/Tokyo_lr_results.csv ../../output/London_lr_results.csv ../../output/pricing_results.csv: ../analysis/analysis.R ../../output/Amsterdam_aggregated_df.csv ../../output/Tokyo_aggregated_df.csv ../../output/London_aggregated_df.csv
	R --vanilla < ../analysis/analysis.R

# Define variables
RMD_DIR = ../analysis
PDF_DIR = ../../output
RMD_FILE = $(RMD_DIR)/exploration_and_results.Rmd
PDF_FILE = $(PDF_DIR)/exploration_and_results.pdf

# Default target
all: $(PDF_FILE)

# Rule to generate the PDF from Rmd
$(PDF_FILE): $(RMD_FILE)
	Rscript -e 'rmarkdown::render("$<", output_dir = "$(PDF_DIR)")'

# Phony targets
.PHONY: all 

clean:
	R -e "unlink('../../output/Amsterdam_lr_results.csv')"
	R -e "unlink('../../output/Tokyo_lr_results.csv')"
	R -e "unlink('../../output/London_lr_results.csv')"
	R -e "unlink('../../output/pricing_results.csv')"
	R -e "unlink('../../output/exploration_and_results.pdf')"
