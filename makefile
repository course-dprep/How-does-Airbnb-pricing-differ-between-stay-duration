all: install analysis data-preparation

data-preparation:
	make -C src/data-preparation

analysis: data-preparation
	make -C src/analysis
	
install: install_packages.R
	export R_LIBS_USER=C:\Users\Lingwei/R/packages
	Rscript -e 'options(repos = c(CRAN = "https://mirror.lyrahosting.com/CRAN/")); packages <- c("broom", "dplyr", "ggplot2", "tidyverse", "readr", "data.table", "DescTools"); if (length(setdiff(packages, installed.packages()[,"Package"])) > 0) install.packages(setdiff(packages, installed.packages()[,"Package"]))' 

clean:
	R -e "unlink('output/*.csv')"
	R -e "unlink('output/*.png')"
	R -e "unlink('data/*.csv.gz')"
	R -e "unlink('src/data-preparation/*.pdf')"
	R -e "unlink('output/Amsterdam_lr_results.csv')"
	R -e "unlink('output/Tokyo_lr_results.csv')"
	R -e "unlink('output/London_lr_results.csv')"
	R -e "unlink('output/pricing_results.csv')"
	R -e "unlink('output/exploration_and_results.pdf')"

