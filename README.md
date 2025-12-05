# Air-Quality-Analysis-Across-U.S.-Regions-Using-Statistical-and-Machine-Learning-Methods-in-R

**Author:** Soli Evans
**Course:** Practical Statistics & Programming Using R
**Dataset:** EPA Daily AQI by CBSA (2024)
**Source:** [https://www.epa.gov/outdoor-air-quality-data/download-daily-data](https://www.epa.gov/outdoor-air-quality-data/download-daily-data)

---

## Project Overview

This project analyzes the U.S. Environmental Protection Agency’s (EPA) 2024 Daily Air Quality Index (AQI) dataset to evaluate regional and seasonal differences in air quality across the United States. Using descriptive statistics, inferential statistical testing, and supervised machine learning models in R, the project identifies patterns in AQI and builds predictive classifiers for AQI health categories.

All analysis, results, and figures are documented in the final report. 

---

## Research Aims

### Aim 1

Determine whether mean AQI differs across U.S. regions using

* One-way ANOVA
* Two-way ANOVA (Region × Month)

### Aim 2

Develop predictive classification models for AQI categories ("Good", "Moderate", "Unhealthy") using:

* AQI
* Region
* Month
* Defining pollutant

Models implemented:

* Decision Tree (CART)
* Random Forest

---

## Dataset Description

* Total Observations: approximately 171,648 after preprocessing
* Variables include: AQI, date fields, pollutant type, CBSA information, reporting site counts
* Data cleaning steps:

  * Removal of corrupted header row
  * Parsing of CBSA fields and extraction of state identifiers
  * Assignment of states to Census regions
  * Creation of month indicators
  * Collapsing of EPA’s six AQI categories into three

---

## Methods Summary

### Statistical Methods

* Descriptive statistics to summarize AQI distribution
* Boxplots and line charts to visualize regional and seasonal trends
* One-way ANOVA to test regional AQI differences
* Two-way ANOVA to test Region × Month interaction effects

### Machine Learning Methods

* Decision Tree model with 5-fold cross-validation
* Random Forest model with variable importance evaluation
* Train-test split: 80/20

---

## Key Findings

### Regional Differences

* Significant differences in mean AQI across regions
* South and West regions demonstrate the highest AQI values on average
* Midwest and Northeast tend to have lower AQI levels

### Seasonal Trends

* AQI peaks during summer months nationwide
* Western region shows the sharpest seasonal spikes, influenced by wildfire activity

### Model Performance

* Decision Tree achieved 100% classification accuracy
* Random Forest achieved near-perfect accuracy
* Most important predictors: AQI value, month, region, pollutant type

---

## Repository Structure

```
project-folder
┣ README.md
┣ HI 2021 Final Report 2.pdf
┣ HI 2021 Final Code.R
┗ data/
  ┗ daily_aqi_by_cbsa_2024.csv
```

---

## How to Run the Analysis

### 1. Install Required R Packages

```r
install.packages(c("caret", "rpart", "rpart.plot", "randomForest", "ggplot2"))
```

### 2. Run the Code

All code used in this analysis is contained in **HI 2021 Final Code.R**.

Example execution:

```r
source("HI 2021 Final Code.R")
```

This script will:

* Clean and preprocess the dataset
* Generate descriptive statistics and visualizations
* Conduct ANOVA tests
* Train and evaluate machine learning models

---

## Visual Outputs

Figures included in the report:

* AQI Distribution by Region
* Average Monthly AQI by Region
* AQI Class Distribution (3-level)
* Decision Tree Classification Model

Descriptions and images are located in Appendix C of the final report. 

---

## Limitations

* Extreme AQI outliers resulting from wildfire events
* Meteorological variables not included
* Collapsing AQI categories may obscure some nuance

---

## Future Directions

* Incorporate meteorological data (temperature, humidity, wind speed)
* Build spatiotemporal forecasting models
* Deploy an interactive dashboard for real-time AQI monitoring

---

## References

Full APA-formatted references appear in the final report. 
