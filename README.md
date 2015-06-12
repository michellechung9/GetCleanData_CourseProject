---
title: "README"
author: "Michelle Chung"
date: "June 10, 2015"
output: html_document
---

## Overview
The R script run_analysis.R takes the UC Irvine Human Activity Recognition 
Using Smartphones Data Set (UCI HAR) and cleans it to produce a tidy data set 
saved to the file tidydata.txt. 

The original data set can be found at 
the following link: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The data set contains data collected from the accelerometers from the Samsung 
Galaxy S smartphone for 30 volunteers. Each person performed six activities: 
walking, walking upstairs, walking downstairs, sitting, standing, and laying.


## Explanation of Data
Each row of the tidy data set is the data from one person performing one activity. 
The data is the average of each recorded variable for that person performing 
that activity.

The first column "SubjectNo" is the identifier of the subject who carried out 
the experiment.

The second column "Activity" is the description of the type of activity the 
subject carried out.

The remaining columns are the recorded variables. Please refer to the CodeBook 
for more information. 

## Data Cleaning Procedure
The following steps were taken to clean the data. 

### Merge data set
There are eight text files that contain data and were merged into one data set. 
The eight files are described in the table below.

File Name | Description
----------|------------
activity_labels | Translates activity numbers into descriptive activity labels
features | Column names of the data set
X_test       | Test data set
subject_test | Subject numbers of the observations in the test data set  
y_test       | Activity numbers of the observations in the test data set 
X_train      | Training data set     
subject_train | Subject numbers of the observations in the training data set  
y_train | Activity numbers of the observations in the training data set 

First, the subject numbers and activity numbers were merged into the test and 
training data sets. Then, the test and training data sets were merged together. 


### Extract only the measurements on the mean and standard deviation
The variables that contain "mean()", "std()", and "mean" in earlier parts of 
the name were extracted. 

### Use descriptive activity names to name the activities in the data set
The activity numbers were translated into descriptive activity labels: 
WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING.

### Label the data set with descriptive variable names
The variable names were renamed to descriptive names. Please refer to the 
CodeBook for a table explaining the phrases in the descriptive variable names.

### Create an independent tidy data set with the average of each variable for each activity and each subject
The data set was summarized such that each row is the average of the 
observations for one subject conducting one activity.
