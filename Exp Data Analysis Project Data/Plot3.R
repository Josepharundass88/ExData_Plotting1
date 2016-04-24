setwd("E:/Data Science/R Working Directory")

# Reading data from file

datos <- "datos"

if(!file.exists(datos)){
  dir.create(datos)
} 

archiv1 <- paste(getwd(), "/datos/household_power_consumption.txt", sep = "")

archivo <- paste(getwd(), "/datos/exdata-data-household_power_consumption.zip", sep = "")

if(!file.exists(archiv1)){
  unzip(archivo, list = FALSE, overwrite = FALSE, exdir = datos)
}

datos <- "datos/household_power_consumption.txt"

cargardatos <- read.table(datos, header=TRUE, sep=";", colClasses=c("character", "character", rep("numeric",7)), na="?")

cargardatos$Time <- strptime(paste(cargardatos$Date, cargardatos$Time), "%d/%m/%Y %H:%M:%S")

cargardatos$Date <- as.Date(cargardatos$Date, "%d/%m/%Y")

fechas <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")

cargardatos <- subset(cargardatos, Date %in% fechas)


# Plot 3 Starts
png("graficos/plot3.png", width = 480, height = 480)
plot(cargardatos$Time, cargardatos$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(cargardatos$Time, cargardatos$Sub_metering_2, type="l", col="red")
lines(cargardatos$Time, cargardatos$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=2, col=c("black", "red", "blue"))
dev.off()
