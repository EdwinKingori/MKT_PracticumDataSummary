# loading library packages
library(readr)
library(readxl)
library(dplyr)
library(tidyselect)
library(tidyverse)
library(janitor)
library(skimr)
library(ggplot2)

# importing data
donors_df <- read_xlsx("Donors.xlsx")
head(donors_df, 5)

#inspecting data
str(donors_df)
summary(donors_df)

#data cleaning
#replacing the null values in the patient and age columns

donors_clean <- donors_df %>%
  mutate(
    Patient = ifelse(Patient == "NULL", 
                          paste("user", AccountID, sep = "_"),
                     Patient),
    Age = ifelse(Age == "NULL",
                      0,
                      Age)
    )


head(donors_clean)





