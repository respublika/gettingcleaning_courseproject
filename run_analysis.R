#######################################################
#I. Reading necessary files and discover their content#
#######################################################

test_x<-read.table("C:/Users/CEU-TA/Documents/UCIDataset/test/X_test.txt")
test_y<-read.table("C:/Users/CEU-TA/Documents/UCIDataset/test/y_test.txt")
test_sub<-read.table("C:/Users/CEU-TA/Documents/UCIDataset/test/subject_test.txt")

train_x<-read.table("C:/Users/CEU-TA/Documents/UCIDataset/train/X_train.txt")
train_y<-read.table("C:/Users/CEU-TA/Documents/UCIDataset/train/y_train.txt")
train_sub<-read.table("C:/Users/CEU-TA/Documents/UCIDataset/train/subject_train.txt")

dim(test_x)
dim(test_y)
dim(test_sub)

dim(train_x)
dim(train_y)
dim(train_sub)

table(test_sub)
table(train_sub)

activ<-read.table("C:/Users/CEU-TA/Documents/UCIDataset/activity_labels.txt")
feat<-read.table("C:/Users/CEU-TA/Documents/UCIDataset/features.txt")

dim(activ)
dim(feat)
activ
head(feat)


######################################################
#2. For test and train datasets adding parts together#
######################################################

test<-test_sub
colnames(test)<-c("subjectID")
colnames(test_y)<-c("activityID")
test<-cbind(test, test_y)
head(test)
varnames<-feat[, 2]
head(varnames)
colnames(test_x)<-varnames
head(test_x, 2)
test<-cbind(test, test_x)
head(test)
dim(test)

train<-train_sub
colnames(train)<-c("subjectID")
colnames(train_y)<-c("activityID")
train<-cbind(train, train_y)
head(train)
colnames(train_x)<-varnames
head(train_x, 2)
train<-cbind(train, train_x)
head(train)
dim(train)


##########################################################################
#3. Adding test and train dataset together, and sort them by ID variables#
##########################################################################

dataset_v1<-rbind(train, test)
dim(dataset_v1)
head(dataset_v1)

dataset_v1<-dataset_v1[order(dataset_v1$subjectID, dataset_v1$activityID),]
head(dataset_v1[, 1:2])
table(dataset_v1[, 1])
table(dataset_v1[, 2])
summary(dataset_v1)


###################################################################################
#4. Filter required variables (with "mean" or "standard deviation" in their names)#
###################################################################################

feat$mn<-"mean"
feat$mntrue<-grepl(feat$mn, feat$V2)
feat$std<-"std"
feat$stdtrue<-grepl(feat$std, feat$V2)
head(feat)
featneeded<-feat[feat$mntrue==TRUE | feat$stdtrue==TRUE, ]
featneeded$V1
neededcols<-c(1, 2, featneeded$V1+2)
dim(dataset)
dataset_v2<-dataset_v1[, neededcols]
dim(dataset_v2)


#################################################################################
#5. Aggregate the dataset with the mean of each variable by activity and subject#
#################################################################################

dataset_v3<-aggregate(dataset_v2, by=list(dataset_v2$subjectID, dataset_v2$activityID), FUN=mean, na.rm=TRUE)
dim(dataset_v3)
head(dataset_v3)
dataset_v3[, 1:4]


#########################################################
#6. Adding another variable with the names of activities#
#########################################################

colnames(activ)<-c("V1", "activityNAME")
dataset_v3<-merge(dataset_v3, activ, by.x="activityID", by.y="V1", all=TRUE)


###################
#7. Final cleaning#
###################

dataset_v4<-dataset_v3[, c(4, 1, 84, 5:83)]
dim(dataset_v4)
head(dataset_v4)
table(dataset_v4$subjectID)
table(dataset_v4$activityID, dataset_v4$activityNAME)


######################################################
#8. Writing out the final version of the tidy dataset#
######################################################

write.table(dataset_v4, "Samsung_tidy_data.txt", row.name=FALSE) 

