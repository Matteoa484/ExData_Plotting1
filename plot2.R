library(readr)
library(lubridate)
library(dplyr)


# read file and parse cols

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


# merge date/time and keep cols needed

data <- 
    data %>%
    mutate(date_time = ymd_hms(paste(Date, Time))) %>%
    select(date_time, Global_active_power)


# filter for dates

start <- ymd_hms("2007-02-01 00:00:00")
end <- ymd_hms("2007-02-02 23:59:00")
data <- data[data$date_time >= start & data$date_time <= end, ]


# draw timeserie

png(file = "plot2.png", width = 480, height = 480)

with(
    data, 
    plot(date_time, 
         Global_active_power, 
         type = "l", 
         xlab = "", 
         ylab = "Global Active Power (kilowatts)"
    )
)

dev.off()