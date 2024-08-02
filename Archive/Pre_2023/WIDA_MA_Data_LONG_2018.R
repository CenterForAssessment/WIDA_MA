########################################################################################
###
### Data preparation code for 2018 Access
###
########################################################################################


### Load Packages

require(data.table)


### Load Data

load("Data/Base_Files/WIDA_MA_Data_LONG_2018.Rdata")


### Save data

save(WIDA_MA_Data_LONG_2018, file="Data/WIDA_MA_Data_LONG_2018.Rdata")
