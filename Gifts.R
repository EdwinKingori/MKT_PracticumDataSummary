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

#first converting to the desired data formats
gifts_df <- gifts_df %>%
  mutate(GiftDate = as.Date(GiftDate, format = "%Y-%m-%d"))

gifts_cleaned <- gifts_df %>%
  mutate(
    across(where(is.character), ~if_else( . == "NULL", str_c("user", AccountID, "mising", sep = "_"), .))
  )

head(gifts_cleaned)

#Visualizations

#ensuring the 'Amountid' is treated as a unique_factor
gifts_cleaned$AccountID <- as.factor(gifts_cleaned$AccountID)

#visualizing a bar plot for all members
barplot(amounts,
        main = "The gifts amount received by all members",
        xlab = "AccountID",
        ylab = "Amount",
        col = c('skyblue'),
        las = 2, 
        cex.names = 0.8) 


#visualizing the amount offered, distinguishing between  members and  non_members
gifts_cleaned$Member <- ifelse(gifts_cleaned$Member == "Y", "Member", "Non-member" )

ggplot(gifts_cleaned, aes(x = AccountID, y = Amount, fill = Member ))+
  geom_bar(stat = 'identity', position = 'stack')+
  scale_fill_manual(values = c("Member" = "green", "Non-member" = "red"))+
  labs(title = "The gifts amount received by members and non-members",
     x = "AccountID",
     y = "Amount") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))










