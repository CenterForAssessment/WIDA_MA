########################################################################################
###
### Data preparation code for 2017 Access
###
########################################################################################


### Load Packages

require(SGP)
require(foreign)
require(data.table)


### Load Data

WIDA_MA_Data_LONG <- as.data.table(read.spss("Data/Base_Files/Access17_long.sav", to.data.frame=TRUE))


### clean up data

setnames(WIDA_MA_Data_LONG, toupper(names(WIDA_MA_Data_LONG)))
setnames(WIDA_MA_Data_LONG, c("ID", "LAST_NAME", "FIRST_NAME", "DOB", "GRADE", "ACHIEVEMENT_LEVEL_ORIGINAL", "SCALE_SCORE", "GRADESPAN", "YEAR", "TEST_MODE"))

WIDA_MA_Data_LONG <- subset(WIDA_MA_Data_LONG, select=c("YEAR", "ID", "GRADE", "ACHIEVEMENT_LEVEL_ORIGINAL", "SCALE_SCORE", "TEST_MODE"))
levels(WIDA_MA_Data_LONG$YEAR) <- c("2013", "2014", "2015", "2016", "2017")
WIDA_MA_Data_LONG$YEAR <- as.character(WIDA_MA_Data_LONG$YEAR)
WIDA_MA_Data_LONG$ID <- as.character(WIDA_MA_Data_LONG$ID)
levels(WIDA_MA_Data_LONG$GRADE) <- c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "0")
WIDA_MA_Data_LONG$GRADE <- as.character(WIDA_MA_Data_LONG$GRADE)
levels(WIDA_MA_Data_LONG$TEST_MODE) <- c("", "Mixed", "Online", "Paper")
WIDA_MA_Data_LONG[TEST_MODE=="", TEST_MODE:=NA]
WIDA_MA_Data_LONG[, TEST_MODE:=droplevels(TEST_MODE)]

WIDA_MA_Data_LONG$VALID_CASE <- "VALID_CASE"
WIDA_MA_Data_LONG$CONTENT_AREA <- "READING"


### Use only 2016 and 2017

WIDA_MA_Data_LONG <- subset(WIDA_MA_Data_LONG, YEAR %in% c("2016", "2017"))


### Reorder

setcolorder(WIDA_MA_Data_LONG, c(7,8,1,2,3,4,5,6))

### INVALIDATE/REMOVE MISSING SCALE SCORES

WIDA_MA_Data_LONG <- WIDA_MA_Data_LONG[!is.na(SCALE_SCORE)]

### Create ACHIEVEMENT_LEVEL variable

WIDA_MA_Data_LONG <- prepareSGP(WIDA_MA_Data_LONG)@Data

### Save data

save(WIDA_MA_Data_LONG, file="Data/WIDA_MA_Data_LONG.Rdata")
