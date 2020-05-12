library(readr)
library(lubridate)

raw_data <-
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

