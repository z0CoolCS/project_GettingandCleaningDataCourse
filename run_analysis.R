#################################################################
##################### PREPARE ENVIRONMENT #######################
#################################################################
### LOADING LIBS
install.packages("dplyr")

library(dplyr)

### BUILDING FOLDER ARCHITECTURE
if (!dir.exists("backup")) {
  dir.create("backup")
}

################################################################
#################### GETTING THE DATA ##########################
################################################################

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./backup/dataset.zip", method = "curl")
unzip("./backup/dataset.zip")
if (dir.exists("UCI HAR Dataset")) {
  if (dir.exists("data")) {
    print("Data folder already exists")
  } else {
    file.rename(from = "./UCI HAR Dataset/", to = "./data/") # Rename the folder's name
  }
  
}


###############################################################
############### INITIALIZING PATH VARIABLES ###################
###############################################################
## INITIAL PATHS
pathData <- "./data/"
pathActivity <- paste(pathData, "activity_labels.txt", sep = "")
pathFeatures <- paste(pathData, "features.txt", sep = "")

## TEST SET PATHS
pathTest <- paste(pathData, "test/", sep = "")
pathInertialTest <- paste(pathTest, "Inertial Signals/", sep = "")

pathTestX <- paste(pathTest, "X_test.txt", sep = "")
pathTestY <- paste(pathTest, "y_test.txt", sep = "")
pathSubjectTest <- paste(pathTest, "subject_test.txt", sep = "")

pathTestBodyAccX <- paste(pathInertialTest, "body_acc_x_test.txt", sep = "")
pathTestBodyAccY <- paste(pathInertialTest, "body_acc_y_test.txt", sep = "")
pathTestBodyAccZ <- paste(pathInertialTest, "body_acc_z_test.txt", sep = "")

pathTestTotAccX <- paste(pathInertialTest, "total_acc_x_test.txt", sep = "")
pathTestTotAccY <- paste(pathInertialTest, "total_acc_y_test.txt", sep = "")
pathTestTotAccZ <- paste(pathInertialTest, "total_acc_z_test.txt", sep = "")

pathTestBodyGyroX <- paste(pathInertialTest, "body_gyro_x_test.txt", sep = "")
pathTestBodyGyroY <- paste(pathInertialTest, "body_gyro_y_test.txt", sep = "")
pathTestBodyGyroZ <- paste(pathInertialTest, "body_gyro_z_test.txt", sep = "")

## TRAIN SET PATHS
pathTrain <- paste(pathData, "train/", sep = "")
pathInertialTrain <- paste(pathTrain, "Inertial Signals/", sep = "")

pathTrainX <- paste(pathTrain, "X_train.txt", sep = "")
pathTrainY <- paste(pathTrain, "y_train.txt", sep = "")
pathSubjectTrain <- paste(pathTrain, "subject_train.txt", sep = "")

pathTrainBodyAccX <- paste(pathInertialTrain, "body_acc_x_train.txt", sep = "")
pathTrainBodyAccY <- paste(pathInertialTrain, "body_acc_y_train.txt", sep = "")
pathTrainBodyAccZ <- paste(pathInertialTrain, "body_acc_z_train.txt", sep = "")

pathTrainTotAccX <- paste(pathInertialTrain, "total_acc_x_train.txt", sep = "")
pathTrainTotAccY <- paste(pathInertialTrain, "total_acc_y_train.txt", sep = "")
pathTrainTotAccZ <- paste(pathInertialTrain, "total_acc_z_train.txt", sep = "")

pathTrainBodyGyroX <- paste(pathInertialTrain, "body_gyro_x_train.txt", sep = "")
pathTrainBodyGyroY <- paste(pathInertialTrain, "body_gyro_y_train.txt", sep = "")
pathTrainBodyGyroZ <- paste(pathInertialTrain, "body_gyro_z_train.txt", sep = "")

######################################################################
############################ LOADING DATA ############################
######################################################################
### INITIAL
df_activity <- read.table(pathActivity, header = FALSE)
colnames(df_activity) <- c("id", "activity")
df_features <- read.table(pathFeatures, header = FALSE)

### Descriptive variables
df_features[,2] <- gsub("BodyBody", "Body", df_features[,2])
#df_features[,2] <- tolower(df_features[,2])
df_features[,2] <- gsub("[\\(\\)]", "", df_features[,2])
df_features[,2] <- gsub("-", "_", df_features[,2])


