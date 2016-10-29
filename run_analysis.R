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

##  Extract std columns
cols<-append(cols,grep("std\\(",colnames(xFull)))

## Select mean columns only
xMeanStd<-xFull[cols]

## Read activity labels
activityLabels<-read.table("activity_labels.txt")

## Rename columns
names(activityLabels)<-c("ActivityCode","Activity")

## Merge Activity codes and data
xMeanStd<-cbind(xMeanStd,yfull)

## Merge subject codes and data
xMeanStd<-cbind(xMeanStd,subjectFull)
xMeanStd<-merge(xMeanStd,activityLabels,by.x="X5", by.y="ActivityCode")
xMeanStd<-select(xMeanStd,-X5)

## Compute average standard deviation by Activity and subject
averageMeanStd<-xMeanStd %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))


## Save computed averages to files
write.table(averageMeanStd,"averagemeanstd.txt", row.name=FALSE)
