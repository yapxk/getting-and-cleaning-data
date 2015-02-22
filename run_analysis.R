# Getting and Cleaning Data - Project


# 1. Merges the training and the test sets to create one data set.

xtrain <- read.table("train/X_train.txt")
xtest <- read.table("test/X_test.txt")
X <- rbind(xtrain, xtest)

subtrain <- read.table("train/subject_train.txt")
subtest <- read.table("test/subject_test.txt")
S <- rbind(subtrain, subtest)

ytrain <- read.table("train/y_train.txt")
ytest <- read.table("test/y_test.txt")
Y <- rbind(ytrain, ytest)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, indices_of_good_features]
names(X) <- features[indices_of_good_features, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S) <- "subject"
cleaned_data <- cbind(S, Y, X)
write.table(cleaned_data, "cleaned_merged_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(S)[,1]
allsubjects = length(unique(S)[,1])
allactivities = length(activities[,1])
numCols = dim(cleaned_data)[2]
result = cleaned_data[1:(allsubjects*allactivities), ]

row = 1
for (s in 1:allsubjects) {
        for (a in 1:allactivities) {
                result[row, 1] = uniqueSubjects[s]
                result[row, 2] = activities[a, 2]
                tmp <- cleaned_data[cleaned_data$subject==s & cleaned_data$activity==activities[a, 2], ]
                result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
                row = row+1
        }
}
write.table(result, "data_set_with_the_averages.txt")