CleaningDataProject
===================
Course Project for Getting and Cleaning Data


##Contents:
* run_analysis.R -- The script for creating tidy data set
* CodeBook.md -- Describes the variables, data, and transformations
* README.md -- This file

##About the Project Data:
This script operates on the "Human Activity Recognition Using Smartphones Dataset", Version 1.0, downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip on 10-August-2014.

By default, the dataset will extract into a folder titled "UCI HAR Dataset". The structure of the folder is as follows:

    
|   |   |   |
|---------------|----------------|----------------|
| UCI HAR Dataset/   |     |   |
| 	   |   README.txt   |   |
| 	   |   features_info.txt   |   |
| 	   |   features.txt   |   |
| 	   |   activity_labels.txt   |   |
| 	   |   features_info.txt   |   |
| 	   |   train/   |   |
| 	   |      |  X_train.txt |
| 	   |      |  y_train.txt |
| 	   |      |  subject_train.txt |
| 	   |      |  Inertial Signals/ |
| 	   |   test/   |   |
| 	   |      |  X_test.txt |
| 	   |      |  y_test.txt |
| 	   |      |  subject_test.txt |
| 	   |      |  Inertial Signals/ |


The folders named "Inertial Signals/" are not used in this project. Within the "test/" and "train/" folder, the files "subject\_\*.txt" contain a list of test subject ID's. The files "y\_\*.txt" are the ID's of the particular activity measured, e.g. standing, walking, sitting, etc. The files "X\_\*.txt" contain vectors of the data collected, one vector per subject per activity.

##About run_analysis.R:
The script run_analysis.R should be placed in the folder "UCI HAR Dataset". When this script is executed, it will output a file called "avedata.csv" in the same location which contains the tidy dataset.

The steps taken by the script are as follows:

1) Read the "features.txt" file that describes the measurement vector columns. Then separate out the columns that contain the mean and standard deviation of each measurement.

2) Read in the 3 files in "test/" and "train/" folders, which contain the subject, activity, and measurements. Reformat the column names for subject and activity so that the script is easier to read.

3) Merge the train and test data together.

4) Extract the measurements for mean and standard deviation using the column names derived in Step (1).

5) Read the "activity_labels.txt" and substitute the activity ID in each row with the label.

6) Bind the data columns together, beginning with Subject, Activity, and then the mean and std measurements.

7) Make a new dataset that calculates the average of each variable, for each activity and each subject.

8) Simplify the column names in the new dataset. As a result of the aggregation, some columns are called "Group.1" and "Group.2". These are renamed to "Activity" and "Subject". Also, the column names for the measurement variables are reformatted to be easier to read, e.g. "<Measurement>.<Axis> Ave mean()" or "<Measurement>.<Axis> Ave std()" where <Axis> is one of "X", "Y", or "Z" and <Measurement> is a shortened form of the values found in "features.txt".

9) Finally, write out the new dataset as a csv file.
