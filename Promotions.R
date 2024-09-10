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
#converting the date column to the desired datatype
promotions_df <- promotions_df %>%
  mutate(MailDate = as.Date(MailDate, format = "%Y-%m-%d"))
  
promotions_cleaned <- promotions_df %>%
  mutate(across(where(is.character), ~ if_else(. == "NULL", str_c("user", AccountID, "missing", sep = "_"), .)))

head(promotions_cleaned)

#Visualizations
#Visualizing the different channels used by members

#ensuring the accountId is treated as a factor
promotions_cleaned$AccountID <- as.factor(promotions_cleaned$AccountID)

#Visualizing the channells used by distinguished members

promotions_cleaned$Member <- ifelse(promotions_cleaned$Member == "Y", 'Member', "Non_member")

ggplot(promotions_cleaned, aes(x = AccountID, y = Channel, fill = Member))+
  geom_bar(stat = "identity", position = "stack")+
  scale_fill_manual(values = c(Member = "green", Non_member = "red"))+
  labs(title = "Channels used by Members and Non_members",
       x="AccountId", y="channels")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
  
