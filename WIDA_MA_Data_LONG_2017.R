########################################################################################
###
### Data preparation code for 2017 Access
###
########################################################################################


#setwd ("H:/Student Assessment/Student Assessment Files/WIDA/2017/SGP") #ID working directory


### Load Packages

require(SGP)
require(foreign)
require(data.table)


### Load Data

WIDA_MA_Data_LONG <- as.data.table(read.spss("Data/Base_Files/Access16_17.sav", to.data.frame=TRUE))


### clean up data

setnames(WIDA_MA_Data_LONG, toupper(names(WIDA_MA_Data_LONG)))
setnames(WIDA_MA_Data_LONG, c("ID", "LAST_NAME", "FIRST_NAME", "MIDDLE_NAME", "DOB", "GRADE", "SS_LEVEL", "SCALE_SCORE", "GRADESPAN", "YEAR", "TEST_MODE"))

WIDA_MA_Data_LONG <- subset(WIDA_MA_Data_LONG, select=c("YEAR", "ID", "LAST_NAME", "FIRST_NAME", "GRADE", "SCALE_SCORE", "TEST_MODE"))
WIDA_MA_Data_LONG$YEAR <- as.character(WIDA_MA_Data_LONG$YEAR)
WIDA_MA_Data_LONG$ID <- as.character(WIDA_MA_Data_LONG$ID)
levels(WIDA_MA_Data_LONG$GRADE) <- c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "0")
WIDA_MA_Data_LONG$GRADE <- as.character(WIDA_MA_Data_LONG$GRADE)

levels(WIDA_MA_Data_LONG$LAST_NAME) <- sapply(levels(WIDA_MA_Data_LONG$LAST_NAME), capwords)
levels(WIDA_MA_Data_LONG$FIRST_NAME) <- sapply(levels(WIDA_MA_Data_LONG$FIRST_NAME), capwords)

WIDA_MA_Data_LONG$VALID_CASE <- "VALID_CASE"
WIDA_MA_Data_LONG$CONTENT_AREA <- "READING"

### Reorder

setcolorder(WIDA_MA_Data_LONG, c(8,9,1,2,3,4,5,6,7))


### Save data

save(WIDA_MA_Data_LONG, file="Data/WIDA_MA_Data_LONG.Rdata")
