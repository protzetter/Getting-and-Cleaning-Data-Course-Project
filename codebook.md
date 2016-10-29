Code Book

This code book describes the code inside run_analysis.R script

1. Dowload data to local
The following files need to be downloaded to current directory and extracted:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The train data is expected under train directory
The test data is expected under test directory

2.Loading data

a. Reads test and train data
b. Reads features and renames column names in test and train data
c. Merges test and train data into xFull and yFull

3. Merging and cleaning up data

a. Extract columns for mean and std values and store into xMeanStd
c. Merge the data set with activity codes
d. Merge the data set with subject codes

5. Compute avergae of mean and std by activity and subject into averageStd and averageMean
6. write the resulting data sets into a file


