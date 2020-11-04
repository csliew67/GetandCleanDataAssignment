
#download the dataset into a folder

if(!file.exists("./assignmentdata")){dir.create("./assignmentdata")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./assignmentdata/Dataset.zip",method="curl")

#unzip the data zip file
unzip(zipfile="./assignmentdata/Dataset.zip",exdir="./assignmentdata")

#get the list of the files
path_ref <- file.path("./assignmentdata" , "UCI HAR Dataset")
files<-list.files(path_ref, recursive=TRUE)
files

#read training data and test data
ActivityTest  <- read.table(file.path(path_ref, "test" , "Y_test.txt" ),header = FALSE)
ActivityTrain <- read.table(file.path(path_ref, "train", "Y_train.txt"),header = FALSE)
SubjectTrain <- read.table(file.path(path_ref, "train", "subject_train.txt"),header = FALSE)
SubjectTest  <- read.table(file.path(path_ref, "test" , "subject_test.txt"),header = FALSE)
FeaturesTest  <- read.table(file.path(path_ref, "test" , "X_test.txt" ),header = FALSE)
FeaturesTrain <- read.table(file.path(path_ref, "train", "X_train.txt"),header = FALSE)

#merge train and test data
Subject <- rbind(SubjectTrain, SubjectTest)
Activity<- rbind(ActivityTrain, ActivityTest)
Features<- rbind(FeaturesTrain, FeaturesTest)

#load the info of feature and activity
names(Subject)<-c("subject")
names(Activity)<- c("activity")
FeaturesNames <- read.table(file.path(path_ref, "features.txt"),head=FALSE)
names(Features)<- FeaturesNames$V2
dataCombine <- cbind(Subject, Activity)
Data <- cbind(Features, dataCombine)

#extract mean and standard deviation
subdataFeaturesNames<-FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

#use descriptive activity name to name activity
activityLabels <- read.table(file.path(path_ref, "activity_labels.txt"),header = FALSE)
activityLabels[,2] <- as.character(activityLabels[,2])
Data$activity <- sapply(Data$activity, factor, levels = c(1, 2, 3, 4, 5, 6), labels = c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting", "Standing", "Laying"))



#generate tidydata
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)



