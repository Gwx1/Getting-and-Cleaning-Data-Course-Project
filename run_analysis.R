##install and load the required packages: dplyr and plyr
install.packages("dplyr")
install.packages("plyr")
library(plyr)                       ## if problems: run the functions seperately
library(dplyr)                      ## if problems: run the functions seperately                                                                          

## Make WD/Data, Download and unzip file  

if(!file.exists("data")) 
{dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest <- "./data/Smartphones.zip"
download.file(fileUrl, dest)
unzip(dest, exdir = "./data")

######################### First step ############################  
## Merge the training and the test sets to create one data set ##
################################################################# 

#### Step 1.1: read all relevant files

X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")                
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "")                                                                                   
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "")                                                               
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")             
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "")                                                                              
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "") 
                                                       
#### Step 1.2: rename the Columnnames of the Activity-Variable and the ID to avoid dubplication of "V1" 

y_test <- rename(y_test, Act = V1)
subject_test <- rename(subject_test, ID = V1)
y_train <- rename(y_train, Act = V1)
subject_train <- rename(subject_train, ID = V1)  

#### Step 1.3: Match the datasets

Test <- cbind(y_test, X_test)                 ## Columnbind Values and Labels of Testsubjects
Train <- cbind(y_train, X_train)              ## Columnbind Values and Labels of Trainsubjects
subject <- rbind(subject_test, subject_train) ## Rowbind the IDs of the test- and train-subjects 
TT <- rbind(Test, Train)                      ## Match the Test and Train-dataset with rowbind
Set <- cbind(subject, TT)                     ## columnbind IDs with the matched data in the object "set"
                                            
## Set is the matched data

######################### Second step ###########################  
#### Extract only the measurements on the mean and standard #####
############### deviation for each measurement ##################
#################################################################  

#### Step 2.1: Prepare the Columnnames of the dataset to select variables with keywords

features <- read.table("./data/UCI HAR Dataset/features.txt") ## read the Columnnames
m1 <- matrix(c(0,0,"ID","Act"), nrow=2, ncol=2)               ## This step is just to avoid some problems by extract a vector of the colnames
m2 <- as.matrix(features)                                     ## this step is -"-
mm <- rbind(m1,m2)                                            ## nonsence-matrix
header <- mm[,2]                                              ## extract column 2 (all columnnames)  as a vector
colnames(Set) <- header                                       ## rename all columns from set

## Notice: The way of doing this step makes the whole Step 4 redundant

#### Step 2.2: Extract the Variables with mean and standard deviation

myCols <- c("ID", "Act")                                                ## prepare another colname-vector
meanStdColumnsNames <- grep("mean()|std()", features$V2, value = TRUE)  ## extract only the values from features$V2 (Column-names) with keywords std and mean
Meanfreq <- grep("meanFreq", meanStdColumnsNames, value = TRUE)         ## extract from the new vector all values with keyword "meanFreq"
TrueLabels <- c(myCols, setdiff(meanStdColumnsNames, Meanfreq))         ## delete all values with "meanFreq" and store it into a new vector "TrueLabels"
Finaldata <- Set[,TrueLabels]                                           ## Subset only the Columns from "Set" which equals values from "TrueLabels"

## Object "Finaldata" is a the required subset

######################### Third step ###########################  
#### Use descriptive activity names to name the activities #####
####################### in the data set ########################
################################################################ 

## for this Step we actually only need to recode the values from the variable "Act"
## into the required names by using the revalue-function from the plyr-package. 

activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
print(activity_labels)

## to find out the labels we have to read the activity_labels
## using this Information we can simply recode the numbers (1,2,...)
## to the dedicated Values (WALKING, WALKING_UPSTAIRS,...)

Finaldata$Act <- as.factor(Finaldata$Act) ## obligatory to use the revalue-function
Finaldata$Act <- revalue(Finaldata$Act, c("1"="WALKING", "2"="WALKING_UPSTAIRS", "3"="WALKING_DOWNSTAIRS", "4"="SITTING", "5"="STANDING", "6"="LAYING"))

########################### 4. step ############################  
#### Appropriately labels the data set with descriptive   ######
####################### variable names  ########################
################################################################ 


## This step was already done in step 2.1 and 2.2

########################### 5.step #############################  
####### From the data set in step 4, creates a second, #########
######## independent tidy data set with the average of #########
###### each variable for each activity and each subject  #######
################################################################ 

Tidydata <- (Finaldata %>%      
  group_by(ID, Act) %>%         
  summarise_each(funs(mean)))   ## Summarise each variable with the mean grouped by ID and Act

## I don't like the fact, that the columnnames are the same as in the Finaldata
## because there are actually different variables (avarage values vs. avagerage value
## of all the avarage values). To adress that i did this additional step

colnames(Tidydata) <- paste("Avarage", colnames(Tidydata), sep = "_")
colnames(Tidydata)[1:2] <- c("ID", "Act")

## The object "Tidydata" is the last required dataset 

write.table(Tidydata, file= "./data/Tidydata.txt", row.name=FALSE) ## save the table in the Working Directory/data-Folder
