plot3 <- function(){
  
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
  
  combined_date <- paste(power_data$Date, power_data$Time)
  combined_date <- strptime(as.character(combined_date), format="%d/%m/%Y %H:%M:%S")
  power_data <- data.frame(combined_date = combined_date , power_data)
  
  png(filename = "plot3.png", height = 480, width = 480)
  
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

