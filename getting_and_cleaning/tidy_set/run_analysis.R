# Class: Coursera's John Hopikins: Getting and Cleaning Data 
# Assignment: Class project - Tidying a dataset


require("plyr")

# Load the two separate datasets, append X_test to the end
# of X_train, and then store the result in the variable "data"
# final result: "data" contains 10299 observations of 561 variables
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
data <- rbind(X_train,X_test)

# Add headers for the 561 variables contained in the features.txt file
header <- read.table("./UCI HAR Dataset/features.txt")$V2
names(data) <- header

# Create a logical vector of size 561 that gives TRUE if a variable name
# contains "mean()" or "std()" in its variable name, if it does not then 
# false is listed
keeps <- grepl("mean()",names(data), fixed = TRUE) | grepl("std()",names(data), fixed = TRUE)

# Copy only the variables that returned TRUE to the "filtered_data" table
filtered_data <- data[,keeps]

# Loads in the two files containing the subjects 1-30 and combines them
# together for the total 10299 observations contained in "subjects" vector
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subjects <- rbind(subject_train,subject_test)

# Loads in the two files containing the activity numerical codes categories 
# and combines them together for the total 10299 observations containe in 
# the "activities" vector
activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
activities <- rbind(activity_train,activity_test)

# Loads in file that contains the key for activity categories
activities_key <- read.table("./UCI HAR Dataset/activity_labels.txt")

# replaces the numercial code for each category with the worded
# desciption contained in the "activities_key" vector
activities$V1[activities$V1 == 1] <- as.character(activities_key[1,2])
activities$V1[activities$V1 == 2] <- as.character(activities_key[2,2])
activities$V1[activities$V1 == 3] <- as.character(activities_key[3,2])
activities$V1[activities$V1 == 4] <- as.character(activities_key[4,2])
activities$V1[activities$V1 == 5] <- as.character(activities_key[5,2])
activities$V1[activities$V1 == 6] <- as.character(activities_key[6,2])

# adds a column header(subject) to the "subjects" vector
names(subjects) <- c("subject")

# adds the "activities" vector to the front of the "filtered_data" table
# and stores the result in "add_activities"
add_activities <- cbind(activities,filtered_data)

# adds the "subjects" vector to the front of "add_activities" table
# and stores the result in "add_subjects"
add_subjects <- cbind(subjects,add_activities)

# changes column header in "add_subjects" for the column 
# containing the activities vector
colnames(add_subjects)[2] <- "act_cat"

# uses the required plyr package to take the mean of observations
# containing the same subject and activity variables
# this condenses the "add_subjects" table from 10299 obs. of 68 variables
# down to 180 obs. of 68 variables
tidy_data_set <- ddply(add_subjects,.(subject,act_cat),numcolwise(mean))

# removes all temporary variables and only keeps the 
# final tidy data set named "tidy_data_set"
rm(list=setdiff(ls(), "tidy_data_set"))

# writes the "tidy_data_set" table to a text file
write.table(tidy_data_set,"./tidy_data_set.txt")