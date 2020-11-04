#Introduction
The script run_analysis.Rperforms the 5 steps described in the course project's definition.

First of all,we download the dataset into a folder and unzip the data zip file.We read the training data and test data from the data set. Thus, we merge train and test data.
After that, we load the info of feature and activity and start to extract mean and standard deviation. We also need to use descriptive activity name to name activity.
When everything is ready, we generate tidy data set into a text file.


#Variables
ActivityTest, ActivityTrain ,SubjectTrain, SubjectTest, FeaturesTest, FeaturesTrain contain the data from the downloaded files.
Subject, Activity, Features merge the previous datasets to further analysis.
Data merges three of th data in a big dataset.
Finally, prepared data stored in a .txt file. ddply() from the plyr package.
