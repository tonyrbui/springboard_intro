library(tibble)
library(dplyr)
library(tidyr)
library(readr)

options(dplyr.width = Inf)

# Loading into tibble from CSV for tiny data format
tc_df <-
  as_tibble(read.csv(file = "03_02_titanic/titanic_original.csv", header = TRUE, sep = ","))

# Replacing blank embarked values with S
tc_df$embarked <- gsub("^$", "S", tc_df$embarked)

# Calculating mean of age column to replace with bank age values
# Could have used median or mean
# Use the statistic that you do not want altered after the replace
age_mean <- mean(tc_df$age, na.rm = TRUE)
tc_df <- tc_df %>%
  replace_na(replace = list(age = age_mean))

# Replacing blank boat values with NA
tc_df$boat <- gsub("^$", NA, tc_df$boat)

# Does not make sense to fill in missing cabin number
# Some passengers did not stay in a cabin
# Creating has_cabin_number dummy variable
tc_df <- tc_df %>%
  mutate(has_cabin_number = ifelse(cabin == "", 0, 1))

# Creating titanic_clean.csv
write_csv(x = tc_df, path = "03_02_titanic/titanic_clean.csv")