# assuming we start at the top of the directory "UCI HAR Dataset"

# read in the file that describes the measurement vector columns
cols <- read.table("features.txt")
cols2 <- as.character(cols$V2)
rm(cols)

# these are the columns that contain mean and std dev for each measurement
keep <- c(grep("-mean()",cols2,fixed=TRUE),grep("-std()",cols2,fixed=TRUE))
skeep <- sort(keep)

# read in the 3 files containing the measurements vector, subject, and activity for test set
# while we're at it, relabel the activity and subject
datats <- read.table("test/X_test.txt",col.names=cols2)
subts <- read.table("test/subject_test.txt")
colnames(subts) <- "Subject"
actits <- read.table("test/Y_test.txt")
colnames(actits) <- "Activity"

# read in the 3 files containing the measurements vector, subject, and activity for train set
datatn <- read.table("train/X_train.txt",col.names=cols2)
subtn <- read.table("train/subject_train.txt")
colnames(subtn) <- "Subject"
actitn <- read.table("train/Y_train.txt")
colnames(actitn) <- "Activity"

# merge the test and train data together
mergedata <- rbind(datats,datatn)
mergesub <- rbind(subts,subtn)
mergeacti <- rbind(actits,actitn)

# extract only the mean and std from the merged data
# (could use melt() here, too)
extdata <- mergedata[,skeep]

# read in our descriptive activity names
actnames <- read.table("activity_labels.txt")
colnames(actnames) <- c("Activity","Activity Description")

# replace the activity ids column with descriptive names
mergeacti <- join(mergeacti,actnames,by="Activity")
mergeacti$Activity <- NULL

# column bind the data together
testdata <- cbind(mergesub,mergeacti,extdata)

# remove some of our working variables to better manage memory
# the only thing we want to keep is the merged data
tempvars <- c("datats","subts","actits","datatn","subtn","actitn","mergedata","mergesub","mergeacti","extdata")
rm(list=tempvars)

# average the mean() and std() variables for each subject and activity
alist <- list(testdata$Subject,testdata$'Activity Description')
avedata <- aggregate(testdata,alist,FUN=mean)

# remove extra columns -- we only want Activity, SUbject, and the means(), but
# aggregate adds Group.1 and Group.2 as well
avedata$Group.1 <- NULL
avedata$'Activity Description' <- NULL

# now let's simplify the column names for the averages, 
# because there are a bunch of them and they are hard to read
cn <- cols2[skeep]

for ( i in 1:length(cn) ) {
    tn1 <- cn[i]
    # split into variable name, function, and axis
    v <- unlist(strsplit(tn1,c("-")))
    # reformat, based on whether or not there is an axis (some variables don't have one)
    if ( is.na(v[3]) ) {
        newcol <- sprintf("%s Ave of %s",v[1],v[2])        
    } else {
        newcol <- sprintf("%s.%s Ave of %s",v[1],v[3],v[2])        
    }

    cn[i] <- newcol
}

colnames(avedata) <- c("Activity","Subject",cn)

# and finally, write out the second tidy data set
write.csv(avedata,file="avedata.csv",row.names=FALSE)





