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

data <-
    data %>%
    mutate(
        time = strftime(data$Time, "%H:%M:%S"),
        days = wday(Date, label = TRUE)
    )

# strftime(data$Time[2], "%H:%M:%S")

# To show date and time in the axis you can use function axis.POSIXct:
  
# plot(data, xaxt="n")
# axis.POSIXct(side=1, at=cut(data$time, "days"), format="%m/%d") 
# You can control where the ticks fall with at (as for regular functionaxis 
# except here it is to be provided with objects of class POSIXct) and control 
# how they will appear with format.