###############################################################################
# FINAL PROJECT ANALYSIS — PRACTICAL STATISTICS & PROGRAMMING USING R
# Dataset: EPA Daily AQI by CBSA (2024)
# Author: Soli Evans
# Workflow: Base R + caret + ggplot2
###############################################################################

# -----------------------------
# 1. LOAD PACKAGES
# -----------------------------
library(caret)
library(rpart)
library(rpart.plot)
library(randomForest)
library(ggplot2)

# -----------------------------
# 2. IMPORT DATA
# -----------------------------

raw <- readLines(file.choose())
raw <- raw[-1]
aqi <- read.csv(text = raw, header = FALSE, stringsAsFactors = FALSE)
names(aqi) <- c("CBSA", "CBSA_Code", "Date","AQI","Category",
                "Defining_Parameter","Site_ID","Num_Reporting_Sites")
aqi$Date <- as.Date(aqi$Date)
aqi$AQI <- as.numeric(aqi$AQI)
aqi$Num_Reporting_Sites <- as.numeric(aqi$Num_Reporting_Sites)
aqi$State <- sub(".*, *", "", aqi$CBSA)
str(aqi)
head(aqi)

# -----------------------------
# 3. DATA CLEANING
# -----------------------------

# Convert date
aqi$Date <- as.Date(aqi$Date)

# Extract month number and month name
aqi$Month <- as.numeric(format(aqi$Date, "%m"))
aqi$Month_Name <- month.abb[aqi$Month]

# -----------------------------
# 4. REGION CLASSIFICATION
# -----------------------------
Northeast <- c("ME","NH","VT","MA","RI","CT","NY","NJ","PA")
Midwest   <- c("OH","MI","IN","IL","WI","MN","IA","MO","ND","SD","NE","KS")
South     <- c("DE","MD","VA","WV","NC","SC","GA","FL",
               "KY","TN","MS","AL","OK","TX","AR","LA","DC")
West      <- c("WA","OR","CA","NV","ID","MT","WY","UT","CO","AZ","NM","HI","AK")

aqi$Region <- ifelse(aqi$State %in% Northeast, "Northeast",
                     ifelse(aqi$State %in% Midwest, "Midwest",
                            ifelse(aqi$State %in% South, "South",
                                   ifelse(aqi$State %in% West, "West", NA))))

# Remove rows where region is missing
aqi <- subset(aqi, !is.na(Region))

# -----------------------------
# 5. QUALITY CONTROL
# -----------------------------

# Remove missing AQI values
aqi <- subset(aqi, !is.na(AQI))

# Validate categories
valid_categories <- c("Good","Moderate",
                      "Unhealthy for Sensitive Groups",
                      "Unhealthy","Very Unhealthy","Hazardous")

aqi <- subset(aqi, Category %in% valid_categories)

# Collapse categories → 3 classes
aqi$AQI_Class <- ifelse(aqi$Category == "Good", "Good",
                        ifelse(aqi$Category == "Moderate", "Moderate", "Unhealthy"))

aqi$AQI_Class <- factor(aqi$AQI_Class,
                        levels = c("Good","Moderate","Unhealthy"))

# -----------------------------
# 6. DESCRIPTIVE STATISTICS
# -----------------------------
summary(aqi$AQI)

# AQI by region
agg_region <- aggregate(AQI ~ Region, aqi, summary)
print(agg_region)

# AQI by month
agg_month <- aggregate(AQI ~ Month_Name, aqi, summary)
print(agg_month)

# Category frequency
table(aqi$AQI_Class)

# Pollutant frequency
table(aqi$Defining_Parameter)

# -----------------------------
# 7. VISUALIZATIONS
# -----------------------------

# Boxplot: AQI by Region
ggplot(aqi, aes(x = Region, y = AQI, fill = Region)) +
  geom_boxplot() +
  labs(title = "AQI Distribution by Region", y = "AQI")

# Line plot: AQI by Month x Region
avg_month_region <- aggregate(AQI ~ Month + Region, aqi, mean)

ggplot(avg_month_region, aes(x = Month, y = AQI, color = Region)) +
  geom_line(size = 1.1) +
  labs(title = "Average Monthly AQI by Region", x = "Month", y = "AQI")

# AQI category bar chart
ggplot(aqi, aes(x = AQI_Class, fill = AQI_Class)) +
  geom_bar() +
  labs(title = "AQI Categories (3-Class Collapsed)")

# -----------------------------
# 8. INFERENTIAL STATISTICS
# -----------------------------
# One-way ANOVA
anova_region <- aov(AQI ~ Region, data = aqi)
summary(anova_region)

# Tukey HSD
TukeyHSD(anova_region)

# Two-way ANOVA: Region * Month
anova_two <- aov(AQI ~ Region * Month, data = aqi)
summary(anova_two)

# -----------------------------
# 9. MACHINE LEARNING
# -----------------------------
# Subset for ML
ml_data <- aqi[, c("AQI_Class","AQI","Month","Region","State","Defining_Parameter")]

# Convert predictors
ml_data$Region <- factor(ml_data$Region)
ml_data$State <- factor(ml_data$State)
ml_data$Defining_Parameter <- factor(ml_data$Defining_Parameter)

# Train-test split
set.seed(123)
split <- createDataPartition(ml_data$AQI_Class, p = 0.8, list = FALSE)
train <- ml_data[split, ]
test  <- ml_data[-split, ]

# -----------------------------
# MODEL 1: Decision Tree
# -----------------------------
fit_tree <- train(AQI_Class ~ ., data = train,
                  method = "rpart",
                  trControl = trainControl(method = "cv", number = 5))

fit_tree
rpart.plot(fit_tree$finalModel)

pred_tree <- predict(fit_tree, newdata = test)
confusionMatrix(pred_tree, test$AQI_Class)

# -----------------------------
# MODEL 2: Random Forest
# -----------------------------
fit_rf <- train(AQI_Class ~ ., data = train,
                method = "rf",
                trControl = trainControl(method = "cv", number = 5),
                importance = TRUE)

fit_rf

pred_rf <- predict(fit_rf, newdata = test)
confusionMatrix(pred_rf, test$AQI_Class)

# Variable importance
varImp(fit_rf)
plot(varImp(fit_rf))

###############################################################################
# END OF SCRIPT
###############################################################################

