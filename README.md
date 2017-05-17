#Tidy dataset

The script "run_analysis.R" creates a tidy dataset from the  
"Human Activity Recognition Using Smartphones Data Set" 
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
It is assumed that the file has already been downloaded and extracted, and that the 
R working directory if set to the extracted dataset.

The script reads the data from the training and testing data files (measurements, labels, and subjects),
and combines it into a single table. The column are renamed using the provided feature 
names, and the labels are converted to descriptive variable names using the provided 
activity names.

The script then extracts the mean and standard deviation for each measurement, and rewrites
the resulting data as a tidy table where each row contains a single measurement (mean and
standard deviation). The measurement type and coordinate (if applicable) are kept as 
extra variables (see CodeBook.md for details). The result is saved in the file "tidy_data.txt".

The scripts also computes a second tidy table, containg the mean of each variable
(measurement type and coordinate) across all measurements for each subject and activity.
The result is saved in the file "tidy_summary.txt".