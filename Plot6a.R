NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
LA.Balt <- NEI[NEI$fips %in% c("24510", "06037"), ]

SCC.2 <- SCC[, c(1,4,7,8,9,10)]
SCC.3 <- SCC.2[grep("Highway Vehicles", SCC.2$SCC.Level.Two), ]


DF1 <- merge(LA.Balt, SCC.3, by = "SCC")
DF2 <- aggregate(Emissions ~ SCC.Level.Two + fips + year, data = DF1, FUN = sum) 
##DF2 <- aggregate(scale(Emissions) ~ SCC.Level.Two + year, data = DF1, FUN = sum)

colnames(DF2) <- c("Type", "City", "Year", "Emissions")
DF2 <- replace(DF2, DF2 == "24510", "Baltimore")
DF2 <- replace(DF2, DF2 == "06037", "Los Angeles")

library(ggplot2)
png(file = "Plot6a.png")
Final.DF <- ggplot(data = DF2, aes(x = Year, y = Emissions, group = City, lty = City)) + 
geom_line(data = DF2[DF2$City == "Los Angeles", ], aes(x = Year, y = Emissions, group = Type, color = Type)) +
geom_line(data = DF2[DF2$City == "Baltimore", ], aes(x = Year, y = Emissions, group = Type, color = Type)) +
geom_point() + ggtitle("PM2.5 Emissions by Motor Vehicle Source Type\n in Baltimore and Los Angeles from 1999 to 2008") + ylab("Emissions in Tons")
print(Final.DF)
dev.off()
