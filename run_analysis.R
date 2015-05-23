library(data.table)

#datFolder <- "dat"
datFolder <- "UCI HAR Dataset"
#datFolder <- "."

"%.%" <- function(a, b) {paste(a, b, sep="")} # used on filenames in read.table

### Preparation for Naming Cols and Rows
# All names with capital M in "Mean" are angle measurements, not means
features <- gsub("\\()|-|Mean", "", read.table(datFolder%.%"/features.txt")[,2])
features <- tolower( features )
   # the measurement names, cleaned                        (char vector)

colsOfInterest <- grep("mean|std", features)
   # indices of the measurements that we care about        (int vector)

#2345678901234567890123456789012345678901234567890123456789012345678901234567890
#        1         2         3         4         5         6         7         |
filename <- datFolder %.% "/activity_labels.txt"
actLabels <- sub( "_", "", tolower(as.character( read.table(filename)[,2] )) )
   # activity names in numerical order                     (char vector)

### Manipulation of Test Data
# Read the data for the measurements that we care about
filename <- datFolder %.% "/test/X_test.txt"
testDF <- read.table(filename, colClasses="numeric")[,colsOfInterest]

# Put subject numbers in what will become the second column
testDF <- cbind( read.table(datFolder %.% "/test/subject_test.txt"), testDF )

# Put the activity names in the first column
testAct <- as.integer( read.table(datFolder %.% "/test/Y_test.txt")[,1] )
testDF <- cbind(actLab = actLabels[testAct], testDF)

### Manipulation of Training Data
# Read the data for the measurements that we care about
filename <- datFolder %.% "/train/X_train.txt"
trainDF <- read.table(filename, colClasses="numeric")[,colsOfInterest]

# Put subject numbers in what will become the second column
trainDF <- cbind( read.table(datFolder%.%"/train/subject_train.txt"), trainDF )

# Put the activity names in the first column
trainAct <- as.integer( read.table(datFolder %.% "/train/Y_train.txt")[,1] )
trainDF <- cbind(actLab=actLabels[trainAct], trainDF)

### Merge the data sets and label the columns
XDF <- rbind(testDF, trainDF)
   # the merged, semi-raw, mean and std measurements       (data table)
names(XDF) <- c("activity", "subject", features[colsOfInterest])
tvec = interaction(XDF[2:1])                         # used as index in tapply
vtapply <- function(...) {as.vector( tapply(...) )}  # function for lapply
activity <- factor(tapply( XDF[,1], tvec, unique ), labels= levels( XDF[,1] ))
tidySet <- data.frame( activity, lapply(XDF[2:ncol(XDF)], vtapply, tvec, mean) )
rownames(tidySet) <- NULL

#niceSet <-lapply(XDF[3:ncol(XDF)], tapply, list(XDF$subject,XDF$activity), mean)
   # mean of each measurement by subject and activity      (list of matrices)

### Clean the Workspace
# Leave only XDF, niceSet and tidySet
rm(features, colsOfInterest, actLabels, testDF, testAct, trainDF, trainAct,
      activity, tvec, vtapply)

write.table(tidySet, file = "TidyHumanActivity.txt", row.names=FALSE)