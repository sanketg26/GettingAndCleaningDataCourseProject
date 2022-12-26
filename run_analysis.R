# set your own WD
# dir <- gsub("\\\\", "/", r"(\Data Science Specialization\Getting and Cleaning Data)")
setwd(dir)

if(!file.exists("data")){
    dir.create("data")
}
setwd("./data")

# DOWNLOAD THE FILE
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "dataset.zip")
unzip("dataset.zip")

setwd("./UCI HAR Dataset")

library(data.table)

# load features.txt
features <- fread("features.txt")
# str(features)
colnames(features) <- c("index_no","feature_names")


# load the train dataset
x_train <- fread("./train/X_train.txt")
# str(xtrain)
colnames(x_train) <- features$feature_names

y_train <- fread("./train/y_train.txt")
# str(y_train)
colnames(y_train) <- "labels"

subject_train <- fread("./train/subject_train.txt")
# str(subject_train)
colnames(subject_train) <- "subject_id"


# load the test dataset
x_test <- fread("./test/X_test.txt")
# str(xtest)
colnames(x_test) <- features$feature_names

y_test <- fread("./test/y_test.txt")
# str(y_test)
colnames(y_test) <- "labels"

subject_test <- fread("./test/subject_test.txt")
# str(subject_test)
colnames(subject_test) <- "subject_id"

# Merge training and testing datasets
x <- rbind(x_train,x_test)
y <- rbind(y_train,y_test)
subject <- rbind(subject_train, subject_test)
merged_dataset <- as.data.table(cbind(x,y,subject))

library(dplyr)
# Extract mean and standard deviation of each measurement
tidy_dataset <- merged_dataset %>% select(subject_id, labels, matches("[Mm]ean|[Ss]td"))

# Descriptive activity names
activities <- fread("./activity_labels.txt")
# str(activities)
colnames(activities) <- c("label", "activity_label")
tidy_dataset$labels <- activities[tidy_dataset$labels, "activity_label"]

# Renaming columns
names(tidy_dataset)<-gsub("-mean()", "Mean", names(tidy_dataset), ignore.case = TRUE)
names(tidy_dataset)<-gsub("-std()", "STD", names(tidy_dataset), ignore.case = TRUE)
names(tidy_dataset)<-gsub("^t", "Time", names(tidy_dataset))
names(tidy_dataset)<-gsub("^f", "Frequency", names(tidy_dataset))
names(tidy_dataset)<-gsub("-freq()", "Frequency", names(tidy_dataset), ignore.case = TRUE)
names(tidy_dataset)<-gsub("Acc", "Accelerometer", names(tidy_dataset))
names(tidy_dataset)<-gsub("Gyro", "Gyroscope", names(tidy_dataset))
names(tidy_dataset)<-gsub("BodyBody", "Body", names(tidy_dataset))
names(tidy_dataset)<-gsub("Mag", "Magnitude", names(tidy_dataset))
names(tidy_dataset)<-gsub("tBody", "TimeBody", names(tidy_dataset))
names(tidy_dataset)<-gsub("angle", "Angle", names(tidy_dataset))
names(tidy_dataset)<-gsub("gravity", "Gravity", names(tidy_dataset))
# View(tidy_dataset)

# Mean of all grouped by subject id and activity
tidy_dataset2 <- tidy_dataset %>% group_by(subject_id, activity) %>% summarise_all(mean)
# View(tidy_dataset2)
str(tidy_dataset2)
tidy_dataset2

setwd("..")
write.table(tidy_dataset, "submission_dataset.txt", row.names = FALSE)
