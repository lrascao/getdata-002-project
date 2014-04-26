##
## 	* Merges the training and the test sets to create one data set.
##	* Extracts only the measurements on the mean and standard deviation for each measurement. 
##	* Uses descriptive activity names to name the activities in the data set
##	* Appropriately labels the data set with descriptive activity names. 
##	* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#

## replaces activity ids with the corresponding activity labels obtained from activity_labels.txt
##
## Args:
##	y: data frame with all activity ids
##	activities: vector containing activity names
##
## Returns:
##	data frame containing activity names
set_activity_labels <- function(y, activities) {

	lapply(y, function(x) {replace(x, TRUE, as.character(activities[x]))})
}

## builds the first tidy dataset required
## 	1. merges the two datasets, training and test, for both X, y, and subject list
##	2. adds a activity column factor
##	3. builds a feature subset vector containing only the column names containing mean, Mean and std
##	4, build a dataset filtered by the feature subset
##	5. returns both the filtered and unfiltered datasets
##
## args:
##		X_train_dataset
##		X_test_dataset
##		y_train_dataset
##		y_test_dataset
##		subjects_train
##		subjects_test
##		activity_labels - factor containing activity labels (WALKING, etc)
##
first_dataset <- function(X_train_dataset, X_test_dataset, 
				      y_train_dataset, y_test_dataset,
				      subjects_train, subjects_test,
				      activity_labels) {

	# Merges the training and the test sets to create one data set.
	# Extracts only the measurements on the mean and standard deviation for each measurement. 
	# Uses descriptive activity names to name the activities in the data set
	# Appropriately labels the data set with descriptive activity names.
	#
	
	# merge the data files into a single one
	dataset <- rbind(X_train_dataset, X_test_dataset)
	y <- rbind(y_train_dataset, y_test_dataset)

	# replace all the activity ids with their corresponding names
	y_activity_labels <- set_activity_labels(y, activity_labels$activity)

	# create a vector that represents the subset of features that we are interested in
	# in this case it's only the mean and std
	features_subset <- grep("mean|Mean|std", names(dataset))

	# now add an activity column that contains the corresponding activity for each row
	dataset <- cbind(y_activity_labels, dataset)

	# merge the two subject files
	subject <- rbind(subjects_train, subjects_test)$subject_id
	
	# add the subjects to the data table
	dataset <- cbind(subject, dataset)

	# now filter out the remaining features
	filtered_dataset <- dataset[features_subset]
	
	# return both the filtered and unfiltered datasets
	list("data" = dataset, "filtered_data" = filtered_dataset)
}

## builds the second tidy dataset required
##
## args:
##	dataset1 - unfiltered dataset obtained from the first part of the assignment
##
second_dataset <- function(dataset1) {

	# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	aggregate(. ~ activity + subject, dataset1, mean)
}

# read the features file
features <- read.table("data/features.txt", col.names = c("id", "feature"), stringsAsFactors = FALSE)

# read the activity_labels file
activity_labels <- read.table("data/activity_labels.txt", col.names = c("id", "activity"), stringsAsFactors = FALSE)

# read the subjects data file
subjects_train <- read.table("data/train/subject_train.txt", col.names = c("subject_id"))
subjects_test <- read.table("data/test/subject_test.txt", col.names = c("subject_id"))

# read the train dataset activities
X_train_dataset <- read.table("data/train/X_train.txt", col.names = features$feature)
y_train_dataset <- read.table("data/train/y_train.txt", col.names = c("activity"))

# and now the test dataset, read both the activities and data files
X_test_dataset <- read.table("data/test/X_test.txt", col.names = features$feature)
y_test_dataset <- read.table("data/test/y_test.txt", col.names = c("activity"))

# build the first tidy data set of the assignment
datasets <- first_dataset(X_train_dataset, X_test_dataset, y_train_dataset, y_test_dataset, subjects_train, subjects_test, activity_labels)
dataset1 <- datasets$filtered_data

# build the tidy dataset for the second part of the assignment
dataset2 <- second_dataset(datasets$data)
