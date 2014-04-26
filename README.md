# getdata-002-project
===================

## Project for Coursera's Getting and Cleaning data course

run_analysis.R processes a set of data containing various sensor readings for various subjects performing several activites

### Requirements:
* data folder at the same level of run_analysis.R with the contents of (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


### Run instructions
* Rscript run_analysis.R

### Description

## First dataset (dataset1)
## 	1. merges the two datasets, training and test, for both X, y, and subject list
##	2. adds a activity column factor
##	3. builds a feature subset vector containing only the column names containing mean, Mean and std
##	4, build a dataset filtered by the feature subset
##	5. returns both the filtered and unfiltered datasets

