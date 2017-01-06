library(reshape2)
library(dplyr)
library(data.table)

# Load activity labels and features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract the data on Mean and Standard Deviation
featuresExtracted <- grep(".*mean.*|.*std.*", features[,2])
featuresExtracted.names <- features[featuresExtracted,2]
featuresExtracted.names = gsub('-mean', 'Mean', featuresExtracted.names)
featuresExtracted.names = gsub('-std', 'Std', featuresExtracted.names)
featuresExtracted.names <- gsub('[-()]', '', featuresExtracted.names)


# Load the training dataset
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresExtracted]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

# Load the test dataset
test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresExtracted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Merge the two datasets and add labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", featuresExtracted.names)

# Turn activities & subjects into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)


