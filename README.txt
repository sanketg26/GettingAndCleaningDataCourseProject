Peer-graded Assignment: Getting and Cleaning Data Course Project

This repository has the instructions on how to run analysis on Human Activity recognition dataset.

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the datasets for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Files included:
1] Codebook.md a code book that describes the variables, the data, and any transformations or work performed to clean/manipulate data

2] run_analysis.R performs the data cleaning following the 5 steps required as described in the course project’s definition:
        
	1] Merges the training and the test sets to create one data set.
        2] Extracts only the measurements on the mean and standard deviation for each measurement.
        3] Uses descriptive activity names to name the activities in the data set
        4] Appropriately labels the data set with descriptive variable names.
        5] From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

3] submission_dataset.txt is the exported final data after going through all the sequences described above.

4] UCI HAR Dataset is the data used for the analysis