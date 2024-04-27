devtools::load_all()

data("allweather")
library("dplyr")
extract_time_series(53878, "2010-01-01", "2019-02-02")

devtools::document()
#Rd files will not appear until we write Roxygen comments in R files

#devtools::test()
