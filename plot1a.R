NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

total <- tapply(NEI$Emissions, NEI$year, FUN = sum)
library(reshape2)
dt <- melt(total)
colnames(dt) <- c("Year", "Emissions")

png(file = "plot1a.png")
plot(dt$Year, dt$Emissions/1000000, type = "l", xlab = "Year", ylab = "Emissions in Millions of Tons", main = "Total PM2.5 Emissions in US from 1999 to 2008")
fit1 <- lm(Emissions/1000000 ~ Year, data = dt)
abline(fit1, lty = "dashed")
dev.off()