---
title: "CodeBook"
author: "Amit"
date: "7/19/2020"
output: html_document
---

# Code Book for Creating 'tidy_data_summary' Data Table 
*** 
 
### Table of Contents  
 
  1. Introduction
  2. Source of Raw Dataset 
  3. Description of Raw Data
      * Unzipped Data
      * Useful Files & Identifier Variables
  4. Process to create the 'Tidy' dataset
  5. Description of f'iles in the repository'run_analysis.R'
  6. Reproducing the Dataset
  7. License
  
****
#### 1. Introduction
  1a. One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The project is about creating a 'Tidy Data Summary' from the data linked to the coursera.org website. This data represents data collected from the accelerometers from the Samsung Galaxy S smartphone. 

1b. The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

1c. The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

1d. For each record following provided:

    * Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
    * Triaxial Angular velocity from the gyroscope. 
    * A 561-feature vector with time and frequency domain variables. 
    * Its activity label. 
    * An identifier of the subject who carried out the experiment.

#### 2. Source of Raw Dataset

2a. The data for the project is available from the following link:

      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2b. A full description is available at the site where the data was obtained:

      http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#### 3. Description of Raw Data

3a. Unzipped Data.  The data file when unzipped creates the folder, 'UCI HAR Dataset' containing the following folders/ files:-
    (i)  Folders - test & train
    (ii) Files - activity_labels.txt, features.txt, features_info.txt, README.txt

3b. Each of the 'test' & 'train' folders contain a sub-folder, 'Inertial Signals' which are not used.

3c. Useful Files .  The files that will be used to load data are listed as follows:

    * test/subject_test.txt
    * test/X_test.txt
    * test/y_test.txt
    * train/subject_train.txt
    * train/X_train.txt
    * train/y_train.txt

3d. Identifiers.   The data is available in the 'X_train.txt' & 'X_test.txt' files. The variable names are available in the 'features.txt' file with 'subject' & 'activity' being the main variables. Other aspects are as follows:-

    * Values of Variable 'Activity' consist of data from “Y_train.txt” and “Y_test.txt”
    * Values of Variable 'Subject' consist of data from “subject_train.txt” and subject_test.txt"
    * Values of Variable 'Features' consist of data from “X_train.txt” and “X_test.txt”
    * Names of Variable 'Features' comes  from “features.txt”
    * Levels of Varible 'Activity' comes from “activity_labels.txt”
    
3e. Activity, Subject and Features are used as part of descriptive variable names for data in data frame.

#### 4. Process to create the 'Tidy' dataset

      4a.Get Data - Download the raw dataset file in the data folder. 
      4b.Unzip the file. Unzipping creates the folder 'UCI HAR Dataset'. 
      4c.Read data from  files into variables
          
          * Read Activity files
          * Read Subject files
          * Read Features files
      
      4d.Merge the training and test sets to create a single new dataset. Concatenating data tables by rows        using rbind()
      4e.Set names for variables of tables created in step 4a.
      4f.Read the Features table using 'features.txt'. 
      4g.Set names for variable V2 of 'FeaturesNames' table
      4h.Merge columns to get data frame Data from all tables by coloumn binding date from subject & activity       using cbind().
      4i.Extracts the measurements on mean and standard deviation for each observation
      4j.Subset Name of Features which have measurements on the mean and standard deviation 
      4k.Subset data frame Data by selected Features names
      4l. Name the activities in the data set Using descriptive activity names by reading       
      'activity_labesl.txt'
      4m.Factorize the Variable 'activity' in the 'MainData' Data frame using descriptive activity names
      4n.Label the dataset with descriptive variable names
      4o.Create a second, tidy data set which will have the average of each variable for each activity and  
      each subject.

#### 5. Description of 'run_analysis.R'

    5a. The R script merges the training and the test sets to create one data set with target variables.

    5b. It binds the following filesfrom the train set by columns to a table that contains, the human    
    subject, the activity performed and the values of the features. :-

        * UCI HAR Dataset/train/subject_train.txt
        * UCI HAR Dataset/train/X_train.txt
        * UCI HAR Dataset/train/y_train.txt.

    5c. It binds the files, from the test set by columns to a table that contains, the human subject, the 
    activity performed and the values of the features.

        * UCI HAR Dataset/test/subject_test.txt
        * UCI HAR Dataset/test/X_test.txt
        * UCI HAR Dataset/test/y_test.txt.

    5d. Binds the data frames created for test and train set into one large dataset by rows.

    5e. Extracts only the measurements on the mean and standard deviation for each measurement.
    5f. Finds the target features, which are the features with measurements about mean and standard    
    deviation, and extracts them as well as those that indicate the 'subject' and 'activity' and creates a 
    new data table only with the target variables.
    5g. Uses descriptive activity names to name the activities in the data set.
    5h. Replaces the variable about activity, that contains integers from 1 to 6, with a factor based on 
    levels and labels contained in the 'activity_labels' data file.
    5i. Appropriately labels the data set with target variables with descriptive names.
    5j. Extracts the target variable names from 'features.txt'.
    5k. Creates a new tidy dataset with the appropriate labels for the variable names.
    5l. Group the tidy data table created in step 4, by 'subject' and 'activity'.
    5m. Summarizes each variable to find the average for the grouped values.
    5n. Writes the data in a text file in the present working director.

#### 6. Reproducing the Dataset

    6a.   The data is available from the links given in section 2 of the codebook. The environment used to       create the dataset is as follows:-
    
          platform       x86_64-w64-mingw32          
          arch           x86_64                      
          os             mingw32                     
          system         x86_64, mingw32             
          status                                     
          major          4                           
          minor          0.2                         
          year           2020                        
          month          06                          
          day            22                          
          svn rev        78730                       
          language       R                           
          version.string R version 4.0.2 (2020-06-22)
          nickname       Taking Off Again
          
#### 7. Licence 

The following is a copy-paste from the 'README.txt' of the original data set. Please use.

Use of this dataset in publications must be acknowledged by referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.