########################################################################################
###
### Data preparation code for 2021 Access
### Data extracted from completed analyses by KF
###
########################################################################################


### Load Packages

require(data.table)


### Load Data

load("Data/Base_Files/WIDA_MA_Data_LONG_2021.Rdata")


### Select out variables
variables.to.keep <- c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID", "GRADE", "ACHIEVEMENT_LEVEL_ORIGINAL", "SCALE_SCORE", "TEST_MODE", "ACHIEVEMENT_LEVEL")
WIDA_MA_Data_LONG_2021 <- WIDA_MA_Data_LONG_2021[,..variables.to.keep]

### Clean up data

levels(WIDA_MA_Data_LONG_2021$TEST_MODE) <- c("Mixed", "Online", "Paper", "Paper", "Mixed")

### Check for duplicates 
#table(duplicated(WIDA_MA_Data_LONG_2021, by=c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID"))) ### NONE


### Save data

save(WIDA_MA_Data_LONG_2021, file="Data/WIDA_MA_Data_LONG_2021.Rdata")
