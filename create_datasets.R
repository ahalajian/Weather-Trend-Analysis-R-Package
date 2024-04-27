# making data
all_column_names <- c("WBANNO", "LST_DATE", "CRX_VN", "LONGITUDE", "LATITUDE", "T_DAILY_MAX", "T_DAILY_MIN", "T_DAILY_MEAN", "T_DAILY_AVG", "P_DAILY_CALC", "SOLARAD_DAILY", "SUR_TEMP_DAILY_TYPE", "SUR_TEMP_DAILY_MAX", "SUR_TEMP_DAILY_MIN", "SUR_TEMP_DAILY_AVG", "RH_DAILY_MAX", "RH_DAILY_MIN", "RH_DAILY_AVG", "SOIL_MOISTURE_5_DAILY", "SOIL_MOISTURE_10_DAILY", "SOIL_MOISTURE_20_DAILY", "SOIL_MOISTURE_50_DAILY", "SOIL_MOISTURE_100_DAILY", "SOIL_TEMP_5_DAILY", "SOIL_TEMP_10_DAILY", "SOIL_TEMP_20_DAILY", "SOIL_TEMP_50_DAILY", "SOIL_TEMP_100_DAILY")

relevant_col_names <- c("WBANNO", "LST_DATE", "CRX_VN", "LONGITUDE", "LATITUDE", "T_DAILY_MAX", "T_DAILY_MIN", "T_DAILY_MEAN", "T_DAILY_AVG", "P_DAILY_CALC", "SOLARAD_DAILY")

data <- data.frame()
for (year in 2000:2024){
  folder_name <- paste("CRND0103-202404080750/", year, sep = "")

  #list.files gets all files in that folder
  for (file_name in list.files(folder_name)){

    file_path <- paste(folder_name, file_name, sep ="/")

    #obtaining state and station name from the file name
    station_name <- strsplit(file_name, "-|\\.")[[1]][3]
    state <- strsplit(file_name, "-|\\.|_")[[1]][3]

    individual_data <- read.table(file_path, col.names = all_column_names)

    individual_data <- individual_data[, relevant_col_names]

    individual_data <- cbind(individual_data, station_name, state)

    data <- rbind(data, individual_data )

  }
}
data

#cleaning data
data$LST_DATE <- as.Date(as.character(data[["LST_DATE"]]), format = "%Y%m%d") #formatting data
data <- replace(data, data == -9999 | data == -99, NA) #replacing missing with NA

#save data as r data file
save(data, file = "allweather.RData")