### DATA SET TEST
df_Xtest <- read.table(pathTestX, header = FALSE)
df_ytest <- read.table(pathTestY, header = FALSE)
df_subjecttest <- read.table(pathSubjectTest, header = FALSE)

df_testbodyacc_x <- read.table(pathTestBodyAccX, header = FALSE)
df_testbodyacc_y <- read.table(pathTestBodyAccY, header = FALSE)
df_testbodyacc_z <- read.table(pathTestBodyAccZ, header = FALSE)

df_testtotacc_x <- read.table(pathTestTotAccX, header = FALSE)
df_testtotacc_y <- read.table(pathTestTotAccY, header = FALSE)
df_testtotacc_z <- read.table(pathTestTotAccZ, header = FALSE)

df_testbodygyro_x <- read.table(pathTestBodyGyroX, header = FALSE)
df_testbodygyro_y <- read.table(pathTestBodyGyroY, header = FALSE)
df_testbodygyro_z <- read.table(pathTestBodyGyroZ, header = FALSE)

### DATA SET TRAIN
df_Xtrain <- read.table(pathTrainX, header = FALSE)
df_ytrain <- read.table(pathTrainY, header = FALSE)
df_subjecttrain <- read.table(pathSubjectTrain, header = FALSE)

df_trainbodyacc_x <- read.table(pathTrainBodyAccX, header = FALSE)
df_trainbodyacc_y <- read.table(pathTrainBodyAccY, header = FALSE)
df_trainbodyacc_z <- read.table(pathTrainBodyAccZ, header = FALSE)

df_traintotacc_x <- read.table(pathTrainTotAccX, header = FALSE)
df_traintotacc_y <- read.table(pathTrainTotAccY, header = FALSE)
df_traintotacc_z <- read.table(pathTrainTotAccZ, header = FALSE)

df_trainbodygyro_x <- read.table(pathTrainBodyGyroX, header = FALSE)
df_trainbodygyro_y <- read.table(pathTrainBodyGyroY, header = FALSE)
df_trainbodygyro_z <- read.table(pathTrainBodyGyroZ, header = FALSE)

########################################################################
############################ DATA WRANGLING ############################
########################################################################
### QUESTION 1
### INITIAL
df_X <- rbind(df_Xtest, df_Xtrain)
df_y <- rbind(df_ytest, df_ytrain)
df_subject <- rbind(df_subjecttest, df_subjecttrain)
names(df_X) <- df_features[,2] ### QUESTION 4
names(df_y) <- "id"   ### QUESTION 4

df_bodyacc_x <- rbind(df_testbodyacc_x, df_trainbodyacc_x)
df_bodyacc_y <- rbind(df_testbodyacc_y, df_trainbodyacc_y)
df_bodyacc_z <- rbind(df_testbodyacc_z, df_trainbodyacc_z)

df_totacc_x <- rbind(df_testtotacc_x, df_traintotacc_x)
df_totacc_y <- rbind(df_testtotacc_y, df_traintotacc_y)
df_totacc_z <- rbind(df_testtotacc_z, df_traintotacc_z)

df_bodygyro_x <- rbind(df_testbodygyro_x, df_testbodygyro_x)
df_bodygyro_y <- rbind(df_testbodygyro_y, df_testbodygyro_y)
df_bodygyro_z <- rbind(df_testbodygyro_z, df_testbodygyro_z)

### QUESTION 2
df_X_mean <- df_X[, grep(pattern = "mean", names(df_X))]
df_X_mean <- df_X_mean[, -grep(pattern = "meanFreq", names(df_X_mean))]
df_X_std <- df_X[, grep(pattern = "std", names(df_X))]


### QUESTION 3
df_y <- merge(df_y, df_activity, by.x = "id", by.y = "id")
df_y <- as.data.frame(df_y[,2]) 
names(df_y) <- "activity"

### QUESTION 5
df_total <- cbind(df_X_mean, df_X_std, df_y)
df_total_activity <- group_by(df_total, activity)
summary_mean_activity <- summarise_all(df_total_activity, funs(mean(.))) 
View(df_X_mean)
View(summary_mean_activity)
write.table(summary_mean_activity, file = "dataset.txt",row.names = FALSE)


