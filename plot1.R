
plot1 <- function(){

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
  
  png(filename = "plot1.png", height = 480, width = 480)
  
  hist(power_data$Global_active_power, 
       xlab = "Global Active Power (kilowatts)", 
       ylim = c(0,1200), 
       main="Global Active Power", 
       col = "red")
  
  dev.off()
}
