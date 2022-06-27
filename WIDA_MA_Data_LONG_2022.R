########################################################################################
###
### Data preparation code for 2022 Access
### Data extracted from completed analyses by KF
###
########################################################################################


### Load Packages

require(data.table)


### Load Data

load("Data/Base_Files/WIDA_MA_Data_LONG_2022.Rdata")


### Select out variables
variables.to.keep <- c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID", "GRADE", "ACHIEVEMENT_LEVEL_ORIGINAL", "SCALE_SCORE", "TEST_MODE", "ACHIEVEMENT_LEVEL")
WIDA_MA_Data_LONG_2022 <- WIDA_MA_Data_LONG_2022[,..variables.to.keep]

### Clean up data

levels(WIDA_MA_Data_LONG_2022$TEST_MODE) <- c("Mixed", "Online", "Paper", "Paper", "Mixed")

### Check for duplicates 
#table(duplicated(WIDA_MA_Data_LONG_2022, by=c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID"))) ### NONE


### Save data

save(WIDA_MA_Data_LONG_2022, file="Data/WIDA_MA_Data_LONG_2022.Rdata")
