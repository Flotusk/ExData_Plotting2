NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC.2 <- SCC[, c(1,4,7,8,9,10)]
SCC.3 <- SCC.2[grep("Coal", SCC.2$EI.Sector), ]
SCC.4 <- SCC.3[1:89, ]

DF1 <- merge(NEI, SCC.4, by = "SCC")
##DF2 <- aggregate(Emissions ~ SCC.Level.Two + year, data = DF1, FUN = sum) 
DF2 <- aggregate(scale(Emissions) ~ SCC.Level.Two + year, data = DF1, FUN = sum)

colnames(DF2) <- c("Type", "Year", "Emissions")

library(ggplot2)
png(file = "Plot4a.png")
Final.DF <- ggplot(data = DF2, aes(x = Year, y = Emissions, group = Type, color = Type)) + geom_line() + geom_point() + ggtitle("Coal Combustion-Related Sources of PM2.5 Emissions\n in US from 1999 to 2008") + ylab("Emissions in Tons")
print(Final.DF)
dev.off()