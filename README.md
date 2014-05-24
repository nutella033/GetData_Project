The run_analysis.R script performs the following processing of the Samsung Galaxy S accelerometer data.

1. Binds the activity, subject and measurements for the training and testing sets respectively.
2. Merges the training and testing sets together to form one master data set.
3. Extracts only the measurements relating the mean or standard deviation and drops the others.
4. Replaces the activity ID numbers with the actual activity names.
5. Melts and casts the measurements to calculate the mean of the measurements per Subject/Activity pair.

In order to use the script, the data must be located in the working directory.
