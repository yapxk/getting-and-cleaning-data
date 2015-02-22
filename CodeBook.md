##Getting and Cleaning Data : Code Book

Data source    : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Description    : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

###Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

###Implementation :

The run_analysis.R script executes the following to clean up the data:

1.It merges the training and test sets to create a data set, namely train/X_train.txt with test/X_test.txt, the result of which is a data frame which contain as stated in the original description with an Instances of 10299 and the number of attributes is 561.

Next is the train/subject_train.txt with test/subject_test.txt, a 10299x1 data frame with subject IDs, and train/y_train.txt with test/y_test.txt, a 10299x1 data frame with activity IDs.

2.It reads the features.txt and extracts the measurements on the mean and standard deviation for each measurement. The result is a 10299x66 data frame, because only 66 out of 561 attributes are measurements on the mean and standard deviation. All measurements appear to be floating point numbers in the range (-1, 1).

It reads activity_labels.txt and applies descriptive activity names to name the activities in the data set:

#####[walking] , [walkingupstairs] , [walkingdownstairs] , [sitting] , [standing] , [laying]

The script labels the data set with descriptive names accordingly with all feature names (attributes) and activity names are converted to lower case, underscores and brackets () are removed. Then it merges the 10299x66 data frame containing features with 10299x1 data frames containing activity labels and subject IDs. The result is saved as merged_clean_data.txt, a 10299x68 data frame such that the first column contains subject IDs, the second column activity names, and the last 66 columns are measurements. Subject IDs are integers between 1 and 30 inclusive. 

The attributes names are similar to the following:
#####[tbodyacc-mean-x],[tbodyacc-mean-y],[tbodyacc-mean-z],[tbodyacc-std-x],
#####[tbodyacc-std-y],[tbodyacc-std-z],[tgravityacc-mean-x],[tgravityacc-mean-y]


The script creates an independent tidy data set namely "data_set_with_the_averages.txt", result with an average of each measurement for each activity and each subject. 

The first column contains subject IDs, the second column contains activity names , third coloumn are the averages for each of the 66 attributes. There are 30 subjects, 6 activities and 180 rows in this data set with averages.
