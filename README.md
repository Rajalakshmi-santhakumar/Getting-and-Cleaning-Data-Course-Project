# Getting-and-Cleaning-Data-Course-Project
This is the course project for the Getting and Cleaning Data Coursera course. 

The important features of the run_analysis.R script are as follows:

1. Loads the activity labels and features
2. Loads the training and test datasets, retaining only those columns which are mean or standard deviation
3. Loads the activity and subject data for each dataset, and merges those columns with the dataset
4. Merges the two datasets
5. Converts the activity and subject columns into factors
6. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The end result is shown in the file tidy.txt and the updated CodeBood.md file describes the variables, the data, and any transformations performed to clean up the data.
