# loading library packages
library(readxl)
library(dplyr)
library(tidyverse)
library(janitor)
library(skimr)
library(ggplot2)

#importing dataset
gifts_df <- read_xlsx("Gifts.xlsx")

head(gifts_df)

# inspecting data
str(gifts_df)
summary(gifts_df)

#Data Cleaning
#Removing Null values

