# run_analysis.R

# This script calculates the mean of certain measurements in the UCI Human
# Activity Recognition dataset, grouped by activity and volunteer (subject).
# The selected measurements are the ones identified as the mean, std and
# meanFreq values.

# The parts of the script which correspond to the tasks numbered 1 through 5 in
# the project instruction are identified by --X--, where X is a number.  In
# some cases more than one line or section of code are associated with a task.

# See CodeBook.md for details of the output.

### USER OPTIONS
# Set datFolder to the root location of the dataset.
   #datFolder <- "dat"
   datFolder <- "UCI HAR Dataset"
   #datFolder <- "."

# Set niceSet to T if you want the niceSet output (see CodeBook.md)
   niceSet <- F

library(data.table)

"%.%" <- function(a, b) {paste(a, b, sep="")} # used on filenames in read.table

### PREPARATION FOR NAMING COLUMNS AND ROWS
# All names with capital M in "Mean" are angle measurements, not means
features <- gsub("\\()|-|Mean", "", read.table(datFolder%.%"/features.txt")[,2])
features <- tolower( features )                                      # --4--
   # the measurement names, cleaned                    (char vector)

colsOfInterest <- grep("mean|std", features)                         # --2--
   # indices of the measurements that we care about    (int vector)

filename <- datFolder %.% "/activity_labels.txt"
actLabels <- sub( "_", "", tolower(as.character( read.table(filename)[,2] )) )
   # activity names in numerical order                 (char vector)   --3--

### MANIPULATION OF TEST DATA
# Read the data for the measurements that we care about
filename <- datFolder %.% "/test/X_test.txt"
testDF <- read.table(filename, colClasses="numeric")[,colsOfInterest] # --2--

# Put subject numbers in what will become the second column
testDF <- cbind( read.table(datFolder %.% "/test/subject_test.txt"), testDF )

# Put the activity names in the first column
testAct <- as.integer( read.table(datFolder %.% "/test/Y_test.txt")[,1] )
testDF <- cbind(actLab = actLabels[testAct], testDF)

### MANIPULATION OF TRAINING DATA
# Read the data for the measurements that we care about
filename <- datFolder %.% "/train/X_train.txt"
trainDF <- read.table(filename, colClasses="numeric")[,colsOfInterest] # --2--

# Put subject numbers in what will become the second column
trainDF <- cbind( read.table(datFolder%.%"/train/subject_train.txt"), trainDF )

# Put the activity names in the first column
trainAct <- as.integer( read.table(datFolder %.% "/train/Y_train.txt")[,1] )
trainDF <- cbind(actLab=actLabels[trainAct], trainDF)

### CREATION OF OUTPUT
XDF <- rbind(testDF, trainDF)                                           # --1--
   # the merged mean and std measurements from the input files    (data table)
names(XDF) <- c("activity", "subject", features[colsOfInterest])        # --4--
tvec = interaction(XDF[2:1])        # used as index in tapply             --5--
activity <- factor(tapply( XDF[,1], tvec, unique ), labels= levels( XDF[,1] ))
vtapply <- function(...) {as.vector( tapply(...) )}       # function for lapply
tidySet <- data.frame( activity, lapply(XDF[2:ncol(XDF)], vtapply, tvec, mean) )
rownames(tidySet) <- NULL

if (niceSet) {                    # Can be set to T at the top of the script
   tlist <- list(XDF$subject, XDF$activity)
   niceSet <- lapply(XDF[3:ncol(XDF)], tapply, tlist, mean)
      # mean of each measurement by subject and activity     (list of matrices)
}
write.table(tidySet, file = "TidyHumanActivity.txt", row.names=FALSE)

### CLEANUP
# Leave only XDF, niceSet and tidySet
rm(features, colsOfInterest, actLabels, testDF, testAct, trainDF, trainAct,
      activity, tvec, tlist, vtapply, datFolder, filename, "%.%")