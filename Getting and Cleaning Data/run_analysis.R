run_analysis <- function(){

#load libraries
library(data.table)

#cleanup directory
if(file.exists("FirstTidyDataSet.txt")) { file.remove("FirstTidyDataSet.txt")}
if(file.exists("SecondTidyDataSet.txt")) { file.remove("SecondTidyDataSet.txt")}


#file locations
file_features <- "./Data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt"
file_activities <- "./Data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"
file_train_subject <- "./Data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"
file_train_data <- "./Data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"
file_train_activity <- "./Data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt"
file_test_subject <- "./Data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"
file_test_data <- "./Data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"
file_test_activity <- "./Data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt"

#read files
feature_labels <- read.table(file_features, col.names=c("FeatureId", "Feature"))
activity_labels <- read.table(file_activities, col.names=c("ActivityId", "Activity"))
train_subjects <- read.table(file_train_subject)
train_data <- read.table(file_train_data)
train_activities <- read.table(file_train_activity)
test_subjects <- read.table(file_test_subject)
test_data <-read.table(file_test_data)
test_activities <- read.table(file_test_activity)

#tidy up Dims
activities$Activity <- gsub("_", "", as.character(activities$Activity))

#1.Merges the training and the test sets to create one data set.
subjects <- rbind(test_subjects, train_subjects)
collected_Data <- rbind (test_data, train_data)
activities <- rbind(test_activities, train_activities)


#Label columns from dims
names(subjects) <- "SubjectId"
names(collected_Data) <- feature_labels$Feature
names(activities) <- "ActivityId"

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
required_Features <- grep("-mean\\(\\)|-std\\(\\)", feature_labels$Feature)
required_Data <- collected_Data[, required_Features]

#3.Uses descriptive activity names to name the activities in the data set
activities_merged <- activity_labels[activities[,1],2]

#4.Appropriately labels the data set with descriptive variable names. 
names(required_Data)<-gsub("^t", "Time", names(required_Data))
names(required_Data)<-gsub("^f", "Frequency", names(required_Data))
names(required_Data)<-gsub("Acc", "Accelerometer", names(required_Data))
names(required_Data)<-gsub("Gyro", "Gyroscope", names(required_Data))
names(required_Data)<-gsub("BodyBody", "Body", names(required_Data))
names(required_Data)<-gsub("Mag", "Magnitude", names(required_Data))
names(required_Data)<-gsub("-mean\\(\\)", "Mean", names(required_Data), ignore.case = TRUE)
names(required_Data)<-gsub("-std\\(\\)", "STD", names(required_Data), ignore.case = TRUE)
names(required_Data)<-gsub("-freq\\(\\)", "Frequency", names(required_Data), ignore.case = TRUE)
names(required_Data)<-gsub("angle", "Angle", names(required_Data))
names(required_Data)<-gsub("gravity", "Gravity", names(required_Data))

#Create frist tidy data set
data <- cbind(subjects, activities_merged, required_Data)
names(data) <- gsub("activities_merged", "Activity", names(data))
write.table(data, "FirstTidyDataSet.txt")

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
dataTable <- data.table(data)
avg_SubjectActivity <- aggregate(. ~subjectId + activity, dataDT, mean)
write.table(data, "SecondTidyDataSet.txt" , row.name=FALSE)
}