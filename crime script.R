# Load libraries and global parameters
packages =  c("Hmisc", "ggplot2", "dplyr", "tidyr", "data.table", 'corrplot', 'gridExtra', 'forecast', 'tseries', 'TSA', 'tibble', 'TTR', 'xts', 'dygraphs', 'assertthat')

my.install <- function(pkg, ...){
  if (!(pkg %in% installed.packages()[,1])) {
    install.packages(pkg)
  }
  return (library(pkg, ...))
}

purrr::walk(packages, my.install, character.only = TRUE, warn.conflicts = FALSE)

#read data
crime.data = read.csv(file="../Documents/Computational Statistics/Group Project Crime/crime_report.csv")

#Overview of data
summary(crime.data)
str(crime.data)

#Data Cleaning

crime.data[!complete.cases(crime.data),]
nrow(crime.data[!complete.cases(crime.data),])

# remove the column month_reported
crime.data = select(crime.data, -c(months_reported))

crime.data = na.omit(crime.data)
# 

# Graph plot

library(directlabels)
ggplot( data = crime.data, aes(x=report_year, y=total, group=agency_jurisdiction, color=agency_jurisdiction)) +
    geom_line() + 
    geom_dl(aes(label=agency_jurisdiction), method="last.points") 

