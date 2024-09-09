# loading library packages
library(readxl)
library(dplyr)
library(tidyverse)
library(janitor)
library(skimr)
library(ggplot2)

#importing dataset
promotions_df <- read_xlsx("Promotions.xlsx")

head(promotions_df)

#inspecting data
str(promotions_df)
summary(promotions_df)

#Data Cleaning

