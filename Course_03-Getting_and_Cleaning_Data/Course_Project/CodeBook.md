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
-- LAYING;
-- SITTING
-- STANDING
-- WALKING
-- WALKING_DOWNSTAIRS
-- WALKING_UPSTAIRS
The remaining 66 variables are mean values computed on detail values by subjectID, 
activityDescription. As there are 30 volunteers (subjectIDs) and 
6 activities (activityDescription), the total number of rows is 180.
