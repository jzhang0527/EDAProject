#Load data into R
setwd('C:\\Users\\C018313\\Desktop\\Rweekly\\Coursera\\EDAProject\\Data')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Load packages to use
library(dplyr)
library(ggplot2)

#3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008?
#Non point and Onroad sources show decrease in emissions, 
#while Nonroad and Point show increase from 1999 to 2005 and then decrease from 2005 to 2008
#Merge NEI with SCC to get source type
df3<-merge(NEI, SCC, by.x = 'SCC', by.y = 'SCC')
df4<-df3%>%filter(fips=='24510', Data.Category != 'Event')%>%group_by(year, Data.Category)%>%summarise(emission = sum(Emissions))
windows()
ggplot(df4, aes(year, emission))+geom_line()+facet_wrap(~Data.Category, ncol = 2)
dev.copy(png, "plot3.png")
dev.off()
