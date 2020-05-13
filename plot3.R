library(readr)
library(lubridate)
library(dplyr)


# read file and parse cols ------------------------------------------------

data <-
  read_delim(
    "./raw_data/household_power_consumption.txt",
    delim = ";",
    na = "?",
    col_names = TRUE,
    col_types = cols(
      Date = col_date(format = "%d/%m/%Y"),
      Time = col_time(format = "%H:%M:%S"),
      Global_active_power = col_double(),
      Global_reactive_power = col_double(),
      Voltage = col_double(),
      Global_intensity = col_double(),
      Sub_metering_1 = col_double(),
      Sub_metering_2 = col_double(),
      Sub_metering_3 = col_double()
    )
  )


# merge date/time and drop unwanted cols ----------------------------------

data <- 
  data %>%
  mutate(date_time = ymd_hms(paste(Date, Time))) %>%
  select(date_time, Sub_metering_1, Sub_metering_2, Sub_metering_3)


# filter dates ------------------------------------------------------------

start <- ymd_hms("2007-02-01 00:00:00")
end <- ymd_hms("2007-02-02 23:59:00")
data <- data[data$date_time >= start & data$date_time <= end, ]


# create and save plot ----------------------------------------------------

# call file device
png(file = "plot3.png", width = 480, height = 480)

with(data, 
     plot(date_time, 
          Sub_metering_1, 
          type = "l", 
          col = "black", 
          xlab = "", 
          ylab = "Energy sub metering"
    )
)

with(data, lines(date_time, Sub_metering_2, type = "l", col = "red"))

with(data, lines(date_time, Sub_metering_3, type = "l", col = "blue"))

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1
)

# close file device
dev.off()
