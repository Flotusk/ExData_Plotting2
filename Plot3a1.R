NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
Baltimore <- NEI[NEI$fips == "24510", ]
Agro <- aggregate(Emissions ~ type + year, data = Baltimore, FUN = sum) 

library(ggplot2)

png(file = "Plot3a1.png")
Final.plot <- ggplot(data = Agro, aes(x = year, y = Emissions, group = type, color = type)) + geom_line() + geom_point() + ggtitle("Total PM2.5 Emissions in Baltimore from 1999 to 2008") + ylab("Emissions in Tons")
print(Final.plot)
dev.off()