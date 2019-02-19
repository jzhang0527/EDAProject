#Load data into R
setwd('C:\\Users\\C018313\\Desktop\\Rweekly\\Coursera\\EDAProject\\Data')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Load packages to use
library(dplyr)
library(ggplot2)

#1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# The total emission from PM2.5 decreased in the US from 1999 to 2008
#Summarise total PM2.5 emission by year
unique(NEI$Pollutant)
df1<-NEI%>%group_by(year)%>%summarise(emission = sum(Emissions))
windows()
plot(df1$year, df1$emission, type = 'l', xlab='Year', ylab='Total Emissions', xlim = c(1999,2009))
text(df1$year, df1$emission, labels = round(df1$emission,0), adj = c(0.2,0.2))
dev.copy(png, "plot1.png")
dev.off()
