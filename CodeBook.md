FilGetting and Cleaning Data - Code Book
==========================================
This assignment focuses in getting raw data and tidying up for readers to understand, explore and perform analysis on the data.

The source data for the project was obtained from collected from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) to complete an assignment for a Coursera course named Getting and Cleaning Data instructed by Jeff Leek. 
Here is the [data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) for the azzignment.

Here are the steps performed to tidy up the data:
- Downloaded the data and extracted the data into <workingdirectory>\Data folder
- Remove any data set created by previous executions of the run_anaklysis function
- Loaded the data into data frames and named columns for Subject and Activity data frames
- Tidy up activity data by removing "_"
- Merge test and train data
- Label the columns for the merged data frames
- Filter out only the Mean and STD columns into a new data frame
- Give descriptive labels for activities
- Give descriptive labels for feature variable names
- Combine, Subject, Activity and Mean/STD data and write to a file "FirstTidyDataSet.txt"
- Calculate average of each variable for each activity and each subject into an independant data frame
- Write the second data set into a file "SecondTidyDataSet.txt"
  
 For implementation details please see the [run_analysis.r] () script.
