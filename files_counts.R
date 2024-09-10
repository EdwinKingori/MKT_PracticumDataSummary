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

#2 stacked bar_plot

 
  
  