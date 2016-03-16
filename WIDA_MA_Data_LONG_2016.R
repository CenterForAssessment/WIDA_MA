########################################################################################
###
### Data preparation code for 2016 Access
###
########################################################################################


getwd()  
setwd ("H:/Student Assessment/Student Assessment Files/WIDA/2016/SGP") #ID working directory
getwd()
dir()
memory.limit(100000)
memory.size(max=T) 
memory.size(max=F) 


### Load Packages

require(SGP)
require(foreign)
require(data.table)


### Load Data

WIDA_MA_Data_LONG_2016 <- read.spss("SGP 2016 Wide 6.8.2016.sav", to.data.frame=TRUE)


### clean up data

names(WIDA_MA_Data_LONG_2016) <- toupper(names(WIDA_MA_Data_LONG_2016))

names(WIDA_MA_Data_LONG_2016) <- c("YEAR", "ID", "LAST_NAME", "FIRST_NAME", "MIDDLE_NAME", "DOB", "GRADE", "GRADESPAN", "SS_LEVEL", "SCALE_SCORE")

WIDA_MA_Data_LONG_2016 <- subset(WIDA_MA_Data_LONG_2016, select=c("YEAR", "ID", "LAST_NAME", "FIRST_NAME", "GRADE", "SCALE_SCORE"))
WIDA_MA_Data_LONG_2016$YEAR <- as.character(WIDA_MA_Data_LONG_2016$YEAR)
WIDA_MA_Data_LONG_2016$ID <- as.character(WIDA_MA_Data_LONG_2016$ID)
WIDA_MA_Data_LONG_2016$GRADE <- as.character(WIDA_MA_Data_LONG_2016$GRADE)
WIDA_MA_Data_LONG_2016 <- subset(WIDA_MA_Data_LONG_2016, GRADE!="  ")

WIDA_MA_Data_LONG_2016$LAST_NAME[WIDA_MA_Data_LONG_2016$LAST_NAME=="                  "] <- NA
WIDA_MA_Data_LONG_2016$FIRST_NAME[WIDA_MA_Data_LONG_2016$FIRST_NAME=="              "] <- NA
WIDA_MA_Data_LONG_2016$LAST_NAME <- droplevels(WIDA_MA_Data_LONG_2016$LAST_NAME)
WIDA_MA_Data_LONG_2016$FIRST_NAME <- droplevels(WIDA_MA_Data_LONG_2016$FIRST_NAME)
levels(WIDA_MA_Data_LONG_2016$LAST_NAME) <- sapply(levels(WIDA_MA_Data_LONG_2016$LAST_NAME), capwords)
levels(WIDA_MA_Data_LONG_2016$FIRST_NAME) <- sapply(levels(WIDA_MA_Data_LONG_2016$FIRST_NAME), capwords)

WIDA_MA_Data_LONG_2016$GRADE <- as.factor(WIDA_MA_Data_LONG_2016$GRADE)
levels(WIDA_MA_Data_LONG_2016$GRADE) <- c("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12")
WIDA_MA_Data_LONG_2016$GRADE <- as.character(WIDA_MA_Data_LONG_2016$GRADE)


WIDA_MA_Data_LONG_2016$VALID_CASE <- "VALID_CASE"
WIDA_MA_Data_LONG_2016$CONTENT_AREA <- "READING"

### Reorder 

WIDA_MA_Data_LONG_2016 <- as.data.table(WIDA_MA_Data_LONG_2016)
setcolorder(WIDA_MA_Data_LONG_2016, c(7,8,1,2,3,4,5,6))


### Save data

save(WIDA_MA_Data_LONG_2016, file="Data/WIDA_MA_Data_LONG_2016.Rdata")
