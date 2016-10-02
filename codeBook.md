Source Data
In this project we were given a data set from the UCI Machine learning repository.
That we took from the following link :
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


Next
The script run_analysis.R will perform the 5 steps below :.
•	First, we will merge similar data using the row bind  rbind() function. 
•	Next , we will take the mean and standard deviation measureemnt are taken from the whole dataset. 
•	Once we extract these columns, we will make sure we put appropriate  correct names, taken from features.txt.
•	we take the activity names and IDs  from activity_labels.txt from activity value 1:6 
•	we make sure all columns have good names
•	Then we generate a new dataset with all the mean of each subject and activity type (

The Variables
•	x_train :  x training
•	y_train, : y training  
•	x_test : x test 
•	y_test : y testing, 
•	subject_train : subject training 
•	subject_test :  subject testing 
•	Then we merge the x_data, y_data and subject_data 
•	Also the features in  the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
We do the same thing for the  activities variable.
•	Finally all the data is  merged x_data, y_data and subject_data in a big dataset.


