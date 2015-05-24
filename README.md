#Getting and Cleaning Data Course Project</p>
###This repo contains the script, run_analysis.R, required for the course project in the Getting and Cleaning Data class offered by the Johns Hopkins University at coursera.org.

When executed in R, via source(), the script loads files from a specific dataset and creates an output file, TidyHumanActivity.txt, showing the averages of certain measurements in the dataset, grouped by two parameters.  It leaves two dataframes in the working environment by default and can leave a third dataframe if the user changes F to T at the niceSet assignment near the top.  These outputs are described in CodeBook.md.

The input dataset may be downloaded from http://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip.  The script only works with that dataset.  By default, the scrpt works when that dataset is unzipped to the R working directory, which creates a folder called 'UCI HAR Dataset'.  That folder may be changed to a different name or path, if the assignment to the variable, datFolder, is updated in the script.
