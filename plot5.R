#Load data into R
setwd('C:\\Users\\C018313\\Desktop\\Rweekly\\Coursera\\EDAProject\\Data')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Load packages to use
library(dplyr)
library(ggplot2)

df3<-merge(NEI, SCC, by.x = 'SCC', by.y = 'SCC')
#5.How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
#Emissions from motor vehicle sources decreased from 1999 to 2008 in Baltimore City
#Filter records for Baltimore City and from mobile 
df6<-df3%>%filter(fips=='24510', grepl('.*mobile.*',df3$SCC.Level.One, ignore.case=T), grepl('.*vehicle.*',df3$SCC.Level.Two, ignore.case=T))%>%
  group_by(year)%>%summarise(emission = sum(Emissions))
windows()
ggplot(df6,aes(year, emission))+geom_line()
dev.copy(png, "plot5.png")
dev.off()
