########################################################################################
###
### Data preparation code for 2016 Access
###
########################################################################################


#setwd ("H:/Student Assessment/Student Assessment Files/WIDA/2016/SGP") #ID working directory


### Load Packages

require(SGP)
require(foreign)
require(data.table)


### Load Data

WIDA_MA_Data_LONG_2016 <- as.data.table(read.spss("Data/Base_Files/Access16.sav", to.data.frame=TRUE))


### clean up data

setnames(WIDA_MA_Data_LONG_2016, toupper(names(WIDA_MA_Data_LONG_2016)))
setnames(WIDA_MA_Data_LONG_2016, c("ID", "LAST_NAME", "FIRST_NAME", "MIDDLE_NAME", "DOB", "GRADE", "SS_LEVEL", "SCALE_SCORE", "GRADESPAN", "YEAR", "TEST_MODE"))

WIDA_MA_Data_LONG_2016 <- subset(WIDA_MA_Data_LONG_2016, select=c("YEAR", "ID", "LAST_NAME", "FIRST_NAME", "GRADE", "SCALE_SCORE", "TEST_MODE"))
WIDA_MA_Data_LONG_2016$YEAR <- as.character(WIDA_MA_Data_LONG_2016$YEAR)
WIDA_MA_Data_LONG_2016$ID <- as.character(WIDA_MA_Data_LONG_2016$ID)
levels(WIDA_MA_Data_LONG_2016$GRADE) <- c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "0")
WIDA_MA_Data_LONG_2016$GRADE <- as.character(WIDA_MA_Data_LONG_2016$GRADE)

levels(WIDA_MA_Data_LONG_2016$LAST_NAME) <- sapply(levels(WIDA_MA_Data_LONG_2016$LAST_NAME), capwords)
levels(WIDA_MA_Data_LONG_2016$FIRST_NAME) <- sapply(levels(WIDA_MA_Data_LONG_2016$FIRST_NAME), capwords)

WIDA_MA_Data_LONG_2016$VALID_CASE <- "VALID_CASE"
WIDA_MA_Data_LONG_2016$CONTENT_AREA <- "READING"

### Reorder

setcolorder(WIDA_MA_Data_LONG_2016, c(8,9,1,2,3,4,5,6,7))


### Save data

save(WIDA_MA_Data_LONG_2016, file="Data/WIDA_MA_Data_LONG_2016.Rdata")
