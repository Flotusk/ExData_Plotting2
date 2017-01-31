NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
Baltimore <- NEI[NEI$fips == "24510", ]

SCC.2 <- SCC[, c(1,4,7,8,9,10)]
SCC.3 <- SCC.2[grep("Highway Vehicles", SCC.2$SCC.Level.Two), ]


DF1 <- merge(Baltimore, SCC.3, by = "SCC")
DF2 <- aggregate(Emissions ~ SCC.Level.Two + year, data = DF1, FUN = sum) 
##DF2 <- aggregate(scale(Emissions) ~ SCC.Level.Two + year, data = DF1, FUN = sum)

colnames(DF2) <- c("Type", "Year", "Emissions")

library(ggplot2)
png(file = "Plot5a1.png")
Final.DF <- ggplot(data = DF2, aes(x = Year, y = Emissions, group = Type, color = Type)) + geom_line() + geom_point() + ggtitle("PM2.5 Emissions by Motor Vehicle Source Type\n in Baltimore from 1999 to 2008") + ylab("Emissions in Tons")
print(Final.DF)
dev.off()