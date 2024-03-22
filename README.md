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




## 4. Repository overview (still need to be fixed)

```
├── README.md
├── data
├── gen
│   ├── analysis
│   ├── data-preparation
│   └── paper
└── src
    ├── analysis ├──Analysis.R
                 ├──Interpretation.Rmd
                 └──Interpretation.pdf
    ├── data-preparation ├──Install_packages.R
                         ├──download_datasets.R
                         ├──data-preparation.R
                         └──makefile
    └── xxx
```

## 5. Running instructions

### Software dependencies

For this research, we downloaded the data, cleaned and analyzed the data by using Rstudio. To run each file automatically, we created a makefile to achieve this goal. The instructions are available on [http://tilburgsciencehub.com/](https://tilburgsciencehub.com):

- Make
- R and RStudio: [Click here to see how to install R and RStudio](https://tilburgsciencehub.com/topics/computer-setup/software-installation/rstudio/r/)

Make sure you install the following packages in RStudio before you run the commands. Otherwise, you can load each package using the library() function:

```
library(tidyverse)
library(dplyr)
library(ggplot2)
library(readr)
library(data.table)
library(broom)
library(DescTools)
```

### Running the code

You can run the makefile by following these steps:

1. Fork the repository to your own GitHub account
2. Create a local repository where the cloned files will be stored
3. Clone the repository to your local computer using terminal / command prompt.
```
git clone https://github.com/course-dprep/How-does-Airbnb-pricing-differ-between-stay-duration
```
4. Set your working directory to the just cloned folder using cd How-does-Airbnb-pricing-differ-between-stay-duration
5. Type make
6. In your local folder, the generated output with the regression results can be found:
```
{xxxx}
```

## 6. Interpretation & Conclusions

### Interpretation
To investigate the effect of on Airbnb prices across Amsterdam, Tokyo, London, considering review scores and room type, The outputs per city can be found below: 

#### need to add an overview linear regression graph/table and interpretation to it




A more detailed analysis of these results can be found in the PDF in the src/analysis folder.

### Conclusions
The key findings from our analysis are: 
- In Amsterdam and Tokyo short-term stays show higher average prices than in London. Whereas, a long stay in London demonstrates an inverse trend.
- Overall the long-term stays price is below average among Amsterdam, London, and Tokyo.
- Unlike Tokyo and London with notable impact of stay duration on pricing, listings in Amsterdam have shown no significant difference.
- Unlike Amsterdam and Tokyo, London offers long-term stay opportunities in hotel and shared room categories, although their availability is limited.
- Across all three cities, different room types show significant effects on pricing.
- There is a significant interaction between review scores and stay duration in Amsterdam, Tokyo, and London, particularly for long-stay accommodations.


## 7. About

This project is conducted for the Data Preparation and Workflow Management course at Tilburg University. The members of our team are:

-Lieke Geudens 
  l.n.geudens@tilburguniversity.edu
-Lingwei Zhao 
  l.zhao_1@tilburguniversity.edu
-Victoria Hsu 
  c.f.hsu@tilburguniversity.edu

