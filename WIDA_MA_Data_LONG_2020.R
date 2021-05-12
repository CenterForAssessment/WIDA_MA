########################################################################################
###
### Data preparation code for 2020 Access
###
########################################################################################


### Load Packages

require(data.table)


### Load Data

load("Data/Base_Files/WIDA_MA_Data_LONG.Rdata")


### Subset 2020

WIDA_MA_Data_LONG_2020 <- WIDA_MA_Data_LONG[YEAR=="2020"]


### Save data

save(WIDA_MA_Data_LONG_2020, file="Data/WIDA_MA_Data_LONG_2020.Rdata")
