# Load libraries
library(tidyverse)
library(reshape2)


# Download and save file from web
if(!file.exists("SamsungDataset.zip")) {
      download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "SamsungDataset.zip")
}

if(!file.exists("UCI HAR Dataset")) {
      unzip("SamsungDataset.zip")
}

setwd("./UCI HAR Dataset")

# Load and format activity labels
activities <- read.table("activity_labels.txt")
activities$V2 <- gsub("_", " ", activities$V2) %>% tolower()

# Extract measures of mean and standard deviation from features document
features <- read.table("features.txt", stringsAsFactors = F)
extracted.features <- filter(features, grepl("mean|std", V2)) %>% select(V2)
extracted.features$V2 <- gsub("\"", "", extracted.features$V2)
extracted.features$V2 <- gsub("-mean", "Mean", extracted.features$V2)
extracted.features$V2 <- gsub("-std", "StDev", extracted.features$V2)
extracted.features$V2 <- gsub("[()]", "", extracted.features$V2)


# Read data into memory
test.subject <- read.table("test/subject_test.txt")
test.data <- read.table("test/X_test.txt")[grepl("mean|std", features$V2)]
names(test.data) <- t(extracted.features)
test.labels <- read.table("test/y_test.txt")

train.subject <- read.table("train/subject_train.txt")
train.data <- read.table("train/X_train.txt")[grepl("mean|std", features$V2)]
names(train.data) <- t(extracted.features)
train.labels <- read.table("train/y_train.txt")

# Make activity labels human-readable 
test.labels <- left_join(test.labels, activities, by="V1")
train.labels <- left_join(train.labels, activities, by="V1")

# Bind data into columns and then compile one complete dataset
test.set <- cbind(id=test.subject$V1, test.data, label=test.labels$V2)
train.set <- cbind(id=train.subject$V1, train.data, label=train.labels$V2)
full.data <- rbind(test.set, train.set)


# Melt data into tidy format
melted.data <- melt(full.data, id.vars=c("id", "label"))
melted.data <- rename(melted.data, subject=id, activity=label, measure=variable)

# Create tidy data set with average for each variable for each activity and each subject
final.data <- dcast(melted.data, measure~subject+activity, mean)

write.table(final.data, file="data.txt", row.names=F)

