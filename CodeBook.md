# Abstract
The objective of this code book is to provide the ways data is extracted, cleaned and transformed to meet the overall objective of getting
average of experiments conducted for "Human Activity Recognition Using Smartphones Dataset" by each activity and by subject. The output is
a dataset with 180 observations (30 subject * 6 activities).

# Libraries 

Below libraries are used in preparing this script.
1. plyr
2. reshape2

# Functions

1. Merges the training (X_train.txt, y_train.txt) and the test sets(X_Test.txt,y_test.txt) to create one data set with the features and activities extracted
from features.txt and activity_labels.txt files. The merging at column level is done using cbind() and row is done through rbind() function
2. Extracts only the measurements on the mean and standard deviation for each measurement from the combined dataset using the grepl() function
3. Uses descriptive activity names to name the activities in the data set using colnames() function
4. Appropriately labels the data set with descriptive variable names and and set appropriate and cleaner names using grep() function
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject using melt() and dcast() functions

# Variables 

1. features - extracts the information from features.txt
2. X_train, Y_train, Subject_Train, X_Test, Y_Test, Subject_Test contains data from the downloaded files of training, test and subject data
3. Train_data and Test_data are used to combine at column level between the Train/Test and Subject data
4. Combined_data is used to merge the Train_data and Test_data to a single dataset
5. id_cols and data_cols variables are used to separate the Subject/Activity combination from the rest of the variables
6. melted_data holds the output of the melt function applied on the Combined_data dataset
7. Second_tidy_data variable is used to store the mean output from the dcast function on the melted_data
