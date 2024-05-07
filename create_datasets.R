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

station_data <- station_data[station_data$station_name != "AK_Huslia_27_W",]
# Note: in our station_data, we make a new column for each unique station name.
# There are two stations that have the same id, AK_Huslia_27_E, and
# AK_Huslia_27_W. Station AK_Huslia_27_W only has one total
# observation on August 31, 2023, with NA's for all the values, so we thus
# remove it to not impact future analyses where we would double count values of
# AK_Huslia_27_E twice, as they share same station id


#cleaning data - formatting date and replacing missing with NA
daily_weather_data$LST_DATE <-
  as.Date(as.character(daily_weather_data[["LST_DATE"]]), format = "%Y%m%d")
daily_weather_data <-
  replace(daily_weather_data, daily_weather_data == -9999 | daily_weather_data == -99, NA)
daily_weather_data <- daily_weather_data[daily_weather_data$station_name != "AK_Huslia_27_W",]

#save data as RData file
save(station_data, file = "station_data.RData")
save(daily_weather_data, file = "daily_weather_data.RData")

# Note: in our station_data, we make a new column for each unique station name.
# There are two stations that have the same id, AK_Huslia_27_E, and
# AK_Huslia_27_W. We include them as two separate observations, but ultimately
# it shouldn't impact future analyses because AK_Huslia_27_W only has one total
# observation on August 31, 2023, with NA's for all the values.
