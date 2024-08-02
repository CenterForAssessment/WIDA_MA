########################################################################################
###
### Data preparation code for 2019 Access
###
########################################################################################


### Load Packages

require(data.table)


### Load Data

load("Data/Base_Files/WIDA_MA_Data_LONG.Rdata")


### Subset 2019

WIDA_MA_Data_LONG_2019 <- WIDA_MA_Data_LONG[YEAR=="2019"]


### Save data

save(WIDA_MA_Data_LONG_2019, file="Data/WIDA_MA_Data_LONG_2019.Rdata")
