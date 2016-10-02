# This script will perform the following steps on the UCI HAR Dataset downloaded FROM A WEBSITE

# 1. Merge the training and the test sets to create one data set.

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# 3. Use descriptive activity names to name the activities in the data set

# 4. Appropriately label the data set with descriptive activity names. 

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# we will Download the file and we will put the file in the data folder

if(!file.exists("./data"))
{
  dir.create("./data")
}
# let's get the link and put it in fileurl
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

#next we need to unzip the  
unzip(zipfile="./data/Dataset.zip",exdir="./data")
path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)

#  step  1

#  let's read the dataactivity test and train and put it in dataactivityTest and Data activity train
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

#  next let s read the suject Trainf and subject test files

dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)

#next let s read the features and put in deture test and feature train
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)


#  use head or str

str(dataActivityTrain)
str(dataSubjectTrain)
str(dataFeaturesTest)
str(dataSubjectTest)

#  let's merge the two data set together by using the function rbind
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)
   
### Step 2
# now let put the names and variable together
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

# now let combine the columns to get the data frame  using column combin function
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)


#  now let's extract the mean and STD

subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

# step 3
# let's subset the names

selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

#  finally we need to check the structure of the data

str(Data)

# let s read activity names from activity abels file
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
                             
                             
head(Data$activity,30)



#Step 4
# Acc -> Accelerometer                             
# prefix f ->frequency
# t will be replaced by time
#Mag -> Magnitude
# BodyBody -> Body
# Gyro ->Gyroscope




# let s change it now
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data)) 
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
 
# let's look at it to see if they have changed.

names(Data)

#step 5

#  next let s Create a second,independent tidy data set and then we ouput it
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# we will use the plyr package in this 
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
# Produce Codebook
library(knitr)
knit2html("codebook.Rmd");

