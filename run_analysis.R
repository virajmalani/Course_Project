filename <- "PA.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
} 
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


# Peer-graded Assignment: Getting and Cleaning Data Course Project

# 1. To merge the training and the test sets to create one data set
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

#2. To extract only the measurements on the mean and standard deviation for each measurement
Extracted_Data <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))


#3. To use descriptive activity names to name the activities in the data set
Extracted_Data$code <- activities[Extracted_Data$code, 2]


#4. To appropriately labels the data set with descriptive variable names
names(Extracted_Data)[1] = "Subject"
names(Extracted_Data)[2] = "Activity"
names(Extracted_Data)<-gsub("Acc", "Accelerometer", names(Extracted_Data))
names(Extracted_Data)<-gsub("Gyro", "Gyroscope", names(Extracted_Data))
names(Extracted_Data)<-gsub("BodyBody", "Body", names(Extracted_Data))
names(Extracted_Data)<-gsub("Mag", "Magnitude", names(Extracted_Data))
names(Extracted_Data)<-gsub("^t", "Time", names(Extracted_Data))
names(Extracted_Data)<-gsub("^f", "Frequency", names(Extracted_Data))
names(Extracted_Data)<-gsub("tBody", "TimeBody", names(Extracted_Data))
names(Extracted_Data)<-gsub("-mean()", "Mean", names(Extracted_Data), ignore.case = TRUE)
names(Extracted_Data)<-gsub("-std()", "STD", names(Extracted_Data), ignore.case = TRUE)
names(Extracted_Data)<-gsub("-freq()", "Frequency", names(Extracted_Data), ignore.case = TRUE)
names(Extracted_Data)<-gsub("angle", "Angle", names(Extracted_Data))
names(Extracted_Data)<-gsub("gravity", "Gravity", names(Extracted_Data))

#5.To create a second, independent tidy data set with the average of each variable for each activity and each subject
Extracted_Data$Subject <- as.factor(Extracted_Data$Subject)
Extracted_Data <- data.table(Extracted_Data)

Tidy_Data <- aggregate(. ~Subject + Activity, Extracted_Data, mean)
Tidy_Data <- Tidy_Data[order(Tidy_Data$Subject,Tidy_Data$Activity),]
write.table(Tidy_Data, file = "TidyData.txt", row.names = FALSE)

