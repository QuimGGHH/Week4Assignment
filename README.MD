The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project.You will be required to submit:

a tidy data set as described below
a link to a Github repository with your script for performing the analysis
codeBook.md that describes the variables, the data, and any work that you performed to clean up the data
README.md that explains how all of the scripts work and how they are connected.
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set.
Appropriately labels the data set with descriptive activity names.
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

------------------------------------------------------------------

The code proposed to acomplish all instructions is the next:

#Read features
features <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/features.txt",sep=" ",header = FALSE)[2]
colnames(features)<-c("Features")

activitiesLbl <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt",sep=" ",header = FALSE)
colnames(activitiesLbl)<-c("Id","Activities")

#For test and train data values
dtTest <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
colnames(dtTest)<-1:561
dtTrain <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
AllDataset <- rbind(dtTest,dtTrain)
rm(dtTest)
rm(dtTrain)

#For test and train Activities
dtActTest <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt", sep = "", header = FALSE)
colnames(dtActTest)<-c("ActivitiesId")
dtActTrain <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt", sep = "", header = FALSE)
AllActivitiesId <- rbind(dtActTest, dtActTrain)
rm(dtActTest)
rm(dtActTrain)

#For Subjects
testSubject <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)
colnames(testSubject)<-c("subjectId")
trainSubject <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)
dtSubjects <- rbind(testSubject, trainSubject)
rm(testSubject)
rm(trainSubject)

#Assigns real column attributes(decriptive column names) that is kept in features vector to AllDataset we have formed in previous steps. After that, select all columns that key values passing through this attributes
names(AllDataset) <- features[ ,1]
#Select Std and Mean
AllDatasetStdMean <- AllDataset[ grepl("std|mean", names(AllDataset), ignore.case = TRUE)]  

#Calculate the dataframe of Activities and labels
AllActivitiesId <- merge(AllActivitiesId, activitiesLbl, by.x = "ActivitiesId", by.y = "Id")[2]

#Calculate the final tydi dataset binding three performed dataframes of Subjects, Activities and calculations values.
AllDatasetStdMean <- cbind(dtSubjects, AllActivitiesId, AllDatasetStdMean)
