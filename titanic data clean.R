titanic <- read.csv(file.choose()) # prompts you to choose the file to be loaded 
attach(titanic)

summary(titanic)

#replace embarked empty values with S
levels(titanic$embarked)

summary(titanic$embarked)

levels(titanic$embarked)[levels(titanic$embarked)==""] <- "S"

#fixed it
summary(titanic$embarked)

#calculate mean of Age and use to popluate the missing values

summary(titanic$age)

#calculate mean of a column that has NAs
mean_age <- mean(titanic$age, na.rm = TRUE)  

#replace NAs with mean age
titanic$age[is.na(titanic$age)] <- mean_age   

#replace missing boat values with None
levels(titanic$boat)
summary(titanic$boat)

titanic$boat
levels(titanic$boat)[levels(titanic$boat)==""] <- "None"


#Cabin numbers -- yes it is useful to indicate survival.
#Create new column has_cabin_number, 1 = cabin number, 0 = no cabin number


#solution: pattern match using grepl
install.packages("grepl")

titanic$has_cabin_number <- ifelse((grepl("[A-Z]", titanic$cabin)),1,0)

#final document
summary(titanic)

