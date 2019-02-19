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

#2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
#In general PM2.5 emission decreased from 1999 to 2008, but it had an increase from 2002 to 2005
#Filter records for Baltimore City, Maryland, then summarise emission by year
df2<-NEI%>%filter(fips=='24510')%>%group_by(year)%>%summarise(emission = sum(Emissions))
plot(df2$year, df2$emission, type = 'l', xlab='Year', ylab='Total Emissions', xlim = c(1999,2009))
text(df2$year, df2$emission, labels = round(df2$emission,0), adj = c(0.2,0.2))

#3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008?
#Non point and Onroad sources show decrease in emissions, 
#while Nonroad and Point show increase from 1999 to 2005 and then decrease from 2005 to 2008
#Merge NEI with SCC to get source type
df3<-merge(NEI, SCC, by.x = 'SCC', by.y = 'SCC')
df4<-df3%>%filter(fips=='24510', Data.Category != 'Event')%>%group_by(year, Data.Category)%>%summarise(emission = sum(Emissions))
ggplot(df4, aes(year, emission))+geom_line()+facet_wrap(~Data.Category, ncol = 2)

#4.Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
#Emission from coal combustion related sources decreased, especially from 2005 to 2008
#Filter records from coal combustion-related sources, then summarise by year
df5<-df3%>%filter(grepl('.*coal.*',df3$Short.Name, ignore.case=T), grepl('.*combustion.*',df3$SCC.Level.One, ignore.case = T))%>%
  group_by(year)%>%summarise(emission = sum(Emissions))
ggplot(df5,aes(year, emission))+geom_line()

#5.How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
#Emissions from motor vehicle sources decreased from 1999 to 2008 in Baltimore City
#Filter records for Baltimore City and from mobile 
df6<-df3%>%filter(fips=='24510', grepl('.*mobile.*',df3$SCC.Level.One, ignore.case=T), grepl('.*vehicle.*',df3$SCC.Level.Two, ignore.case=T))%>%
  group_by(year)%>%summarise(emission = sum(Emissions))
ggplot(df6,aes(year, emission))+geom_line()

#6.Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips=="06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?
#Los Angeles County has the greater change over time
df7<-df3%>%filter(fips=='24510'| fips=='06037')%>%
  filter(grepl('.*mobile.*',SCC.Level.One, ignore.case=T)& grepl('.*vehicle.*',SCC.Level.Two, ignore.case=T))%>%
  group_by(year,fips)%>%summarise(emission = sum(Emissions))
ggplot(df7,aes(year, emission, label=round(emission,0)))+geom_line()+geom_text()+facet_grid(.~fips)











