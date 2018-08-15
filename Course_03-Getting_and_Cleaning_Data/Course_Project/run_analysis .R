# ------------------------------------------------------------------------------
#
# run_analysis.R
#
# ------------------------------------------------------------------------------
# Step 1 - Set variables and load packages
# ------------------------------------------------------------------------------
library(plyr)
library(dplyr)
# Save working directory
currentPath <- getwd()
# Save url file to be downloaded
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# Save zip data file name
zipDataFile <- "ZipDataFile.zip"
# Save zip file working directory
workingDirectory <- "UCI HAR Dataset"
# Save folder and file names
trainDir <- "train"
testDir <- "test"
featureFile <- "features.txt"
featureCols <- c("featureID", "featureDescr")
activityFile <- "activity_labels.txt"
activityCols <- c("activityID", "activityDescr" )

subjectTestFile <- "subject_test.txt"
activityTestFile <- "y_test.txt"
measureTestFile <- "X_test.txt"

subjectTrainFile <- "subject_train.txt"
activityTrainFile <- "y_train.txt"
measureTrainFile <- "X_train.txt"

subjectCols <- "subjectID"

# ------------------------------------------------------------------------------
# Step 2 - Download and unzip file
# ------------------------------------------------------------------------------
# Delete zip file and directories if exist
if (file.exists(zipDataFile))
		{file.remove(zipDataFile)
		unlink(workingDirectory, recursive = TRUE)}
# Download file with the specified name and unzip it
download.file(fileUrl,file.path(currentPath, "ZipDataFile.zip"), method="curl")
unzip(zipfile = "ZipDataFile.zip")

# ------------------------------------------------------------------------------
# Step 3 - Read files to be analyzed 
# ------------------------------------------------------------------------------
# Read activity_labels with column naming
activityLabels <- read.table(file.path(currentPath, workingDirectory, 
		activityFile), col.names =  activityCols)

# Read features
features <- read.table(file.path(currentPath, workingDirectory, featureFile),
		col.names =  featureCols, as.is = TRUE)

# Read subject - test. Column naming
subjectTest <- read.table(file.path(currentPath, workingDirectory, testDir, 
		subjectTestFile), col.names =  subjectCols)

# Read activity - test. Column naming
activityTest <- read.table(file.path(currentPath, workingDirectory, testDir, 
		activityTestFile), col.names =  activityCols[1])

# Read measures - test
measureTest <- read.table(file.path(currentPath, workingDirectory, testDir, 
		measureTestFile))

# Read subject - train. Column naming
subjectTrain <- read.table(file.path(currentPath, workingDirectory, trainDir, 
		subjectTrainFile), col.names =  subjectCols)

# Read activity - train. Column naming
activityTrain <- read.table(file.path(currentPath, workingDirectory, trainDir, 
		activityTrainFile), col.names =  activityCols[1])

# Read measures - train
measureTrain <- read.table(file.path(currentPath, workingDirectory, trainDir, 
		measureTrainFile))

# ------------------------------------------------------------------------------
# Step 4 - Merge test and training data (by row)
# ------------------------------------------------------------------------------
subject <- rbind(subjectTest, subjectTrain)
activity <- rbind(activityTest, activityTrain)
measure <- rbind(measureTest, measureTrain)


# ------------------------------------------------------------------------------
# Step 5 - Consider only the required columns
#		   Create one data set
# 		   Delete temp dataframes
# ------------------------------------------------------------------------------
# Find the integer vector that identifies the required columns
# Only columns with "mean()" o "std()" have been considered
# Columns with the word "Mean" in the name (i.e. gravityMean) have been discarded
requiredFeatures <- grep("-(mean|std)\\(\\)", features[, 2])
# Create dataframe with only required columns
measure <- measure[, requiredFeatures]
# Set descriptive column names
names(measure) <- features[requiredFeatures, 2]
# Create a unique data set
activityRequired <- cbind(subject, activity, measure)
# Delete temp dataframes
rm(subjectTest, activityTest, measureTest, subjectTrain, activityTrain, measureTrain)

# ------------------------------------------------------------------------------
# Step 6 - Use activity description instead of activity ID
# ------------------------------------------------------------------------------
# Override activityID of activityRequired with activityDescr
activityRequired$activityID <- factor(activityRequired$activityID, 
		levels = activityLabels[, 1], labels = activityLabels[, 2])
# Correct columns name (now description and no longer and ID)
names(activityRequired)[2] <- names(activityLabels)[2]

# ------------------------------------------------------------------------------
# Step 7 - Label data set with descriptive variables names
# ------------------------------------------------------------------------------
# Retrieve colums names 
activityRequiredLabels <- names(activityRequired)
# Clean activity
activityRequiredLabels <- gsub("[\\(\\)-]", "", activityRequiredLabels)
activityRequiredLabels <- gsub("BodyBody", "Body", activityRequiredLabels)
# Improve description. Use underscore to identify math operations
activityRequiredLabels <- gsub("mean", "_Mean_", activityRequiredLabels)
activityRequiredLabels <- gsub("std", "_StdDev_", activityRequiredLabels)
activityRequiredLabels <- gsub("_$", "", activityRequiredLabels)
activityRequiredLabels <- gsub("^t", "time", activityRequiredLabels)
activityRequiredLabels <- gsub("^f", "frequency", activityRequiredLabels)
activityRequiredLabels <- gsub("Acc", "Accelerometer", activityRequiredLabels)
activityRequiredLabels <- gsub("Gyro", "Gyroscope", activityRequiredLabels)
activityRequiredLabels <- gsub("Mag", "Magnitude", activityRequiredLabels)
# Set new column names
names(activityRequired) <- activityRequiredLabels

# ------------------------------------------------------------------------------
# Step 8 - Create tidy data set with the average of each variable for each 
# activity and each subject
# ------------------------------------------------------------------------------
# Group by subjectID, activityDescr
activityRequiredGroup <- group_by(activityRequired, subjectID, activityDescr)
# Compute mean for each column
tidyDataSet <- summarize_all(activityRequiredGroup, funs(mean))
# Write tidy file
write.table(tidyDataSet, "tidyDataSet.txt", row.names = FALSE,
		col.names = TRUE, quote = FALSE)

