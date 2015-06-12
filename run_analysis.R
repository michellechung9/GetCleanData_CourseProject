# Coursera: Getting and Cleaning Data
# Course Project

################################################################################
# 1. Merge data set
################################################################################

# Load required packages
require(dplyr)

# Download all data files
# Don't save folder on drive as folder is very big
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
tempdir <- tempdir()
temp <- tempfile()
download.file(url, temp, method = "curl")
allFiles <- unzip(temp, list = TRUE)$Name
filesOfInterest <- allFiles[c(1, 2, 16, 17, 18, 30, 31, 32)]

activityLabels <- read.table(unz(temp, filesOfInterest[1]))
variableNames <- read.table(unz(temp, filesOfInterest[2]))
testSubject <- read.table(unz(temp, filesOfInterest[3]))  
test <- read.table(unz(temp, filesOfInterest[4]))  
testLab <- read.table(unz(temp, filesOfInterest[5]))   
trainingSubject <- read.table(unz(temp, filesOfInterest[6]))   
training <- read.table(unz(temp, filesOfInterest[7]))
trainingLab <- read.table(unz(temp, filesOfInterest[8]))   
           
unlink(temp)
unlink(tempdir)

# Combine data sets
training <- cbind(trainingSubject, trainingLab, training)
test <- cbind(testSubject, testLab, test)

# Merge the two data sets
data <- rbind(training, test)

# Rename first two columns "SubjectNo" and "ActivityNo"
colnames(data)[c(1, 2)] <- c("SubjectNo", "ActivityNo")

#Replace column names except for the last two columns which are already named
# i.e. where there is no capital V
colnames(data)[grepl("V", colnames(data))] <- paste(variableNames$V2)


################################################################################
# 2. Extract only the variables containing mean and standard deviation
################################################################################

# Chose to include the variables that contain "mean()", "std()", and "mean" in 
# earlier parts of the name

# Must make the col names valid names so that subsetting by column works later
# Parentheses are replaced with '.'
colnames(data) <- make.names(colnames(data))

# Check which are the duplicated columns and if they do not contain mean or 
# standard deviation, delete those columns
dupMeanSd  <- any(grepl("mean|std", colnames(data)[duplicated(colnames(data))]))

if (! dupMeanSd) dataUniqueCol <- data[, !duplicated(colnames(data))] else
    print("Duplicated columns contain mean or standard deviation")

# Select the the first two columns "SubjectNo" and "ActivityNo" and 
# columns that contain "mean", "std"
selectedData <- select(dataUniqueCol, SubjectNo, ActivityNo, 
                       contains("mean"), contains("std"))

################################################################################
# 3. Rename the activities with descriptive names using merge
################################################################################

# Merge reorders the data, but that is not a problem here because all the data 
# sets are joined
selectedDataActivity <- merge(selectedData, activityLabels,
                        by.x = "ActivityNo", by.y = "V1")
selectedDataActivity <- select(selectedDataActivity, SubjectNo, V2, 
                               everything(), -ActivityNo)

# Rename V2 column Activity
selectedDataActivity <- rename(selectedDataActivity, Activity = V2)

################################################################################
# 4. Rename the variable names with descriptive names
################################################################################

# Store all variable names to be renamed, except the two variables
# "SubjectNo" and "Activity"
varRename <- colnames(selectedDataActivity)[! (colnames(selectedDataActivity) 
                                            == "Activity" | 
                                                colnames(selectedDataActivity) 
                                                == "SubjectNo")]

# Remove duplicate 'Body'
varRename <- gsub("BodyBody", "Body.", varRename)

# Replace prefixes t and f with 'Time' and 'Freq'
# ^ to indicate looking for pattern at beginning
varRename <- gsub("^t", "Time.of.", varRename)
varRename <- gsub("^f", "Freq.of.", varRename)

varRename <- gsub("Body", "Body.", varRename)
varRename <- gsub("Acc", "from.Accelerometer.", varRename)
varRename <- gsub("Gravity", "Gravity.", varRename)
varRename <- gsub("Gyro", "from.Gyrometer", varRename)
varRename <- gsub("angle", "Angle.of", varRename)
varRename <- gsub("tBody", "Time.of.Body", varRename)
varRename <- gsub("Mag", "Magnitude.", varRename)
varRename <- gsub("Jerk", ".Jerk.", varRename)
varRename <- gsub("gravityMean", "Gravity.Mean", varRename)

# Remove duplicate '.'
# \\ escape character, + to remove all instances the pattern appears
varRename <- gsub('\\.\\.+', ".", varRename)

varRename <- gsub("X", "in.X.Direction", varRename)
varRename <- gsub("Y", "in.Y.Direction", varRename)
varRename <- gsub("Z", "in.Z.Direction", varRename)
varRename <- gsub("meanFreq", "Mean.Freq", varRename)
varRename <- gsub("mean", "Mean", varRename)
varRename <- gsub("gravity", "Gravity", varRename)
varRename <- gsub("GyrometerMagnitude", "Gyrometer.Magnitude", varRename)
varRename <- gsub("GyrometerMean", "Gyrometer.Mean", varRename)
varRename <- gsub("of\\.in", "in", varRename)
varRename <- gsub("std", "Standard.Dev", varRename)

# Remove trailing period
varRename <- gsub("\\.$", "", varRename)

colnames(selectedDataActivity)[! (colnames(selectedDataActivity) 
                                  == "Activity" | 
                                      colnames(selectedDataActivity) 
                                  == "SubjectNo")] <- varRename


################################################################################
# 5. Create a second, independent tidy data set with the average of each variable 
# for each activity and each subject
################################################################################

tidyData <- selectedDataActivity
tidyData %>% group_by(SubjectNo, Activity) %>% summarise_each(funs(mean))

# Export tidy data set
write.table(tidyData, "tidydata.txt", row.names = FALSE)
    

