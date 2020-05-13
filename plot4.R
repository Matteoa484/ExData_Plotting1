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
  select(-c(Date, Time))


# filter dates ------------------------------------------------------------

start <- ymd_hms("2007-02-01 00:00:00")
end <- ymd_hms("2007-02-02 23:59:00")
data <- data[data$date_time >= start & data$date_time <= end, ]


# create and save plots ---------------------------------------------------

# call file device
png(file = "plot4.png", width = 480, height = 480)

# set graphical parameters
par(mfcol = c(2, 2))

# 1st plot
with(data, 
     plot(date_time, 
          Global_active_power, 
          type = "l", 
          xlab = "", 
          ylab = "Global Active Power"
      )
)

# 2nd plot
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
       bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1
)

# 3rd plot
with(data, 
     plot(date_time, 
          Voltage, 
          type = "l", 
          col = "black", 
          xlab = "datetime", 
          ylab = "Voltage"
     )
)

# 4th plot
with(data, 
     plot(date_time, 
          Global_reactive_power, 
          type = "l", 
          col = "black", 
          xlab = "datetime", 
          ylab = "Global_active_power"
    )
)

# close file device
dev.off()
