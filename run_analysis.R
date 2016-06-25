library(dplyr)
# Merge the training and the test sets to create one data set.
path <- 'getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
dataset_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(dataset_url, path, mode = 'wb')
unzip(path)
file.remove(path)
activity_lookup <- read.table('UCI HAR Dataset/activity_labels.txt'
    , header = F, col.names = c('label', 'description'))
test_subject_ids <- read.table('UCI HAR Dataset/test/subject_test.txt'
    , header = F, col.names = c('subject_id'))
test_activity_ids <- read.table('UCI HAR Dataset/test/y_test.txt'
    , header = F, col.names = c('activity_id'))
test_set_columnnames <- read.table('UCI HAR Dataset/features.txt')[[2]]
test_set <- read.table('UCI HAR Dataset/test/X_test.txt'
    , header = F, col.names = test_set_columnnames)
test_df <- cbind(data.frame(dataset = 'test'), test_subject_ids
    , test_activity_ids, test_set)

train_subject_ids <- read.table('UCI HAR Dataset/train/subject_train.txt'
    , header = F, col.names = c('subject_id'))
train_activity_ids <- read.table('UCI HAR Dataset/train/y_train.txt'
    , header = F, col.names = c('activity_id'))
train_set_columnnames <- read.table('UCI HAR Dataset/features.txt')[[2]]
# Appropriately labels the data set with descriptive variable names.
train_set <- read.table('UCI HAR Dataset/train/X_train.txt'
    , header = F, col.names = train_set_columnnames)
train_df <- cbind(data.frame(dataset = 'train'), train_subject_ids
    , train_activity_ids, train_set)

complete_df <- rbind(test_df, train_df)

# Extract only the measurements on the mean and 
# standard deviation for each measurement.
mn_stdv_cols <- complete_df[c(c(1,2,3)
    , (grep('-mean\\()|-std\\()', test_set_columnnames) + 3))]

# Uses descriptive activity names to name the activities in the data set
df_activitymerge <- merge(mn_stdv_cols, activity_lookup
    , by.x = 'activity_id', by.y = 'label', all.x = TRUE)

# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
df_means<- tbl_df(df_activitymerge)[c(1,3:69)] %>% group_by(subject_id, activity_id) %>% 
    summarise_each(funs(mean))



