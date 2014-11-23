#Course Project 3
library(plyr)

#Download & unzip the file
setwd("/Users/lmelnik/Dropbox/Cousera/Getting_and_Cleaning")
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(file_url, "course_project_data.zip", method = "curl")
unzip("course_project_data.zip")
data_dir <- "/Users/lmelnik/Dropbox/Cousera/Getting_and_Cleaning/UCI HAR Dataset"

#Read in each file from the data folder
subject_testdata <- read.table(paste(data_dir, "test/subject_test.txt", sep="/"))
activity_testdata <- read.table(paste(data_dir, "test/y_test.txt", sep="/"))
measurements_testdata <- read.table(paste(data_dir, "test/x_test.txt", sep="/"))

subject_traindata <- read.table(paste(data_dir, "train/subject_train.txt", sep="/"))
activity_traindata <- read.table(paste(data_dir, "train/y_train.txt", sep="/"))
measurements_traindata <- read.table(paste(data_dir, "train/x_train.txt", sep="/"))


#Append test + training datasets together
subject_data <- rbind(subject_testdata, subject_traindata)
colnames(subject_data) <- "subject_id"
activity_data <- rbind(activity_testdata, activity_traindata)
colnames(activity_data) <- "activity_number"
measurements_data <- rbind(measurements_testdata, measurements_traindata)

#Load in the column & activity names, append the column names to the measurement data
column_labels <- read.table(paste(data_dir, "features.txt", sep="/"))
colnames(measurements_data) <- column_labels[,2]

#Pick out the right columns - the ones that contain mean & sd and then bind all data together into one table
mean_std_cols <- grep("-(mean|std)\\(\\)", colnames(measurements_data))
mean_std_data <- measurements_data[,mean_std_cols]
all_data <- cbind(measurements_data, subject_data, activity_data)

#Load in activity names, look at them, change all factors to activity names
activity_labels <- read.table(paste(data_dir, "activity_labels.txt", sep="/"))
activity_labels
all_data$activity_number <- factor(all_data$activity_number, labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

#get the averages for the last step
averages <- ddply(all_data, .(subject_id ,activity_number), function(x) colMeans(x[,1:66]))
write.table(averages, "/Users/lmelnik/Dropbox/Cousera/Getting_and_Cleaning/averages_cleaned_data.txt", row.name=FALSE)
averages





