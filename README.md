# Final project for the Getting and Cleaning Data Course of Johns Hopkins University

## Files included in this repository:
- README.md: to describe and mentions important things about this repository.  
- CodeBook.md: Mentions definitions of variables  
- run_analysis.R: the entire R script which build the whole project and create the final data set.  

This project is splitted in 5 sections:
1. PREPARE ENVIRONMENT: These sections create directories where files will be stored and download and install packages used along the project.
2. GETTING THE DATA: In this section, all data is downloaded from the internet and stored in folders.  
3. INITIALIZING PATH VARIABLES: In this section, path variables pointing to data are created. This makes it easier to know where data is stored.  
4. LOADING DATA: This section loads all data from path variables creating data frame variables in local.  
5. DATA WRANGLING: The last but no least section covers all questions requested by the course project. Data frames are merged, splitted, and filters in order to get 2 data frames, one data frame for mean a std variable and another for averaging the previous data frame based on activities.   


The last section focuses on developing all the requests. For this purpose, data in test and train folders are merged into *df_x* and *df_y*. Also, labels in df_x are setted with *df_features*, which is data frame with all the variables name from *features.txt*. Additionally, files in Initial Signal are merged, but they are not necessary being merged. After that, in *df_X_mean* and *df_X_std* is stored all data about mean and std measures with the help of *grep* function. In *df_y* is merged with *df_features* to get all names for each activity. Finally, with the help of *dplyer* package, the entire data set *df_total* (which includes *df_X_mean*, *df_X_std*, *df_y*) is grouped by activity and later each column is reduced based on activity too.

Some facts in raw data:
- Some variables such as fBodyBodyAccJerkMag_mean have a typo. They have to be in the form fBodyAccJerkMag_mean() without double Body.
- Files in the Initial Signal folder are not really neccessary for this project.
- Some variables are defined with *meanFreq*, these variables are not considered in our final data set. Only variables with mean without Freq.