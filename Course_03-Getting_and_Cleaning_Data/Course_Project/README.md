# Getting and cleaning data - Course Project
This project folder contains all the information about 'Getting and Cleaning Data' Course Project - a Coursera course by Johns Hopkins University.

Briefly, the goal of the project is to:
- retrieve raw data coming from 30 Samsung Galaxy S smartphones weared by 30 volunteers (Human Activity Recognition experiment);
- process the data in order to have a clean and usable data set;
- output the tidy data set to make it available for later analysis steps.

## Overview of the experiment
The goal of the experiment was to analyze data on the physical activity carried out by 30 volunteers in 6 different activities. The data were collected using Samsung S II smartphones. For more information see [HumanActivityRecognitionUsingSmartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Available files
The available files are as follows:
- Codebook.md: it describes the variables of the final data set ("tidyDataSet.txt") and the steps performed by the R program ("run_analysis.R");
- Readme.md: it describes the goal of the project and the experiment;
- run_analysis.R: it shows the steps performed to get, transform and clean the data and to create the final tidy data set;
- tidyDataSet.txt: it contains the final tidy data set ready for analysis.

## The R script - 'run_analysis.R'
The script performs the following main tasks:
- retrieve and unzip the input data set;
- transforms and clean the data;
- create the final tidy data set.

Below, the steps in detail:


