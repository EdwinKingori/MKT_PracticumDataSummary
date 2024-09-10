# loading library packages
library(readxl)
library(dplyr)
library(tidyverse)
library(janitor)
library(skimr)
library(ggplot2)
library(tidyr)
library(readr)
library(reshape2)
library(scales)


#importing data_set
files_count_df <- read_xlsx("Files_counts_summary.xlsx")
head(files_count_df)

#inspecting the data_set
str(files_count_df)
summary_data <- summary(files_count_df)

#Converting the summary data into a data_frame
files_count_summary <- as.data.frame(summary_data)

#exporting the summarized data to a csv file
write_csv(files_count_summary, "files_count_summary.csv")
print(files_count_summary)

#Visualizing the data


#reshaping the data to long format for it to display the legend

files_count_long_df <- files_count_df %>%
  pivot_longer(cols = c(Gifts, Promotions, Donors),
               names_to = "Category",
               values_to = "Count")

#1 Comparing the gifts, donor and  promotions across all sectors
ggplot(files_count_long_df, aes(x = Sector,y = Count, fill = Category))+
  geom_bar(stat = "identity", position = "dodge")+
  scale_y_continuous(labels = scales::comma) + 
  scale_fill_manual(values = c("Gifts" = "blue", "Donors" = "red", "Promotions" = "green")) +
  theme_minimal()+
  labs(title = "Comparing the gifts, donor and  promotions across all sectors",
       x = "Sector", y = "Count")+
  theme(axis.text.x = element_text(angle = 90, hjust = 0.1))+ 
  
  coord_flip()

#2 visualizing the Correlation of Gifts, Donors, Promotions and Sustainable Donor Count by Sector using a Stacked bar plot
#transforming the data from a wide data to a long data using the melt function
files_count_df <- melt(files_count_df, id.vars = "Sector", measure.vars = c("Gifts", "Donors", "Promotions", "SustainerDonorCount"))

ggplot(files_count_df, aes(x = Sector, y = value, fill = variable)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Breakdown of Gifts, Donors, Promotions, and Sustainer Donor Count by Sector", x = "Sector", y = "Count")+
  scale_y_continuous(labels = comma)+
  scale_fill_manual(values = c("Gifts" = "blue", "Donors" = "red", "Promotions" = "green", "SustainerDonorCount" = "black"))


#3 Visualizing the  Relationship between Gifts and Donors
ggplot(files_count_df, aes(x = Gifts, y = Donors, color = Sector)) +
  geom_point(size = 4) +
  theme_minimal() +
  labs(title = "Relationship between Gifts and Donors", x = "Gifts", y = "Donors")+
  scale_y_continuous(labels = comma)+
  scale_x_continuous(labels = comma)+
  theme(axis.text.x = element_text(angle =90 , hjust = 0.1))

#4 Visualizing the  Relationship between Gifts and Prmotions
ggplot(files_count_df, aes(x = Gifts, y = Promotions, color = Sector)) +
  geom_point(size = 4) +
  theme_minimal() +
  labs(title = "Relationship between Gifts and Promotions", x = "Gifts", y = "Promotions")+
  scale_y_continuous(labels = comma)+
  scale_x_continuous(labels = comma)+
  theme(axis.text.x = element_text(angle =90 , hjust = 0.1))

#5 Visualizing the  Relationship between  Donors and Promotions
ggplot(files_count_df, aes(x = Donors, y = Promotions, color = Sector)) +
  geom_point(size = 4) +
  theme_minimal() +
  labs(title = "Relationship between Donors and Promotions", x = "Donors", y = "Promotions")+
  scale_y_continuous(labels = comma)+
  scale_x_continuous(labels = comma)+
  theme(axis.text.x = element_text(angle =90 , hjust = 0.1))

# 6. Heatmap: Correlation of matrix
file_matrix <- cor(files_count_df[, c("Gifts", "Donors", "Promotions", "SustainerDonorCount")])
ggplot(melt(file_matrix), aes(Var1, Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0, limit = c(-1, 1), space = "Lab", name="Correlation") +
  theme_minimal() +
  labs(title = "Heatmap of Correlation Matrix", x = "", y = "")

  