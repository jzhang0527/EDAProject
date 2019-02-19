#Load data into R
setwd('C:\\Users\\C018313\\Desktop\\Rweekly\\Coursera\\EDAProject\\Data')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Load packages to use
library(dplyr)
library(ggplot2)

df3<-merge(NEI, SCC, by.x = 'SCC', by.y = 'SCC')
#4.Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
#Emission from coal combustion related sources decreased, especially from 2005 to 2008
#Filter records from coal combustion-related sources, then summarise by year
df5<-df3%>%filter(grepl('.*coal.*',df3$Short.Name, ignore.case=T), grepl('.*combustion.*',df3$SCC.Level.One, ignore.case = T))%>%
  group_by(year)%>%summarise(emission = sum(Emissions))
windows()
ggplot(df5,aes(year, emission))+geom_line()
dev.copy(png, "plot4.png")
dev.off()
