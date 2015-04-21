# Getting-and-Cleaning-Data-Course-Project 
## Description of the Course-Project
<blockquote>
<p>The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  </p>

<p>One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:  </p>

<p>http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  </p>

<p>Here are the data for the project:  </p>

<p>https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  </p>

<p> You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. </p>

<p>Good luck! </p>
</blockquote>

## Description and content of this repository ##

* Following the tasks above there was a file named "Tidydata.txt" created which is also stored in this repository. It's a tidy dataframe with a total of 68 variables and 180 observations (Note: The first line is the header). 
* The dataframe matches the requirements for tidy data from Hadley Wickham (http://vita.had.co.nz/papers/tidy-data.pdf): 1) Each  variable forms a column, 2) each observation forms a row and 3) each type of observational unit forms a table. Keep in mind that one observation is composed of the subject (ID) <b>and</b> the specific activity (Act). So every observation have one unique row.
* The R script required to reproduce this dataframe is named "run_analysis.R" and is also stored in this repository. 
* The file "Codebook.md" describes the variables of the Tidydata.txt, the data, and any transformations or work that was performed to make the raw data tidy

#### Content of the repository ####
* run_analysis.R
* CodeBook.md
* Tidydata.txt
* README.md

## Reproduce and understand this project ##
* To understand the final dataframe (Tidydata.txt) and the steps to transform the raw data, it's first necessary to understand the structure of the raw data. For this you should read the Readme.txt in the "UCI HAR Dataset"-folder inside the packed file (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* To reproduce "Tidydata.txt" inside "{working directory}/data/", simply copy the code from "run_analysis.r"-script and execute it with R (Version 3.1.3 - 2015-03-09). This should take a few minutes. If there are any problems, try to load the required packages seperate (library(dplyr), library(plyr)).
* The "CodeBook.md"-file descripes the steps to form the tidydata
* The "run_analysis.r"-script is also well commented. For a better understanding the processes in R to form the tidy data, it should also be read.
