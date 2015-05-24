#Code Book for the output of run_analysis.R

run_analysis.R is a script to calculate mean values of certain measurements in the UCI Human Activity Recognition dataset, grouped by activity and volunteer (subject).  The raw data may be obtained from the UCI Machine Learning Repository at the following URL.
http://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip

A description of how the raw data was generated is at the following URL.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Each measurement in the raw data is a summary or statistical measure from 256 sample times at 50 Hz of one or more inertial sensors.  The measurements selected from the dataset by run_analysis.R are the ones which represent means and standard deviations, including mean frequencies.  The zip file also contains super-raw data consisting of the individual sensor samples.  That data is not used by run_analysis.R.  Thus, the pre-processed summary and statistial measures are considered the "raw" data in this discussion.

The raw data is divided into a training set, collected from 21 volunteers (subjects), and a test set, collected from 9 subjects.  The script combines the data from the two sets and does not distinguish between training data and test data.  The selected measurements are stored in a single dataframe named XDF, which remains in the R workspace after the script is finished.

In the raw data, each measurement time (row of data) is allocated to one the following six activities.
* Walking
* Walking upstairs
* Walking downstairs
* Sitting
* Standing
* Laying

For each permutation of subject and activity, the run_analysis.R script calculates the average of each selected raw measurement and reports it in a tidy dataset stored as a dataframe named tidySet, which remains in the R workspace.  That dataframe is exported to the working directory as a space delimited text file, TidyHumanActivity.txt, with headings.  The rows are not named.  The first two columns can serve as a unique, compound key.

The first column, activity, is a factor with six levels:
1. laying
2. sitting
3. standing
4. walking
5. walkingdownstairs
6. walkingupstairs

The second column, subject, is numeric with integer values 1 through 30.  It identifies the volunteers who served as the subjects, but no identifying information is available other than their numbers.

The remaining columns are all numeric with values between -1 and 1, representing the average of each raw measurement, catagorized by activity and subject.  The headings for the selected measurements are:

tbodyaccmeanx
tbodyaccmeany
tbodyaccmeanz
tbodyaccstdx
tbodyaccstdy
tbodyaccstdz
tgravityaccmeanx
tgravityaccmeany
tgravityaccmeanz
tgravityaccstdx
tgravityaccstdy
tgravityaccstdz
tbodyaccjerkmeanx
tbodyaccjerkmeany
tbodyaccjerkmeanz
tbodyaccjerkstdx
tbodyaccjerkstdy
tbodyaccjerkstdz
tbodygyromeanx
tbodygyromeany
tbodygyromeanz
tbodygyrostdx
tbodygyrostdy
tbodygyrostdz
tbodygyrojerkmeanx
tbodygyrojerkmeany
tbodygyrojerkmeanz
tbodygyrojerkstdx
tbodygyrojerkstdy
tbodygyrojerkstdz
tbodyaccmagmean
tbodyaccmagstd
tgravityaccmagmean
tgravityaccmagstd
tbodyaccjerkmagmean
tbodyaccjerkmagstd
tbodygyromagmean
tbodygyromagstd
tbodygyrojerkmagmean
tbodygyrojerkmagstd
fbodyaccmeanx
fbodyaccmeany
fbodyaccmeanz
fbodyaccstdx
fbodyaccstdy
fbodyaccstdz
fbodyaccmeanfreqx
fbodyaccmeanfreqy
fbodyaccmeanfreqz
fbodyaccjerkmeanx
fbodyaccjerkmeany
fbodyaccjerkmeanz
fbodyaccjerkstdx
fbodyaccjerkstdy
fbodyaccjerkstdz
fbodyaccjerkmeanfreqx
fbodyaccjerkmeanfreqy
fbodyaccjerkmeanfreqz
fbodygyromeanx
fbodygyromeany
fbodygyromeanz
fbodygyrostdx
fbodygyrostdy
fbodygyrostdz
fbodygyromeanfreqx
fbodygyromeanfreqy
fbodygyromeanfreqz
fbodyaccmagmean
fbodyaccmagstd
fbodyaccmagmeanfreq
fbodybodyaccjerkmagmean
fbodybodyaccjerkmagstd
fbodybodyaccjerkmagmeanfreq
fbodybodygyromagmean
fbodybodygyromagstd
fbodybodygyromagmeanfreq
fbodybodygyrojerkmagmean
fbodybodygyrojerkmagstd
fbodybodygyrojerkmagmeanfreq

These correspond to similar names in the raw data.  Individual descriptions are not available, but the following information is extracted from the file, features_info.txt, which accompanies the raw data.

Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

...Variables ... estimated from these signals [include]: 

mean(): Mean value
std(): Standard deviation
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
