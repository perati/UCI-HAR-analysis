
library(dplyr)
library(tidyr)

featuredir<-'./UCI HAR Dataset/features.txt'
activitydir<-'./UCI HAR Dataset/activity_labels.txt'

testSdir<-'./UCI HAR Dataset/test/subject_test.txt'
testYdir<-'./UCI HAR Dataset/test/Y_test.txt'
testXdir<-'./UCI HAR Dataset/test/X_test.txt'

trainSdir<-'./UCI HAR Dataset/train/subject_train.txt'
trainYdir<-'./UCI HAR Dataset/train/Y_train.txt'
trainXdir<-'./UCI HAR Dataset/train/X_train.txt'


#features - read and use make names to make column names readable
featureData<-read.table(featuredir)
featureColNames<-make.names(as.vector(featureData[,2]),unique = TRUE,allow_ = TRUE)

#activity
activityNames<-read.table(activitydir)


#TEST DATA

#test subject - read and rename variable to SubjectNo
testS<-
       read.table(testSdir) %>%
       rename(SubjectNo=V1)

#test activity Y
#read and rename variable to Activity. 
#replace values with names from activityNames that match the activity number
testY<-
       read.table(testYdir) %>%
       rename(Activity=V1)

testY$Activity<-activityNames[,'V2'][match(testY$Activity,activityNames[,'V1'])]

#test data X
#read and replace vars with feature names from featureColNames
testX<-read.table(testXdir)
names(testX)<-featureColNames

#merge test data with bind_cols
testData<-bind_cols(testY,testS,testX)


#TRAIN DATA

#train subject - read and rename variable to SubjectNo
trainS<-
       read.table(trainSdir) %>%
       rename(SubjectNo=V1)

#train activity Y
#read and rename variable to Activity. 
#replace values with names from activityNames that match the activity number
trainY<-
       read.table(trainYdir) %>%
       rename(Activity=V1)

trainY$Activity<-activityNames[,'V2'][match(trainY$Activity,activityNames[,'V1'])]

#train data X
#read and replace vars with feature names from featureColNames
trainX<-read.table(trainXdir)
names(trainX)<-featureColNames

#merge train data with bind_cols
trainData<-bind_cols(trainY,trainS,trainX)



#EXPERIMENT DATA

#merge train and test data with bind_rows
experimentData<-bind_rows(trainData,testData)

#subset the merged data to include only variables of mean and std
#!since there are variables that include the string mean and std 
#but are not mean or standard deviation calculations, such as meanFreq, the '.' is used to
#select only the correct variables
experimentSubData<-
       select(experimentData,
              Activity,
              SubjectNo,
              contains('.mean.'),
              contains('.std.')
       )


#create a new dataset with the mean of each variable for each Activity and SubjectNo
experimentSubDataMean<-
       experimentSubData %>%
       group_by(Activity,SubjectNo) %>%
       summarize_each(funs(mean))


#write the final dataset to a txt file
write.table(experimentSubDataMean,"UCI_HAR_Mean.txt",row.name=FALSE)

