########################################################################################
###
### Data preparation code for 2023 Access
### Data extracted from completed analyses by KF
###
########################################################################################


### Load Packages

require(data.table)
require(foreign)
require(SGP)


### Load Data

#WIDA_MA_Data_LONG_2023 <- as.data.table(read.spss("Data/Base_Files/ACCESS23_long.sav", to.data.frame=TRUE))
WIDA_MA_Data_LONG_2023 <- as.data.table(read.spss("Data/Base_Files/ACCESS2023_with imputed scores trim for Damian.sav", to.data.frame=TRUE))

### Select out variables
variables.to.keep.old <- c("adminyear", "SASID", "yrsinmass", "Grade", "gradecluster2", "overallss", "overalllevel")
variable.names.new <- c("YEAR", "ID", "YEARS_IN_MA", "GRADE", "GRADE_CLUSTER", "SCALE_SCORE", "ACHIEVEMENT_LEVEL_ORIGINAL")
WIDA_MA_Data_LONG_2023 <- WIDA_MA_Data_LONG_2023[,..variables.to.keep.old]
setnames(WIDA_MA_Data_LONG_2023, variable.names.new)

### Clean up data
WIDA_MA_Data_LONG_2023[,GRADE:=as.factor(GRADE)]
setattr(WIDA_MA_Data_LONG_2023$GRADE, "levels", c(as.character(1:12), "0"))
WIDA_MA_Data_LONG_2023[,GRADE:=as.character(GRADE)]
WIDA_MA_Data_LONG_2023[,GRADE_CLUSTER:=as.factor(GRADE_CLUSTER)]
setattr(WIDA_MA_Data_LONG_2023$GRADE_CLUSTER, "levels", c("1-2", "3-5", "6-8", "9-12", "0"))
WIDA_MA_Data_LONG_2023[,ACHIEVEMENT_LEVEL_ORIGINAL:=as.character(ACHIEVEMENT_LEVEL_ORIGINAL)]
WIDA_MA_Data_LONG_2023[!is.na(ACHIEVEMENT_LEVEL_ORIGINAL), ACHIEVEMENT_LEVEL_ORIGINAL:=strhead(paste0(ACHIEVEMENT_LEVEL_ORIGINAL, ".0"), 3)]
WIDA_MA_Data_LONG_2023[!is.na(ACHIEVEMENT_LEVEL_ORIGINAL), ACHIEVEMENT_LEVEL:=paste("WIDA Level", strhead(ACHIEVEMENT_LEVEL_ORIGINAL, 1))]
WIDA_MA_Data_LONG_2023[,CONTENT_AREA:="READING"]
WIDA_MA_Data_LONG_2023[,VALID_CASE:="VALID_CASE"]
WIDA_MA_Data_LONG_2023[,YEAR:="2023"]

### Change NA scale scores to invalid cases
WIDA_MA_Data_LONG_2023[is.na(SCALE_SCORE), VALID_CASE:="INVALID_CASE"]
WIDA_MA_Data_LONG_2023[SCALE_SCORE >= 900, VALID_CASE:="INVALID_CASE"]

### Check for duplicates 
setkey(WIDA_MA_Data_LONG_2023, VALID_CASE, CONTENT_AREA, YEAR, ID)
#table(duplicated(WIDA_MA_Data_LONG_2023, by=c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID"))) ### NONE

### Save data

save(WIDA_MA_Data_LONG_2023, file="Data/WIDA_MA_Data_LONG_2023.Rdata")
