# Project Codebook
This project uses accelerometer and gyroscope data from the UCI Machine Learning Repository and outputs a tidy dataset of calculated means per subject and activity.

## Data
The data are downloaded from the UCI Machine Learning Repository: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 

The complete dataset has 30 participants. Data from each participant was captured while they were wearing a smartphone on their waist, during each of 6 activities. The complete dataset has been subset into two: a 70% sample for training and a 30% sample for testing. The following files are available on download:
* activity_labels.txt: contains the labels for the six activities.
* features.txt: the complete list of measurements taken from the smartphone.
* features_info.txt: summary information about the measurements in features.txt.
* X_train.txt (and X_test.txt): values of the measurements taken, broken down by subject.
* Y_train.txt (and Y_test.txt): the labels for X_train (and X_test).
* subject_train.txt (and subject_test.txt): the subject IDs for the respective sets.

## Variables
* activities: activity labels taken from activity_labels.txt, with underscores removed and put to lowercase.
* features: features taken from features.txt.
* extracted.features: dataframe with a logical column that indicates whether this feature is a mean or a standard deviation observation.
* full.data: the complete dataset after binding information from both test and training sets (including subject ID, measurement data and activity labels).
* melted.data: a tidy version of the full data. Includes only four columns: the subject ID (subject); the activity label (activity); the measure (measure); and the value of the measure (value).
* final.data: a tidy dataset with the mean of each measure, for each subject and activity in the dataset.

The following measures are extracted:
1. tBodyAccMean-X
2. tBodyAccMean-Y
3. tBodyAccMean-Z
4. tBodyAccStDev-X
5. tBodyAccStDev-Y
6. tBodyAccStDev-Z
7. tGravityAccMean-X
8. tGravityAccMean-Y
9. tGravityAccMean-Z
10. tGravityAccStDev-X
11. tGravityAccStDev-Y
12. tGravityAccStDev-Z
13. tBodyAccJerkMean-X
14. tBodyAccJerkMean-Y
15. tBodyAccJerkMean-Z
16. tBodyAccJerkStDev-X
17. tBodyAccJerkStDev-Y
18. tBodyAccJerkStDev-Z
19. tBodyGyroMean-X
20. tBodyGyroMean-Y
21. tBodyGyroMean-Z
22. tBodyGyroStDev-X
23. tBodyGyroStDev-Y
24. tBodyGyroStDev-Z
25. tBodyGyroJerkMean-X
26. tBodyGyroJerkMean-Y
27. tBodyGyroJerkMean-Z
28. tBodyGyroJerkStDev-X
29. tBodyGyroJerkStDev-Y
30. tBodyGyroJerkStDev-Z
31. tBodyAccMagMean
32. tBodyAccMagStDev
33. tGravityAccMagMean
34. tGravityAccMagStDev
35. tBodyAccJerkMagMean
36. tBodyAccJerkMagStDev
37. tBodyGyroMagMean
38. tBodyGyroMagStDev
39. tBodyGyroJerkMagMean
40. tBodyGyroJerkMagStDev
41. fBodyAccMean-X
42. fBodyAccMean-Y
43. fBodyAccMean-Z
44. fBodyAccStDev-X
45. fBodyAccStDev-Y
46. fBodyAccStDev-Z
47. fBodyAccMeanFreq-X
48. fBodyAccMeanFreq-Y
49. fBodyAccMeanFreq-Z
50. fBodyAccJerkMean-X
51. fBodyAccJerkMean-Y
52. fBodyAccJerkMean-Z
53. fBodyAccJerkStDev-X
54. fBodyAccJerkStDev-Y
55. fBodyAccJerkStDev-Z
56. fBodyAccJerkMeanFreq-X
57. fBodyAccJerkMeanFreq-Y
58. fBodyAccJerkMeanFreq-Z
59. fBodyGyroMean-X
60. fBodyGyroMean-Y
61. fBodyGyroMean-Z
62. fBodyGyroStDev-X
63. fBodyGyroStDev-Y
64. fBodyGyroStDev-Z
65. fBodyGyroMeanFreq-X
66. fBodyGyroMeanFreq-Y
67. fBodyGyroMeanFreq-Z
68. fBodyAccMagMean
69. fBodyAccMagStDev
70. fBodyAccMagMeanFreq
71. fBodyBodyAccJerkMagMean
72. fBodyBodyAccJerkMagStDev
73. fBodyBodyAccJerkMagMeanFreq
74. fBodyBodyGyroMagMean
75. fBodyBodyGyroMagStDev
76. fBodyBodyGyroMagMeanFreq
77. fBodyBodyGyroJerkMagMean
78. fBodyBodyGyroJerkMagStDev
79. fBodyBodyGyroJerkMagMeanFreq

## Transformations
The code checks first that the dataset is downloaded and unzipped to the working directory. If not it will perform these.

It then reads in the activities data. Column 2 contains the labels. Underscores are removed and text is put to lowercase.

Next, it reads in the features data, setting stringsAsFactors to FALSE to keep everything as characters. A second dataframe (extracted.features) is created that contains the logical vector used to extract the mean and standard deviation observations from the test and train datasets. The text of the feature labels is cleaned for some readability: 1) -mean is changed to Mean; 2) -std is changed to StDev and; 3) the parentheses before the XYZ-dimension are removed.

Next, the subject IDs, the observation data and the activity labels are read in, each to separate dataframes. Note that the observation data are read in using the extracted.features logical vector, removing any observation not related to the mean or standard deviation. These separate dataframes are merged in a two-step process. First, a cbind is performed on the test and training separately. Then, an rbind is performed to merge the test and training datasets. The result is the full.data dataframe.

Next, the full.data set is melted by supplying the id and label categories as the id variables [id.vars=c("id", "label")]. The columns of the melted dataset are renamed to be subject, activity, measure and value.

Finally, the melted data is cast to produce a tidy dataset with the means for each variable, according to activity and subject. This dataset is called final.data and is written to the working directory as data.txt.

## Output
The final output is the file data.txt. Headers are included, but not row names. It can be found in the working directory.

