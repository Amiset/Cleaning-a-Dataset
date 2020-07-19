#########################################################
#Written by - Amit
################################################################################
# Loads required libraries
################################################################################
# Version: dplyr 1.0.0
library(dplyr)

# 1. Get Data

# 1a.Download the raw dataset file in the data folder. Check to see if the 'data' folder exists

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/RawDataset.zip")
#mac users can add appropriate arg of method = 'curl'

# 1b.Unzip the file

unzip(zipfile="./data/RawDataset.zip",exdir="./data")

# 1c. Unzipping creates the folder 'UCI HAR Dataset'. 
# 1d. List of files is stored in variable 'files'.

path_ref <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_ref, recursive=TRUE)

#2.Read data from  files into variables

#2a.Read Activity files

ActivityTest  <- read.table(file.path(path_ref, "test" , "Y_test.txt" ),header = FALSE)
ActivityTrain <- read.table(file.path(path_ref, "train", "Y_train.txt"),header = FALSE)

#2b.Read Subject files

SubjectTrain <- read.table(file.path(path_ref, "train", "subject_train.txt"),header = FALSE)
SubjectTest  <- read.table(file.path(path_ref, "test" , "subject_test.txt"),header = FALSE)

#2c. Read Features files

FeaturesTest  <- read.table(file.path(path_ref, "test" , "X_test.txt" ),header = FALSE)
FeaturesTrain <- read.table(file.path(path_ref, "train", "X_train.txt"),header = FALSE)

#3. It's helpful at this stage to view the properties of the variables created in step 2.

#3a. This gives us an idea of the kind of data that is being dealt with herein.
#3b. The function str(variablename) can be used to see the coloumns

#4. Merge the training and test sets to create a single new dataset

#4a.Concatenating data tables by rows

dataSubject <- rbind(SubjectTrain, SubjectTest)
dataActivity<- rbind(ActivityTrain, ActivityTest)
dataFeatures<- rbind(FeaturesTrain, FeaturesTest)

#4b.Set names for variables of tables created in step 4a.

names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")

#5. Reading the Features table

#5a. Reading 'features.txt'
FeaturesNames <- read.table(file.path(path_ref, "features.txt"),head=FALSE)

#5b. Set names for variable V2 of 'FeaturesNames' table
names(dataFeatures)<- FeaturesNames$V2

#6. Merge columns to get data frame Data from all tables

#6a. Coloumn binding the date from subject & activity

dataCombined <- cbind(dataSubject, dataActivity)

#6b. Coloumn binding the data from subject, activity & features

MainData <- cbind(dataFeatures, dataCombined)

#7. Extracts the measurements on mean and standard deviation for each observation

#7a. Subset Name of Features which have measurements on the mean and standard deviation 

subsetFeaturesNames<-FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]

#7b. Subset data frame Data by selected Features names

selectedNames<-c(as.character(subsetFeaturesNames), "subject", "activity")
MainData<-subset(MainData,select=selectedNames)

#8. Good practice herein to check the structures of the data frame 'MainData'
str(MainData)

#9. Name the activities in the data set Using descriptive activity names by reading 'activity_labesl.txt'

#9a.Reading the descriptive activity names from “activity_labels.txt”

activityLabels <- read.table(file.path(path_ref, "activity_labels.txt"),header = FALSE)

#9b. Factorizing the Variable 'activity' in the 'MainData' Data frame using descriptive activity names
MainData$activity<-factor(Data$activity,labels=activityLabels[,2])

#9c. Good practice to check
head(MainData$activity,50)

#10. Labeling the dataset with descriptive variable names

# 10a. Herein, names of Features will labelled using descriptive variable names.
# prefix t is replaced by time
# Acc is replaced by Accelerometer
# Gyro is replaced by Gyroscope
# prefix f is replaced by frequency
# Mag is replaced by Magnitude
# BodyBody is replaced by Body

names(MainData)<-gsub("^t", "time", names(MainData))
names(MainData)<-gsub("^f", "frequency", names(MainData))
names(MainData)<-gsub("Acc", "Accelerometer", names(MainData))
names(MainData)<-gsub("Gyro", "Gyroscope", names(MainData))
names(MainData)<-gsub("Mag", "Magnitude", names(MainData))
names(MainData)<-gsub("BodyBody", "Body", names(MainData))

#10b. Good practice to check
names(MainData)

#11.  Creating a second, tidy data set
#The tidy data set will having the average of each variable for each activity and each subject

#11a. Grouping and summarizing the 'MainData', using 'dplyr'

MainData2<- MainData %>% group_by(subject, activity) %>% summarise_each(funs(mean))
MainData2<-MainData2[order(MainData2$subject,MainData2$activity),]

#11b.  Writing the tidy dataset, 'tiny_data_summary.txt'
write.table(MainData2, file = "tidy_data_summary.txt",row.name=FALSE)
