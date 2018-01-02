library(tidyr)
library(dplyr)

titanic <- read.csv("titanic_original.csv")

# Port of Embarkation: Fill NA values in 'Embarked" with S
titanic$embarked[is.na(titanic$embarked)] <- "S"

#Age: Replaces missing values with average age
titanic <- mutate(titanic, age = if_else(is.na(age), mean(age, na.rm = TRUE), age))

#Lifeboat Replaces those without lifeboats with "None"
titanic <- mutate(titanic, boat = ifelse(is.na(boat), "None", boat))

#Cabin 
titanic <- mutate(titanic, has_cabin_number = ifelse(is.na(cabin), 0, 1))

View(titanic)

write.csv(titanic_original, file = "titanic_clean.csv")