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
          Time = col_time(format = ""),
          Global_active_power = col_double(),
          Global_reactive_power = col_double(),
          Voltage = col_double(),
          Global_intensity = col_double(),
          Sub_metering_1 = col_double(),
          Sub_metering_2 = col_double(),
          Sub_metering_3 = col_double()
        )
    )

# select dates 2007-02-01 and 2007-02-02

data <- 
    data %>% 
    filter(Date >= as.Date("2007-02-01", "%Y-%m-%d") & Date <= as.Date("2007-02-02", "%Y-%m-%d"))

# draw histogram

png(file = "plot1.png")

with(
  data, 
  hist(
    Global_active_power, 
    xlab = "Global Active Power (kilowatts)", 
    main = "Global Active Power",
    col = "red"
  )
)

dev.off()