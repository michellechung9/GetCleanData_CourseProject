---
title: "Code Book for UCI HAR Tidy Dataset"
author: "Michelle Chung"
date: "June 10, 2015"
output: html_document
---

## Overview
This data set is a tidy version of the UC Irvine Human Activity Recognition 
Using Smartphones Data Set (UCI HAR).  The original data set can be found at 
the following link: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The data set contains data collected from the accelerometers from the Samsung 
Galaxy S smartphone for 30 volunteers. Each person performed six activities: 
walking, walking upstairs, walking downstairs, sitting, standing, and laying.

## Explanation of Data
Each row of the data set is the data from one person performing one activity. 
The data is the average of each recorded variable for that person performing 
that activity.

The first column "SubjectNo" is the identifier of the subject who carried out 
the experiment.

The second column "Activity" is the description of the type of activity the 
subject carried out.

The remaining columns are the recorded variables. The table below decodes the 
phrases found in the column names.


Phrase in Column Name   | Explanation
------------------------|-------------------------------------------------------
Mean                    | Average of the measurement
Standard.Dev            | Standard deviation of the measurement
from.Accelerometer      | Measured by accelerometer
from.Gyrometer          | Measured by gyrometer
Body                    | Body motion component of acceleration signal
Gravity                 | Gravity component of acceleration signal
Time.of                 | Calculated variable from the time domain
Freq.of                 | Calculated variable from the frequency domain
Angle                   | Angle between two vectors
Jerk                    | Jerk signal obtained from the derivation of the body linear acceleration and angular velocity in time
Magnitude               | Magnitude of three-dimensional signal
in.X.Direction          | Component of 3-axial signal in the X direction
in.Y.Direction          | Component of 3-axial signal in the Y direction
in.Z.Direction          | Component of 3-axial signal in the Z direction

