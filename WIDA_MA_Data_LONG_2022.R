########################################################################################
###
### Data preparation code for 2022 Access
### Data extracted from completed analyses by KF
###
########################################################################################


### Load Packages

require(data.table)
require(foreign)
require(SGP)


### Load Data

WIDA_MA_Data_LONG_2022 <- as.data.table(read.spss("Data/Base_Files/ACCESS22_long.sav", to.data.frame=TRUE))


### Select out variables
variables.to.keep.old <- c("sasid", "grade", "ss_level", "ss_ss", "mode")
variable.names.new <- c("ID", "GRADE", "ACHIEVEMENT_LEVEL_ORIGINAL", "SCALE_SCORE", "TEST_MODE")
WIDA_MA_Data_LONG_2022 <- WIDA_MA_Data_LONG_2022[,..variables.to.keep.old]
setnames(WIDA_MA_Data_LONG_2022, variable.names.new)

### Clean up data

WIDA_MA_Data_LONG_2022[,GRADE:=as.character(GRADE)]
WIDA_MA_Data_LONG_2022[,ACHIEVEMENT_LEVEL_ORIGINAL:=as.character(ACHIEVEMENT_LEVEL_ORIGINAL)]
WIDA_MA_Data_LONG_2022[,ACHIEVEMENT_LEVEL:=paste("WIDA Level", strhead(ACHIEVEMENT_LEVEL_ORIGINAL, 1))]
WIDA_MA_Data_LONG_2022[,TEST_MODE:=as.factor(TEST_MODE)]
levels(WIDA_MA_Data_LONG_2022$TEST_MODE) <- c("Mixed", "Online", "Paper")
WIDA_MA_Data_LONG_2022[,CONTENT_AREA:="READING"]
WIDA_MA_Data_LONG_2022[,VALID_CASE:="VALID_CASE"]
WIDA_MA_Data_LONG_2022[,YEAR:="2022"]

### Check for duplicates 
setkey(WIDA_MA_Data_LONG_2022, VALID_CASE, CONTENT_AREA, YEAR, ID)
#table(duplicated(WIDA_MA_Data_LONG_2022, by=c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID"))) ### NONE


### Save data

save(WIDA_MA_Data_LONG_2022, file="Data/WIDA_MA_Data_LONG_2022.Rdata")
