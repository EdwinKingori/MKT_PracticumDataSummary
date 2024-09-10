# loading library packages
library(readxl)
library(dplyr)
library(tidyverse)
library(janitor)
library(skimr)
library(ggplot2)
library(tidyr)
library(readr)
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
#1 Comparing the gifts, donor and  promotions across all sectors

ggplot(files_count_df, aes(x = Sector))+
  geom_histogram(aes(y = Gifts), stat = "identity", fill = "blue", position = "dodge")+
  geom_histogram(aes(y = Promotions), stat = "identity", fill = "green", position = "dodge")+
  geom_histogram(aes(y = Donors), stat = "identity", fill = "yellow", position = "dodge")+
  theme_minimal()+
  labs(title = "Comparing the gifts, donor and  promotions across all sectors",
       x = "Sector", y = "Count")+
  coord_flip()
  