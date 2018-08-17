library(tibble)
library(tidyr)
library(dplyr)
library(readr)

# options(dplyr.width = Inf)
rm(list=ls())

features_df <-
  as_tibble(read_table2("03_03_run_analysis/features.txt", col_names = FALSE))

activity_labels_df <-
  as_tibble(read_table2("03_03_run_analysis/activity_labels.txt", col_names = FALSE))

X_test_df <-
  as_tibble(read_table2("03_03_run_analysis/X_test.txt", col_names = FALSE))

y_test_df <-
  as_tibble(read_table2("03_03_run_analysis/y_test.txt", col_names = FALSE))

subject_test_df <-
  as_tibble(read_table2("03_03_run_analysis/subject_test.txt", col_names = FALSE))

X_train_df <-
  as_tibble(read_table2("03_03_run_analysis/X_train.txt", col_names = FALSE))

y_train_df <-
  as_tibble(read_table2("03_03_run_analysis/y_train.txt", col_names = FALSE))

subject_train_df <-
  as_tibble(read_table2("03_03_run_analysis/subject_train.txt", col_names = FALSE))

X_all_df <- bind_rows(X_test_df, X_train_df)
y_all_df <- bind_rows(y_test_df, y_train_df)
subject_all_df <- bind_rows(subject_test_df, subject_train_df)

colnames(X_all_df) <-
  make.names(unlist(features_df[2], use.names = FALSE),
             unique = TRUE,
             allow_ = TRUE)

activity_all_df <- inner_join(y_all_df, activity_labels_df)

colnames(activity_all_df) <- c("ActivityLabel", "ActivityName")

colnames(subject_all_df) <- c("Subject")

all_df <- bind_cols(subject_all_df, activity_all_df, X_all_df)

View(all_df[1:10, ])
