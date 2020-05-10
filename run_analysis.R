## Load the dplyr packagea
library(dplyr)

## select all test data and training data

testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")

## get activity labels to associate activity ids with a description

activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Get activity ids for test data
## associate with a description and make lower case (also remove _ symbol)

activityid<- read.table("./UCI HAR Dataset/test/y_test.txt")
activity <- activitylabels$V2[activityid$V1]
activity <- tolower(activity)
activity <- sub("_"," ",activity)

## Get subject ids for test data

subjecttable <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subjectid <- subjecttable$V1

## read in features.txt and identify variables (columns) 
## which contain mean or standard deviation

categories <- read.table("./UCI HAR Dataset/features.txt")
meancolumns <-  grep("mean[^F](.*)", categories$V2)
meancolumnstitles <-  grep("mean[^F](.*)", categories$V2, value = TRUE)
stdcolumns <-  grep("std()", categories$V2)
tablstdcolumnstitles <-  grep("std()", categories$V2, value = TRUE)

## Select means data from test data and name columns based on features

meansdata <- select(testdata, meancolumns)
names(meansdata) <- meancolumnstitles

## Select standard deviation data from test data and name columns based on features
stddata <- select(testdata, stdcolumns)
names(stddata) <- stdcolumnstitles

## Create data frame of test data with subjectid, activity, and all relevant data

test <- data.frame("subjectid" = subjectid, "activity" = activity, meansdata, stddata)

## repeat previous steps for training data 

activityid<- read.table("./UCI HAR Dataset/train/y_train.txt")
activity <- activitylabels$V2[activityid$V1]
activity <- tolower(activity)
activity <- sub("_"," ",activity)
activity <- as.factor(activity)

subjecttable <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subjectid <- subjecttable$V1


meansdata <- select(traindata, meancolumns)
names(meansdata) <- meancolumnstitles
stddata <- select(traindata, stdcolumns)
names(stddata) <- stdcolumnstitles

train <- data.frame("subjectid" = subjectid, "activity" = activity, meansdata, stddata)

## combine test and training data in a single data frame

alldata <- rbind(test,train)

## group data by subjectid and activity

groupedalldata <- group_by(alldata, subjectid, activity)

## create summary containing means of all columns by subjectid and activity

summary <- summarise_all(groupedalldata, mean)

## write summary table to txt file

write.table(summary, "./tidydata.txt", row.names = FALSE)

