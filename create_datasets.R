# making data
all_column_names <- c("WBANNO", "LST_DATE", "CRX_VN", "LONGITUDE", "LATITUDE",
  "T_DAILY_MAX", "T_DAILY_MIN", "T_DAILY_MEAN", "T_DAILY_AVG", "P_DAILY_CALC",
  "SOLARAD_DAILY", "SUR_TEMP_DAILY_TYPE", "SUR_TEMP_DAILY_MAX",
  "SUR_TEMP_DAILY_MIN", "SUR_TEMP_DAILY_AVG", "RH_DAILY_MAX", "RH_DAILY_MIN",
  "RH_DAILY_AVG", "SOIL_MOISTURE_5_DAILY", "SOIL_MOISTURE_10_DAILY",
  "SOIL_MOISTURE_20_DAILY", "SOIL_MOISTURE_50_DAILY", "SOIL_MOISTURE_100_DAILY",
  "SOIL_TEMP_5_DAILY", "SOIL_TEMP_10_DAILY", "SOIL_TEMP_20_DAILY",
  "SOIL_TEMP_50_DAILY", "SOIL_TEMP_100_DAILY")

relevant_col_names <- c("WBANNO", "LST_DATE", "CRX_VN", "LONGITUDE", "LATITUDE",
                        "T_DAILY_MAX", "T_DAILY_MIN", "T_DAILY_MEAN",
                        "T_DAILY_AVG", "P_DAILY_CALC", "SOLARAD_DAILY")

daily_weather_data <- data.frame()

station_data <- data.frame()

for (year in 2000:2024){
  folder_name <- paste("CRND0103-202404080750/", year, sep = "")

  #list.files gets all files in that folder
  for (file_name in list.files(folder_name)){

    file_path <- paste(folder_name, file_name, sep ="/")

    #obtaining state and station name from the file name
    station_name <- strsplit(file_name, "-|\\.")[[1]][3]
    state <- strsplit(file_name, "-|\\.|_")[[1]][3]

    yr_station_data <- read.table(file_path, col.names = all_column_names)

    yr_station_data <- yr_station_data[, relevant_col_names]

    yr_station_data <- cbind(yr_station_data, station_name, state)

    daily_weather_data <- rbind(daily_weather_data, yr_station_data )

    #creating station data
    station_row <- c(yr_station_data$WBANNO[1], station_name, state,
                     yr_station_data$LONGITUDE[1], yr_station_data$LATITUDE[1])
    station_data <- rbind(station_data, station_row)
  }
}

# CLEANING STATION DATA
colnames(station_data) <- c("WBANNO", "station_name", "state", "LONGITUDE", "LATITUDE")
station_data <- unique(station_data) #since stations have multiple files for multiple years
row.names(station_data) <- NULL


#cleaning data - formatting date and replacing missing with NA
daily_weather_data$LST_DATE <-
  as.Date(as.character(daily_weather_data[["LST_DATE"]]), format = "%Y%m%d")
daily_weather_data <-
  replace(daily_weather_data, daily_weather_data == -9999 | data == -99, NA)

#save data as RData file
save(station_data, file = "station_data.RData")
save(daily_weather_data, file = "daily_weather_data.RData")
