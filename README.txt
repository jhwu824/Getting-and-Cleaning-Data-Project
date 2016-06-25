==================================================================
Getting and Cleaning Data Project
Author: Jeff Wu
==================================================================


The analysis code included in this repo, run_analysis.R, runs on R version 3.2.3, Windows 10. When sourced from R, it downloads Human Activity Recognition data from the UCI machine learning repository, merges the training and test sets into one dataset, extracts mean and standard deviation measurements. Column names are derived from the labels in features.txt, and mean/standard deviation columns are found by matching these names with a '-mean\\()|-std\\()' regex pattern. Activity descriptions are added as a column by merging the dataset to a lookup dataframe (activity_labels.txt) that matches each activity_id to a description. The resulting dataframe for parts 1-4 of this assignment is stored as df_activitymerge, while df_means is the dataset averaging each variable for each activity and subject (step 5).