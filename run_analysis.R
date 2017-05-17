library(dplyr)
library(data.table)
library(tidyr)

#Debug
nr=-1

#Read the feature names
var_names=read.table("features.txt",stringsAsFactors=FALSE)[[2]]

#Read the training and testing data, and merge them into a single table.
dat1=merge(read.table("train/X_train.txt",col.names=var_names,nrows=nr),
           read.table("test/X_test.txt",col.names=var_names,nrows=nr),
           all=TRUE)

#Extract the columns corresponding to means and standard deviations.
#Convert to a data table for future use
dat2=data.table(dat1[grep("(mean\\(\\)|std\\(\\))",var_names)])


#Read the labels, merge them, match the values
#with the provided activity names, and append the result to the table.
dat2[,Activity:=factor(
  x=c(readLines("train/y_train.txt",n=nr),readLines("test/y_test.txt",n=nr)),
  labels=read.table("activity_labels.txt",stringsAsFactors=FALSE)[[2]]
  )]

#Read the subjects, merge them, and append the result to the table.
dat2[,Subject:=as.integer(c(readLines("train/subject_train.txt",n=nr),
                 readLines("test/subject_test.txt",n=nr)))]

#Make tidy data: each row contains the mean and std for a specific
#activity, subject, measurement, and (if applicable) coordinate type
dat2[,Id:=1:nrow(dat2)]
dat3=gather(dat2,Measurement,Value,-Activity,-Subject,-Id)
dat4=separate(dat3,Measurement,c("Measurement","Type","Coordinate"))
dat5=select(spread(dat4,Type,Value),-Id)

#Compute the mean of each variable for each subject and activity
dat6=summarize(group_by(dat5,Activity,Subject,Measurement),mean=mean(mean),std=mean(std))

#Write the two resulting datasets
write.table(dat5,"tidy_data.txt",row.name=FALSE)
write.table(dat6,"tidy_summary.txt",row.name=FALSE)




