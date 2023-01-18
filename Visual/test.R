library(tidyverse)

setwd('./app/')
datafile <- read.csv('cleandata.csv')
datafile$DMDEDUC3 <- factor(datafile$DMDEDUC3,
                            levels = 6:20,
                            labels = c(
                              paste(6:11, 'Grade', sep = ' '),
                              '12th Grade, No Diploma',
                              'High School Graduate',
                              'GED or Equivalent',
                              'More than high school',
                              'Less Than 9th Grade',
                              '9-11th Grade',
                              'High School Grad/GED or Equivalent',
                              'Some College or AA degree',
                              'College Grade or above'
                            ))
NameValue <- colnames(datafile)[c(3, 5:10)]
names(NameValue) <- c('Gender', 'Race', 'Birthplace', 'Citizen', 'Education Level', 'Marital Status', 'Family Size')

Data <- datafile[,c(3, 5:10, 4, 11)]
remove(datafile)

save.image(file = 'app.RData')
