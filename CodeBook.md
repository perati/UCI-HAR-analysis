# CodeBook - UCI HAR Dataset cleaning and tidying

* _Data_: Information about the data source and description
* _Variables_: Information about the variables in the dataset
* _Trasformation_: Information about the transformation of the original dataset


## Data

Original Data
The data include accelerometer measurements collected from the Samsung Galaxy S smartphone.
The original data can be found at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The type of files related to this analysis include:
* Test set data: X (actual measurements), Y (coded features corresponding to X measurements), Subject Number
* Training set data: X (actual measurements), Y (coded features corresponding to X measurements), Subject Number
* Activity labels related to the set Y data
* Features list

The resulting dataset includes the formation of a single dataset from the combination of both Tese and Training measurements.


## Variables

The variables of the resulting dataset include:
* The activity for each measurement
* The Subject Number for each measurement
* A selection of features original dataset which include mean and standard deviation measurements


## Transformation

For both test and training measurement sets

* Replace the activity coding to Y data with names from activity labels
* Replace the variable names of X data with names from Features list
* Merge the Activity (Y), Subject Number, and Features (X) data to a single dataset

Then

* Combine the test and training datasets to a single dataset, experimentData
* Subset to include only variables for mean and standard deviation measurements
* Create a final dataset with the mean of each variable for each Activity and Subject Number








