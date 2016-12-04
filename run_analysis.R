# The objective of this script is to read the Training and Test data from the UCI dataset. The script
# merges the files together and appends subject and activity details and then calculates the average of all
# mean and standard deviation parameters from the experient and prepares a tidy data set. 

# load the necessary libaries to prepare the script 
library(plyr)
library("reshape2")

features <- read.table("features.txt")

# Read and load the Training data to the R dataset
X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/y_train.txt")
Subject_train <- read.table("./train/subject_train.txt")

# Read and load the Test data to the R dataset
X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/Y_test.txt")
Subject_test <- read.table("./test/subject_test.txt")

# Combine the datasets and subject data 
Train_data <- cbind.data.frame(X_train,Y_train,Subject_train)
Test_data <- cbind.data.frame(X_test,Y_test,Subject_test)

# Merges the training and the test sets to create one data set.
Combined_data <- rbind(Train_data,Test_data)

names(Combined_data) <- features$V2

colnames(Combined_data)[562] = "Activity"
colnames(Combined_data)[563] = "Subject"

# Extracts only the measurements on the mean and standard deviation for each measurement.
Combined_data<- Combined_data[,grepl("mean|std|Activity|Subject",names(Combined_data),ignore.case=TRUE) ]

# Uses descriptive activity names to name the activities in the data set
Combined_data$Activity <- mapvalues(Combined_data$Activity, c(1,2,3,4,5,6), c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))

# Appropriately labels the data set with descriptive variable names.

# Remove Parenthesis
names(Combined_data) <- gsub('\\(|\\)',"",names(Combined_data), perl=TRUE)

#Syntantically valid names
names(Combined_data) <- make.names(names(Combined_data))
names(Combined_data) <- gsub("Acc","Accleration",names(Combined_data),perl=TRUE)
names(Combined_data) <- gsub("Gyro","AngularVelocity",names(Combined_data),perl=TRUE)
names(Combined_data) <- gsub("Mag","Magnitude",names(Combined_data),perl=TRUE)
names(Combined_data) <- gsub("^t","TimeDomain.",names(Combined_data),perl=TRUE)
names(Combined_data) <- gsub("\\.mean","Mean",names(Combined_data),perl=TRUE)
names(Combined_data) <- gsub("\\.std","StandardDeviation",names(Combined_data),perl=TRUE)
names(Combined_data) <- gsub("^f","FrequencyDomain.",names(Combined_data),perl=TRUE)
names(Combined_data) <- gsub('Freq\\.',"Frequency.",names(Combined_data))
names(Combined_data) <- gsub('Freq$',"Frequency",names(Combined_data))


  # creates a second, independent tidy data set with the average of each variable for each activity and each subject.
id_cols = c("Activity","Subject")
data_cols = setdiff(colnames(Combined_data),id_cols)

melted_data <- melt(Combined_data,id = id_cols, measure.vars = data_cols)
second_tidy_data <- dcast(melted_data,Activity+Subject~variable,mean)

# Write the tidy dataset to a CSV file
write.table(second_tidy_data,file ="second_tidy_data",row.names=FALSE)
