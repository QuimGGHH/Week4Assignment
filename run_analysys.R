# run_Analysis.R
#

{features <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/features.txt",sep=" ",header = FALSE)[2];
colnames(features)<-c("Features");

activitiesLbl <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt",sep=" ",header = FALSE);
colnames(activitiesLbl)<-c("Id","Activities");


dtTest <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE);
colnames(dtTest)<-1:561;
dtTrain <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE);
colnames(dtTrain)<-1:561;
AllDataset <- rbind(dtTest,dtTrain);
rm(dtTest);
rm(dtTrain);

dtActTest <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt", sep = "", header = FALSE);
colnames(dtActTest)<-c("ActivitiesId");
dtActTrain <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt", sep = "", header = FALSE);
colnames(dtActTrain)<-c("ActivitiesId");
AllActivitiesId <- rbind(dtActTest, dtActTrain);
rm(dtActTest);
rm(dtActTrain);

testSubject <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE);
colnames(testSubject)<-c("subjectId");
trainSubject <- read.csv("../UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE);
colnames(trainSubject)<-c("subjectId");
dtSubjects <- rbind(testSubject, trainSubject);
rm(testSubject);
rm(trainSubject);

names(AllDataset) <- features[ ,1];
AllDatasetStdMean <- AllDataset[ grepl("std|mean", names(AllDataset), ignore.case = TRUE)];

AllActivitiesId <- merge(AllActivitiesId, activitiesLbl, by.x = "ActivitiesId", by.y = "Id")[2];
AllDatasetStdMean <- cbind(dtSubjects, AllActivitiesId, AllDatasetStdMean)}
