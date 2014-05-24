library(reshape2)

# Read list of features
features <- read.table("UCI HAR Dataset/features.txt",header=FALSE,stringsAsFactors=FALSE)[,2]

# Read list of activities
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activities) <- c("ActivityID","Activity")

# Read training data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)
names(x_train) <- features
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)
names(y_train) <- "ActivityID"
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)
names(subject_train) <- "Subject"
train <- cbind(subject_train,y_train,x_train)
train

# Read testing data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)
names(x_test) <- features
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)
names(y_test) <- "ActivityID"
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
names(subject_test) <- "Subject"
test <- cbind(subject_test,y_test,x_test)

# Merge training and testing data
data <- rbind(train,test)

# Find features relating to mean or standard deviation
# That is, extract any variables whose name contains 'std()'
# or 'mean()' along with the 'Subject' and 'Activity'
data <- data[,c(1,2,grep("(std\\(\\))|(mean\\(\\))",names(data)))]

# drop brackets from column names for legibility
names(data) <- gsub("[\\(\\)]","",names(data))

# Merge activity names
data <- merge(activities,data,by="ActivityID")

# Drop activity ID as it is no longer needed
data$ActivityID <- NULL

# Melt data
data_melted <- melt(data,id=c("Subject","Activity"))

# Cast data, calculating the mean of the variables
data_casted <- dcast(data_melted,Subject + Activity ~ variable, fun.aggregate=mean)

# Output tidy data
write.table(data_casted,"acceldata_tidy.txt",row.names=FALSE,sep=",")
