# ECO365_FinalProject_MattGaynor
Super Smash Brothers Ultimate Data Website


# Description
The intent of this project was to create an interactive and visually pleasing website in `R` using the `shiny` package, with the data deriving from a popular franchise - Super Smash Brothers. 

More specifically, all of the numbers present are based on the most recent game from the franchise - *Super Smash Brothers Ultimate*

The first tab of the website is focused on a *general overview* of *key statistics*, followed by other tabs relating to more in depth analyses of specific technical data.

The purpose of each tab is to give its reader a better idea of what character is best to play as based on their own fighting style and/or preferences.

# Folder Content
The `MASTERWEBSITE.R`,`Smash R Stats.R`, and `smash_df.csv` script/csv files are essential to download if you are trying to run this website on your own machine. The `MASTERWEBSITE.R` script file contains all of the front-end and back-end code that compiles the website. 

The `Smash R Stats.R` script file contains code that pulls data/webscrapes numbers from an online source. 

In short, the `MASTERWEBSITE.R` script file is dependent on the `Smash R Stats.R` script file. 

The `smash_df.csv` is a dataframe created from the `Smash R Stats.R` script file. The `MASTERWEBSITE.R` script file utilizes this `smash_df.csv` file as well. 

All other files within the folder are jpeg/png image files that are called on in the `MASTERWEBSITE.R` script file. However, the website will still compile if these images are not downloaded (the website just won't look great).



# How Can I Run This?
There are two ways in which it is possible to view this website:

1) Download the folder/all of the files stored under *R Final Files* folder within this repository. Once said files have been downloaded, store them inside the same folder on your machine. Next open that folder, double click `MASTERWEBSITE.R` this should automatically start Rstudio with the script file preloaded. One last step is to make sure you have installed all packages used within this script file AND set your current working directory to the folder you created/stored all of the files.

2) (The easier step/you do not need to download anything) Click this link: https://gaynmf.shinyapps.io/ECO_365_Final_Project_Matthew_Gaynor/?_ga=2.240281027.1303197376.1670358623-566613146.1670358623  - It will automatically launch the website in your browser. 


