plot4 <- function(){
  
  power_data <- read.table("household_power_consumption.txt", 
                           sep = ";" , 
                           header = FALSE, 
                           na.strings = "?", 
                           col.names = c("Date", "Time", "Global_active_power", 
                                         "Global_reactive_power", "Voltage", 
                                         "Global_intensity", "Sub_metering_1", 
                                         "Sub_metering_2", "Sub_metering_3"), 
                           skip = 66637, 
                           nrows = 2880, 
                           stringsAsFactors = FALSE)
  
  power_data$combined_date <- paste(power_data$Date, power_data$Time)
  
  power_data$combined_date <- lapply(power_data$combined_date, 
                                     function(x) {
                                       strptime(x, 
                                                format="%d/%m/%Y %H:%M:%S")
                                     })
  
  png(filename = "plot4.png", height = 480, width = 480)
  
  
  hist(power_data$Global_active_power, 
       xlab = "Global Active Power (kilowatts)", 
       ylim = c(0,1200), 
       col = "red")
  
  plot(power_data$Voltage, xlab="datetime",
       ylab = "voltage", ylim = c(0,6), 
        xaxt="n", xlab="", type = "l")
  
  axis(1, at = c(1, length(power_data$Date)/2, 
                 length(power_data$Date)), 
       labels = c("Thu", "Fri", "Sat"), 
       las = 0)
  
  plot(power_data$combined_date, power_data$Sub_metering_1, xaxt="n", 
       ylab = "Energy sub metering", 
       xlab= "", type = "l")
  with(power_data, lines(power_data$combined_date, power_data$Sub_metering_2, 
                         col="red"))
  with(power_data, lines(power_data$combined_date, power_data$Sub_metering_3,  
                         col="blue"))
  
  legend("topright", pch = "-", col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         lwd = 3)
  
  axis(1, at = c(1, length(power_data$Date)/2, 
                 length(power_data$Date)), 
       labels = c("Thu", "Fri", "Sat"), 
       las = 0)
  
  dev.off()
}

