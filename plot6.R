#Load data into R
setwd('C:\\Users\\C018313\\Desktop\\Rweekly\\Coursera\\EDAProject\\Data')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Load packages to use
library(dplyr)
library(ggplot2)

df3<-merge(NEI, SCC, by.x = 'SCC', by.y = 'SCC')
#6.Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips=="06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?
#Los Angeles County has the greater change over time
df7<-df3%>%filter(fips=='24510'| fips=='06037')%>%
  filter(grepl('.*mobile.*',SCC.Level.One, ignore.case=T)& grepl('.*vehicle.*',SCC.Level.Two, ignore.case=T))%>%
  group_by(year,fips)%>%summarise(emission = sum(Emissions))
windows()
ggplot(df7,aes(year, emission, label=round(emission,0)))+geom_line()+geom_text()+facet_grid(.~fips)
dev.copy(png, "plot6.png")
dev.off()
