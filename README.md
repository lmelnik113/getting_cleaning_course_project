# run_analysis READ ME 

This README explains my script, run_analysis.R for the Getting & Cleaning Data course project

## Script purpose

The script reads in the Samsung Galaxy S smartphone wearable computing data found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It processes this data and makes it into a neat, tidy data set with proper titles. It selects all the mean() and std() columns and finally takes the averages of them for each test subject.

### Steps
1. Download & unzip the file
2. Read in each file from the data folder
3. Append test + training datasets together
4. Load in the column names, append the column names to the measurement data
5. Pick out the right columns - the ones that contain mean & sd and then bind all data together into one table
6. Load in activity names, look at them, change all factors to activity names
7. Get the averages for the last step

