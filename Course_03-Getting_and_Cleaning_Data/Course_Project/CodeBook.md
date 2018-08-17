# Getting and cleaning data - Course Project
## Introduction
This CodeBook documents the contents of the 'tidyDataSet.txt' file. This file is the output
of the 'run_analysis.R' script. Please refer to the Readme.md file for further information about
the Course Project and the experiment.
## File description
The file created by the script is a text file with 68 space-separated fields. The first row of 
the file contains the names of each columns. The first two columns identify in a unique way
the row (they are the 'primary key' of the file). In detail:
- **subjectID**: it identifies the volunteer number (range: 1 - 30; integer);
- **activityDescription**: it identifies the specific activity performed by the human. The domain 
values (string) are as follows:

    - LAYING;
    - SITTING
    - STANDING
    - WALKING
    - WALKING_DOWNSTAIRS
    - WALKING_UPSTAIRS

The remaining 66 variables are mean values computed on detail activity values by subjectID, 
activityDescription. As there are 30 volunteers (subjectIDs) and 
6 activities (activityDescription), the total number of rows is 180.

## Variables description
The 66 variables are the only variables containing info about mean and standard deviation. As
required, they were picked up by a wider file containing 561 variables (see script for detail).
The characteristics of the variables are as follows: - 
- values normalized and bounded within [-1, 1];
- two main types of measurements: time (prefix 'time') and frequency (prefix 'frequency');

Below, a brief desciption of the variables (starting from the third column):
- time body accelerometer measure - mean values - X, Y and Z axes --> three variables (cols 3 - 5);
- time body accelerometer measure - standard deviation values - X, Y and Z axes --> three variables (cols 6 - 8);
- time gravity accelerometer measure - mean values - X, Y and Z axes --> three variables (cols 9 - 11);
- time gravity accelerometer measure - standard deviation values - X, Y and Z axes --> three variables (cols 12 -14;
- time body accelerometer jerk measure - mean values - X, Y and Z axes --> three variables (cols 15 - 17);
- time body accelerometer jerk measure - standard deviation values - X, Y and Z axes --> three variables (cols 18 - 20);
- time body gyroscope measure - mean values - X, Y and Z axes --> three variables (cols 21 - 23);
- time body gyroscope measure - standard deviation values - X, Y and Z axes --> three variables (cols 24 - 26);
- time body gyroscope jerk measure - mean values - X, Y and Z axes --> three variables (cols 27 - 29);
- time body gyroscope jerk measure - standard deviation values - X, Y and Z axes --> three variables (cols 30 - 32);
- time body accelerometer magnitude measure - mean value - (cols 33 - 33);
- time body accelerometer magnitude measure - standard deviation value - (cols 34 - 34);
- time gravity accelerometer magnitude measure - mean value - (cols 35 - 35);
- time gravity accelerometer magnitude measure - standard deviation value - (cols 36 - 36);
- time body accelerometer jerk magnitude measure - mean value - (cols 37 - 37);
- time body accelerometer jerk magnitude measure - standard deviation value - (cols 38 - 38);
- time body gyroscope magnitude measure - mean value - (cols 39 - 39);
- time body gyroscope magnitude measure - standard deviation value - (cols 40 - 40);
- time body gyroscope jerk magnitude measure - mean value - (cols 41 - 41);
- time body gyroscope jerk magnitude measure - standard deviation value - (cols 42 - 42);
- frequency body accelerometer measure - mean values - X, Y and Z axes --> three variables (cols 43 - 45);
- frequency body accelerometer measure - standard deviation values - X, Y and Z axes --> three variables (cols 46 - 48);
- frequency body accelerometer jerk measure - mean values - X, Y and Z axes --> three variables (cols 49 - 51);
- frequency body accelerometer jerk measure - standard deviation values - X, Y and Z axes --> three variables (cols 52 - 54);
- frequency body gyroscope measure - mean values - X, Y and Z axes --> three variables (cols 55 - 57);
- frequency body gyroscope measure - standard deviation values - X, Y and Z axes --> three variables (cols 58 - 60);
- frequency body accelerometer magnitude measure - mean value - (cols 61 - 61);
- frequency body accelerometer magnitude measure - standard deviation value - (cols 62 - 62);
- frequency body accelerometer jerk magnitude measure - mean value - (cols 63 - 63);
- frequency body accelerometer jerk magnitude measure - standard deviation value - (cols 64 - 64);
- frequency body gyroscope magnitude measure - mean value - (cols 65 - 65);
- frequency body gyroscope magnitude measure - standard deviation value - (cols 66 - 66);
- frequency body gyroscope jerk magnitude measure - mean value - (cols 67 - 67);
- frequency body gyroscope jerk magnitude measure - standard deviation value - (cols 68 - 68);



