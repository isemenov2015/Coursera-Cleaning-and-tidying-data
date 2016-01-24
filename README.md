# Coursera-Cleaning-and-tidying-data
## Coursera Cleaning and tidying data course work for course #3 from John Hopkins University data science specialization

Dataset based on an data obtained from experiment with human activity recognition using smartphones.

Full description of experiment can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Raw data for processing were downloaded from the link provided in course work assignment:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Project files description:
*readme.md 	- this file
*CodeBook.md 	- description of result dataset variables
*run_analysis.r 	- R script that was implemented to obtain result tidy dataset
*tidyset.csv	- tidy dataset that is a goal of an assignment


Notes. 
Following packages available from CRAN must be installed in the local R environment in order to run run_analysis.r:
- dplyr
- downloader

run_analysis.r automatically downloads raw data using provided link and creates tidyset.csv in current R working
directory.


Script creates 'UCI HAR Dataset' subdirectory in current R directory with raw data files.

Warning: no checks for available disk space are being made.