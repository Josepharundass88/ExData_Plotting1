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


# Plot 1 Starts
png("datos/plot1.png", width = 480, height = 480)

hist(cargardatos$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

dev.off()