## week4.R
## Patrick Rotzetter
## October 2016

## Read training data for y
yTrain<-read.table("train/y_train.txt",header=TRUE)

## Read training data for x
xTrain<-read.table("train/X_train.txt",header=TRUE)

## Read test data for y
yTest<-read.table("test/y_test.txt",header=TRUE)

## Read test data for x
xTest<-read.table("test/X_test.txt",header=TRUE)

## Read and merge subject train and test data
subjectTest<-read.table("test/subject_test.txt",header=TRUE)
subjectTrain<-read.table("train/subject_train.txt",header=TRUE)
names(subjectTest)<-colnames(subjectTrain)
subjectFull<-rbind(subjectTrain,subjectTest)
names(subjectFull)<-"Subject"

## Read features
features<-read.table("features.txt")

## Rename column names in test and training set using features names
colnames(xTest)<-features$V2
colnames(xTrain)<-features$V2

## Merge test and training data
xFull<-rbind(xTrain,xTest)
yfull<-rbind(yTrain,yTest)

##  Extract mean columns
cols<-grep("mean\\(",colnames(xFull))

## Select mean columns only
xMeans<-xFull[cols]

##  Extract std columns only
cols<-grep("std\\(",colnames(xFull))

## Select mean columns only
xStd<-xFull[cols]

## Read activity labels
activityLabels<-read.table("activity_labels.txt")

## Rename columns
names(activityLabels)<-c("ActivityCode","Activity")

## Merge Activity codes and data
xMeans<-cbind(xMeans,yfull)
xStd<-cbind(xStd,yfull)

## Merge subject codes and data
xMeans<-cbind(xMeans,subjectFull)
xStd<-cbind(xStd,subjectFull)
xMeans<-merge(xMeans,activityLabels,by.x="X5", by.y="ActivityCode")
xStd<-merge(xStd,activityLabels,by.x="X5", by.y="ActivityCode")
xMeans<-select(xMeans,-X5)
xStd<-select(xStd,-X5)

## Compute average standard deviation by Activity and subject
averageStd<-xStd %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))

## Compute average means by Acitivity and subject
averageMean<-xMeans %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))


## Save computed averages to files
write.csv(averageStd,"averagestd.csv")
write.csv(averageMean,"averagemean.csv")
