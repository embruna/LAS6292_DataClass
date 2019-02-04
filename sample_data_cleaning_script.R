#=============================================================================================================#
# Script created by Emilio M. Bruna, embruna@ufl.edu for LAS 6291-Spring Semester 2019
# Script created in R version 3.5.1
# Sample code to load and clean raw data  

#=============================================================================================================#
library(tidyverse) #Data Manipulations + ggplot

############################################################################################################
### DATA LOADING
############################################################################################################


#########################################
#  Nest data import and selection
#########################################

# Use this to import the csv file if it is in a different folder (in this case the folder is called "data_raw" and it is inside an RStudio Project) 
raw.data<-read.csv("./data_raw/moz_example.csv", dec=".", header = TRUE, sep = ",", check.names=FALSE )

# Use this to import the csv file if it is in the working directory
raw.data<-read.csv("./data_raw/moz_example.csv", dec=".", header = TRUE, sep = ",", check.names=FALSE )


# CHANGE COLUMN NAMES

# what are the names of the columns?
colnames(raw.data)

# Change the ones in the improper format with the following command:  
# file.name <- rename(file.name, "new_name"="old name")

raw.data <- rename(raw.data, "wall_type" = "wall type")
raw.data <- rename(raw.data, "floor_type" = "floor type")

# Note that you can do multiple names at once 
# raw.data <- rename(raw.data, "floor_type" = "floor type","wall_type" = "wall type")
# Check again to see if they were changed
colnames(raw.data)

# CORRECT MISTAKES AND INCONSISTENCIES IN THE DATA
# These were the ones we found:
# mabatisloping<-mabati_sloping (it was recorded in two different ways)
# earth<-errth (spelled incorrectly)
# rooms "-99"<-NA (used a numerical code for missing data)

# THERE ARE OFTEN MULTIPLE WAYS TO DO THE SAME THING

# OPTION 1: if you are changing the level of a factor to another level already present in the column
levels(raw.data$roof_type)
raw.data$roof_type[raw.data$roof_type == "mabatisloping"] <- "mabati_sloping"
raw.data$roof_type<-droplevels(raw.data$roof_type)
levels(raw.data$roof_type)

levels(raw.data$floor_type)
raw.data$floor_type[raw.data$floor_type == "errth"] <- "earth"
raw.data$floor_type<-droplevels(raw.data$floor_type)
levels(raw.data$floor_type)

# OPTION 2: IOf you are adding a new level to the factor (unless you do this it will throw and error) 
#First add the new level
levels(raw.data$roof_type) <- c("grass", "mabati_sloping", "new level")
# then make the correction
levels(raw.data$roof_type)
raw.data$roof_type[raw.data$roof_type == "mabatisloping"] <- "new level"
# be sure to 'drop' the incorrect level.
raw.data$roof_type<-droplevels(raw.data$roof_type)
# now you can check to see what the results were
levels(raw.data$roof_type)

# OPTION 3
# if you want to do everything in OPTION 2 in one step (add a new level and make the correction):  
levels(raw.data$roof_type)[match("grass",levels(raw.data$roof_type))]<- "thatch"

# OPTION 4: Convert the data type in the column to 'character', make the change, then change back to factor. (don't have to add the new level, but takes a few extra steps), 
levels(raw.data$roof_type)
raw.data$floor_type<-as.character(raw.data$roof_type) # change to 'character'
raw.data$roof_type[raw.data$roof_type == "mabatisloping"] <- "mabati_sloping"   # make the chgange
raw.data$roof_type<-as.factor(raw.data$roof_type) # change back to factor 
raw.data$roof_type<-droplevels(raw.data$roof_type) # drop the old levels
levels(raw.data$roof_type) # double check to make sure it worked

levels(raw.data$floor_type)
raw.data$floor_type<-as.character(raw.data$floor_type)
raw.data$floor_type[raw.data$floor_type == "errth"] <- "earth"
raw.data$floor_type<-as.factor(raw.data$floor_type)
raw.data$floor_type<-droplevels(raw.data$floor_type)
levels(raw.data$floor_type)



# THESE ARE THE SAME OPTIONS FOR CODING DATA
levels(raw.data$floor_type)
raw.data$floor_type<-as.character(raw.data$floor_type)
raw.data$floor_type[raw.data$floor_type == "earth"] <- "ER"
raw.data$floor_type<-as.factor(raw.data$floor_type)
raw.data$floor_type<-droplevels(raw.data$floor_type)
levels(raw.data$floor_type)


levels(raw.data$floor_type)
raw.data$floor_type<-as.character(raw.data$floor_type)
raw.data$floor_type[raw.data$floor_type == "cement"] <- "CM"
raw.data$floor_type<-as.factor(raw.data$floor_type)
raw.data$floor_type<-droplevels(raw.data$floor_type)
levels(raw.data$floor_type)


# NOW ADD A COLUMN FOR "BARN" (remember, there was one cell that had an * to denote the rooms included those in a barn)

raw.data$barn<-NA
raw.data$barn[1:9]<-"no"
raw.data$barn[10]<-"yes"

levels(raw.data$barn)
str(raw.data$barn)
raw.data$barn<-as.factor(raw.data$barn)
levels(raw.data$barn)


#How about some summary of the data?
summary(raw.data)


#NOW SAVE THE CLEAN DATA

# you can save in the working directory
write_csv(raw.data,"CLEAN_DATA.csv")

# Or better still in the "data_clean" folder of your RStudio Project
write_csv(raw.data,"./data_raw/CLEAN_DATA.csv")





