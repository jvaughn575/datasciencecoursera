#Readme/Codebook for run_analysis.R script 

***
__Purpose:__ To combine and summarize(calculate the means) data collected from the UCI HAR Dataset.[1]


__Original data url:__ [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip] [1]
***

##__Instructions__
The folder UCI HAR Dataset contained in the above zip file must be in the working directory with the run_analysis.R script. Final result will produce a <u>tidy_data_set</u> table loaded into the current R environment and a tidy_data_set.txt file written to the current working directory.

***

##__Original data description__

###Folders

Inside the zip file is a main folder called: UCI HAR Dataset[1]. This folder contains two more folders named test, and train.

The test and train folders are identicial to each other as far as structure is concerned. The main data collected was split into the test and train categories so they could be processed by the support vector machine. 

Also, in the test and train folders is a folder called Inertial Signals. The inertial signals is the raw unprocessed data from the  Samsung s2 galaxy phone used to collect the data for this data set. For our purposes this folder will go unused.

###Files

A list of the files used by the run_analysis.R script and a brief description of each is provided below. For a more complete description please see the README.txt under the UCI HAR Dataset folder.

####Folder: UCI HAR Dataset

1. activity_labels.txt - A text file containing a key for the six activity labels. This file is used to decode y_train.txt and y_test.txt files.
2. features.txt - This text file contains the header labels for the 561 variables in the original data set.

####Folder: UCI HAR Dataset/train

1. subject_train.txt - A text file containing the human subjects row labels for 7352 observations.
2. X_train.txt - The training data collected originally[1]. It contains 7352 observations of 561 variables.
3. y_train.txt - Contains the numerical code for a activity for each of the 7352 observations.
    

####Folder: UCI HAR Dataset/test

1. subject_test.txt - A text file containing the human subjects row labels for 2947 observations.
2. X_test.txt - The testing data collected originally[1]. It contains 2947 observations of 561 variables.
3. y_test.txt - Contains the numerical code for a activity for each of the 2947 observations.


***
##__Summary of Data Processing__

__Step 1:__ The X_test.txt file is appended to the end of X_train.txt, creating a temporary variable called <u>data</u>, that holds 10299 obervations of 561 variables in a table.

__Step 2:__ Add the headers contained in the features.txt file for the variables in the  <u>data</u> table.

__Step 3:__ Create a logical vector <u>keeps</u> of length 561, where TRUE is reported if the variable name contains "mean()" or "std()", and FALSE if it does not. Use this vector to filter <u>data</u> and store result in <u>filtered_data</u>.

__Step 4:__ Load and combine subject_train.txt and subject_test.txt and store result in <u>subjects</u>. Also, load and combine y_train.txt and y_test.txt and store result in <u>activities</u>

__Step 5:__ Replace the numerical codes for activities in <u>activities</u> with the descriptions contained in the key file activity_labels.txt.

__Step 6:__ Append <u>activities</u> to the front of <u>filitered_data</u> and store result in <u>add_activities</u>. Then, append <u>subjects</u> to the front of <u>add_activities</u> and store result in <u>add_subjects</u>.

__Step 7:__ Use required plyr package ddply function, to find observations in <u>add_subjects</u>, that have the same subject and activities categories, and then find the mean of the selected variables, finally storing the result in <u>tidy_data_set</u>.

__Step 8:__ Remove all temporary variables and leave only the final <u>tidy_data_set</u> loaded. Finally write the <u>tidy_data_set</u> table to a text file.




**Notes: The underlined words are variables used in the run_analysis.R script. The final <u>tidy_data_set</u> contains 180 obs. of 68 variables.



***




## Reference
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

