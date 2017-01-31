NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Baltimore <- NEI[NEI$fips == "24510", ]
total <- tapply(Baltimore$Emissions, Baltimore$year, FUN = sum)
library(reshape2)
dt <- melt(total)
colnames(dt) <- c("Year", "Emissions")
png(file = "Plot2a.png")
plot(dt$Year, dt$Emissions/1000, type = "l", xlab = "Year", ylab = "Emissions in Thousands of Tons", main = "Total PM2.5 Emissions in Baltimore, MD from 1999 to 2008")
fit1 <- lm(Emissions/1000 ~ Year, data = dt)
abline(fit1, lty = "dashed")
dev.off()
