#Load data into R
setwd('C:\\Users\\C018313\\Desktop\\Rweekly\\Coursera\\EDAProject\\Data')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Load packages to use
library(dplyr)
library(ggplot2)

#2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
#In general PM2.5 emission decreased from 1999 to 2008, but it had an increase from 2002 to 2005
#Filter records for Baltimore City, Maryland, then summarise emission by year
df2<-NEI%>%filter(fips=='24510')%>%group_by(year)%>%summarise(emission = sum(Emissions))
windows()
plot(df2$year, df2$emission, type = 'l', xlab='Year', ylab='Total Emissions', xlim = c(1999,2009))
text(df2$year, df2$emission, labels = round(df2$emission,0), adj = c(0.2,0.2))
dev.copy(png, 'plot2.png')
dev.off()
