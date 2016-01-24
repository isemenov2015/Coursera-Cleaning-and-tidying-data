#Script for course project on JHU/Coursera Getting and cleaning data
#Downloads zip archive from a given location, loads it into R, makes some tidying
#Needs 'downloader' package from CRAN to be installed
#Needs 'dplyr' package from CRAN to be installed

getsets <- function(furl = '') {
# downloads .zip file from location specified in furl,
# unzips data and removes downloaded archive from disk
    library(downloader)
    zipfile <- 'dfile.zip'
    download(fileurl, dest = zipfile, mode = 'wb')
    unzip(zipfile)
    unlink(zipfile)
}

fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

#debug Uncomment function call before submitting
#getsets(fileurl)
#end debug

#read all datasets into data frames
setwd('UCI HAR Dataset')
actlabels_df <- read.table('activity_labels.txt', stringsAsFactors = FALSE)
features_df <- read.table('features.txt', stringsAsFactors = FALSE)
subj_train_df <- read.table('./train/subject_train.txt')
labels_train_df <- read.table('./train/y_train.txt')
set_train_df <- read.table('./train/x_train.txt')
subj_test_df <- read.table('./test/subject_test.txt')
labels_test_df <- read.table('./test/y_test.txt')
set_test_df <- read.table('./test/x_test.txt')
setwd('../')

#concatenate trains and test datasets together and remove unnecessary separate test and train
#sets from memory afterwards
res_set_df <- rbind(set_test_df, set_train_df)
rm(set_test_df)
rm(set_train_df)
res_subj_df <- rbind(subj_test_df, subj_train_df)
rm(subj_test_df)
rm(subj_train_df)
res_labels_df <- rbind(labels_test_df, labels_train_df)
rm(labels_test_df)
rm(labels_train_df)

#replace dummy names in a main dataset with full names from features 
names(res_set_df) <- features_df[, 2]
rm(features_df)

#throw away all columns that does not contain mean() or std() from main dataset
res_set_df <- res_set_df[, grep('mean\\(|std\\(', names(res_set_df))]

#replace activity labels with activity names in activity labels dataset
library(dplyr)
res_labels_df <- left_join(res_labels_df, actlabels_df, by = 'V1')
res_labels_df <- res_labels_df[, -c(1)]
rm(actlabels_df)

#insert column with activities names into the main dataset
res_set_df <- cbind(res_labels_df, res_set_df)
names(res_set_df)[1] <- 'activities'
rm(res_labels_df)

#insert column with person id into the main dataset
res_set_df <- cbind(res_subj_df, res_set_df)
names(res_set_df)[1] <- 'personid'
rm(res_subj_df)

#make new dataset with mean values for each personid and activities
mean_set <- group_by(res_set_df, personid, activities) %>% summarise_each(funs(mean))

#process column names in order to meet tidy dataset requirements (lowercase letters and numbers only)
names(mean_set) <- tolower(gsub('\\(\\)|-', '', names(mean_set)))

#write dataset on a disc
write.table(mean_set, file = 'tidyset.txt', row.names = FALSE)