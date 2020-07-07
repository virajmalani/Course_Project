---
title: "CodeBook.md"
author: "You!"
date: "7/7/2020"
output: word_document
---

The run_analysis.R script outlines the steps followed to get and clean the data as instructed in the Peer Graded Assignment: Getting and Cleaning Data Course Project.

1. Downloading the Dataset:
Dataset downloaded and extracted in a folder named UCI HAR Dataset

2. Assigning variables to each data:
a.features <- features.txt : 561 rows, 2 columns
Lists the features selected for this database namely accelerometer and gyroscope signals
b.activities <- activity_labels.txt : 6 rows, 2 columns
Lists all the activities performed with their corresponding measurements and its codes
c.subject_test <- test/subject_test.txt 
Contains test data of the subjects
d.x_test <- test/X_test.txt
Contains test data recorded features
e.y_test <- test/y_test.txt
Contains test data of activities (code)
f.subject_train <- test/subject_train.txt
Contains training data of the subjects
g.x_train <- test/X_train.txt
Contains training data recorded features
h.y_train <- test/y_train.txt
Contains training data of activities (code)

3. Merging the training and the test datasets to one data set:
X is created by merging x_train and x_test using rbind() function
Y is created by merging y_train and y_test using rbind() function
Subject is created by merging subject_train and subject_test using rbind() function
Merged_Data is created by merging Subject, Y and X using cbind() function

4. Extracting only the measurements on the mean and standard deviation for each measurement
Extracted_Data is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

5. Using descriptive activity names to name the activities in the data set:
The code numbers in the code column of the Extracted_Data are replaced with corresponding activity taken from second column of the activities variable

6. Appropriately labelling the data set with descriptive variable names:
The first column in Extracted_Data is renamed to Subject
The second column in Extracted_Data is renamed to Activity
Code column in Extracted_Data are renamed into activities
Acc in column’s name is replaced by Accelerometer
Gyro in column’s name is replaced by Gyroscope
BodyBody in column’s name is replaced by Body
Mag in column’s name is replaced by Magnitude
Any column name starting with character f is replaced by Frequency
Any column name starting with character t is replaced by Time
Rest of the names including mean, std, angle and gravity are replaced by Mean, STD, Angle and Gravity respectively

7. Creating a second, independent tidy data set with the average of each variable for each activity and each subject:
Tidy_Data is created by taking the means of each variable for each activity and each subject from Extracted_Data, after being grouped by subject and activity.
Export Tidy_Data into TidyData.txt file.