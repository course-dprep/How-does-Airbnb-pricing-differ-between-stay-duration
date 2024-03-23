# How does Airbnb pricing differ between stay duration

## 1. Research Motivation

Airbnb often faces the challenge of optimizing their pricing strategies to maximize revenue while remaining competitive in the market. One common distinction in the industry is between short-term (fewer than 7 nights) and long-term ( minimum stay of 7 nights or more) stay duration. Understanding the nuances of pricing strategies for these two categories can be crucial for businesses to make informed decisions and enhance their overall financial performance. Our study aims to investigate pricing differences between short-term and long-term stay options along with room type and review score in three major global cities: Amsterdam, Tokyo, and London. 

## 2. Research question

Are there any noticeable differences in pricing between short-term (e.g., minimum nights < 7) and long-term (e.g., minimum nights >= 7) rental options in Amsterdam, Tokyo and London? And how does this relationship depend on room type and review score?


## 3. Research Method and Variables

The data used is in the listings.csv.gz files downloaded from the Inside Airbnb website (http://insideairbnb.com/get-the-data), including Amsterdam, Tokyo, and London.For this project, we chose linear regression as an appropriate analysis method for two primary reasons. First, linear regression analysis allows us to predict our listings' prices (dependent variable) based on rental duration, city, room type, review scores (both metric and non-metric independent variables).This is vital since it offers an overview understanding how various factors affect pricing. Second, by applying a linear regression to the data, we can estimate to what extent each factor contributes to the pricing differences. 

#### Variables

| **Variables**                            | **Description**                           |
| ---------------------------------------- |----------------------------------------------------|
| price                                    | Room price in Amsterdam, Tokyo and London is treated as dependent variable
| stay_type_dummy                          | Dummy whether the stay is fewer than 7 nights 
| room_type                                | type of room ("entire home/apt","hotel room","private room,"shared room") |
| review_scores_rating                     | How the review scores given by guests from 0 to 5
| city                                     | Three global popular cities: Amsterdam, Tokyo and London  




## 4. Repository overview

```
├── README.md
├── install_packages.R
├── output 
├── makefile
└── src
    ├── analysis ├──Analysis.R
                 ├──exploration_and_results.Rmd
                 └──makefile
    ├── data-preparation ├──download_datasets.R
                         ├──data-preparation.R
                         ├──data-exploration.R
                         └──makefile
```

## 5. Running instructions

### Software dependencies

For this research, we downloaded the data, cleaned and analyzed the data by using Rstudio. To run each file automatically, we created a makefile to achieve this goal. The instructions are available on [http://tilburgsciencehub.com/](https://tilburgsciencehub.com):

- Make
- R and RStudio: [Click here to see how to install R and RStudio](https://tilburgsciencehub.com/topics/computer-setup/software-installation/rstudio/r/)

Make sure you install the following packages in RStudio before you run the commands. Otherwise, you can load each package using the library() function:

```
install.packages("broom")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("tidyverse")
install.packages("readr")
install.packages("data.table")
install.packages("DescTools")
install.packages("pandoc")
install.packages("tinytex")
tinytex::install_tinytex()
```

### Running the code

You can run the makefile by following these steps:

1. Fork the repository to your own GitHub account
2. Create a local repository where the cloned files will be stored
3. Clone the repository to your local computer by typing this command line:
```
git clone https://github.com/course-dprep/How-does-Airbnb-pricing-differ-between-stay-duration
```
4. Set your working directory to the just cloned folder using cd How-does-Airbnb-pricing-differ-between-stay-duration
5. Then in your command line type:
```
make
```
6. The generated results can be found in the ../output folder


## 6. Interpretation & Conclusions

### Interpretation
To investigate the effect of stay duration on Airbnb prices across Amsterdam, Tokyo, London, considering review scores and room type, The outputs per city can be found below: 
#### Amsterdam
<img width="959" alt="截圖 2024-03-23 下午3 15 49" src="https://github.com/course-dprep/How-does-Airbnb-pricing-differ-between-stay-duration/assets/160841129/1df82ddb-86e9-4197-b000-c5559727dc4a">
Listings in Amsterdam show no significant effect on price between short stay and long stay due to the p-value 0.08>0.05. Since Amsterdam listings reveal a lack of long-stay accommodations within the hotel and shared room categories. Consequently, coefficients for the interaction terms “long-stay”, “hotel room”, and “shared room” are represented as NA. This aligns with the established short-term nature of hotel and shared room listings, which typically lack a 7-day minimum stay requirement.

#### London
<img width="979" alt="截圖 2024-03-23 下午3 18 54" src="https://github.com/course-dprep/How-does-Airbnb-pricing-differ-between-stay-duration/assets/160841129/e6240ef4-1b35-418b-9fd2-9f12c9aed81b">

For London listings, since the p-value 0.0000124 < 0.05 indicates that there is a significant difference in price between the listing with a short_stay vs long_stay in London. The main effect stay_type_dummy on the price suggests that on average a ‘long-stay’ is 56.8 Pounds lower than ‘short-stay’. n contrast to listings located in Amsterdam and Tokyo, hotel and shared room options do long-term stay opportunities. 

#### Tokyo
<img width="965" alt="截圖 2024-03-23 下午3 21 49" src="https://github.com/course-dprep/How-does-Airbnb-pricing-differ-between-stay-duration/assets/160841129/0f9e85cc-32aa-4e34-9054-c8dd917eba43">

The Airbnb listings in Tokyo show a significant difference in price between short_stay and long_stay listings since the p-value 0.00653 < 0.05. Despite the lack of significance in the majority of the terms. The interaction between stay_type_dummy * review_scores_rating is also significant for “long-stay” listings, which a -star-increase in “review_scores_rating” is associated with a 7321 Yen increase in price. However, like Amsterdam, Tokyo hotels listed on the platform primarily offer short-term stays. This lack of long-stay options prevents us from analyzing the interaction between “long-stay” and “hotel room” variables


### Conclusions
The key findings from our analysis are: 
- In Amsterdam and Tokyo short-term stays show higher average prices than in London. Whereas, a long stay in London demonstrates an inverse trend.
- Overall the long-term stays price is below average among Amsterdam, London, and Tokyo.
- Unlike Tokyo and London with notable impact of stay duration on pricing, listings in Amsterdam have shown no significant difference.
- Unlike Amsterdam and Tokyo, London offers long-term stay opportunities in hotel and shared room categories, although their availability is limited.
- Across all three cities, different room types show significant effects on pricing.
- There is a significant interaction between review scores and stay duration in Amsterdam, Tokyo, and London, particularly for long-stay accommodations.

### Additional Visualization
#### Number of Airbnb listings
![airbnb_listings_distribution](https://github.com/course-dprep/How-does-Airbnb-pricing-differ-between-stay-duration/assets/160841129/f3ceb381-cd2c-43aa-98c0-3d496a27995c)
_Figure 1: Bar chart showing the distribution of Airbnb listings across Amsterdam, Tokyo, and London._


#### Distribution of Stay Duration

![stay_category_distribution](https://github.com/course-dprep/How-does-Airbnb-pricing-differ-between-stay-duration/assets/160841129/d93e8d92-0223-47e3-8934-361ac3798db5)
_Figure 2: Bar chart showing the distribution of short-stay and long-stay listings across Amsterdam, Tokyo, and London._


#### Distribution of Room Types

![room_type_distribution](https://github.com/course-dprep/How-does-Airbnb-pricing-differ-between-stay-duration/assets/160841129/a5b868a9-2fa0-4dcd-b43c-e8f21254ad50)
_Figure 3: Bar chart showing the distribution of room types across Amsterdam, Tokyo, and London._






A more detailed analysis of these results can be found in the  ../exploration_and_results.PDF file.



## 7. About

This project is conducted for the Data Preparation and Workflow Management course at Tilburg University. The members of our team are:

- Lieke Geudens 
  l.n.geudens@tilburguniversity.edu
- Lingwei Zhao 
  l.zhao_1@tilburguniversity.edu
- Victoria Hsu 
  c.f.hsu@tilburguniversity.edu

