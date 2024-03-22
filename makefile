all: analysis data-preparation install

data-preparation:
	make -C src/data-preparation

analysis: data-preparation
	make -C src/analysis
	
install: Install_packages.R
        export R_LIBS_USER=$(HOME)/R/packages  # Optional: Specify install location
        R --vanilla -e 'options(repos = c(CRAN = "https://mirror.lyrahosting.com/CRAN/"))' < Install_packages.R 

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