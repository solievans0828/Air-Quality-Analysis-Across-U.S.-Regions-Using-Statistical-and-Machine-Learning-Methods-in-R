# Air-Quality-Analysis-Across-U.S.-Regions-Using-Statistical-and-Machine-Learning-Methods-in-R
Author: Soli Evans
Course: Practical Statistics & Programming Using R
Dataset: EPA Daily AQI by CBSA (2024)
Source: https://www.epa.gov/outdoor-air-quality-data/download-daily-data

Project Overview

This project analyzes the U.S. Environmental Protection Agency (EPA) 2024 Daily Air Quality Index (AQI) dataset to examine regional and seasonal air quality patterns across the United States. Using descriptive statistics, inferential statistical tests, and machine learning models in R, the project evaluates variations in AQI and develops predictive models to classify AQI health categories.

The full analysis, results, and code are documented in the final report. 

HI 2021 Final Report (2)

Research Aims
Aim 1:

Assess whether mean AQI differs across U.S. regions using:

One-way ANOVA

Two-way ANOVA (Region × Month)

Aim 2:

Build predictive models to classify AQI category ("Good", "Moderate", "Unhealthy") based on:

AQI value

Region

Month

Defining pollutant

Models implemented:

Decision Tree (CART)

Random Forest

Dataset Description

Total Observations: ~171,648 (after cleaning)

Variables include: AQI, Date, Location, Pollutant Type, Reporting Sites

Data Cleaning Steps:

Removed corrupted header row

Parsed fields and reconstructed dataset

Extracted state codes and assigned regions

Collapsed EPA’s 6-category AQI system into 3 classes

Created month indicators

Methods Summary
Statistical Analyses

Descriptive statistics to summarize AQI distribution

Boxplots and time-series line charts for regional and seasonal trends

One-way ANOVA: Tested AQI differences across regions

Two-way ANOVA: Examined the interaction between region and month

Machine Learning Models

Decision Tree: Achieved 100% accuracy due to clean class boundaries

Random Forest: Near-perfect accuracy with top predictors:

AQI

Month

Region

Pollutant type

Key Findings
1. Regional Differences

Statistically significant differences in mean AQI across regions

South and West exhibit higher AQI on average

Northeast and Midwest maintain lower levels

2. Seasonal Trends

AQI peaks during summer months, especially in the West

Extreme outliers in the West primarily linked to wildfire activity

3. Predictive Modeling

Both ML models achieved near-perfect accuracy

EPA’s AQI thresholds create highly separable classification groups

 Repository Structure 
 project-folder
 ┣  README.md
 ┣ HI 2021 Final Report 2.pdf
 ┣ HI 2021 Final Code.R
 ┗  data/
   ┗ daily_aqi_by_cbsa_2024.csv

How to Run the Analysis
1. Install Required R Packages
install.packages(c("caret", "rpart", "rpart.plot", "randomForest", "ggplot2"))

2. Load and Run Code

The full, reproducible R script is located in Appendix A of the report. 

HI 2021 Final Report (2)


To run the analysis:

source("appendix_A_code.R")


This will:

Clean & preprocess the dataset

Generate descriptive statistics & visualizations

Run ANOVA tests

Train/validate decision tree and random forest models

Visual Outputs

Figures included in the report:

AQI Distribution by Region

Average Monthly AQI by Region

AQI Class Distribution (3-level)

Decision Tree Model Visualization

Descriptions & images appear in Appendix C of the final report. 

HI 2021 Final Report (2)

Limitations

Extreme outliers due to wildfire events

Meteorological data not included

Collapsing AQI categories may reduce nuance

Future Directions

Integrate meteorological variables (temperature, humidity, wind patterns)

Build spatiotemporal models

Deploy predictive dashboards for public health monitoring

References

A full reference list is available in the final report. 

HI 2021 Final Report (2)


Key sources include peer-reviewed research on air pollution, AQI definitions, and EPA documentation.

Citation

If referencing this project in academic work:

Evans, S. (2024). Air Quality Analysis Across U.S. Regions Using Statistical and Machine Learning Methods in R. Practical Statistics & Programming Using R. EPA Daily AQI Dataset.
