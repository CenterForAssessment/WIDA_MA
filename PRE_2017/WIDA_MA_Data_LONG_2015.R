########################################################################################
###
### Data preparation code for 2015 Access
###
########################################################################################


getwd()  
setwd ("H:/Student Assessment/Student Assessment Files/WIDA/2015/SGP") #ID working directory
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

WIDA_MA_Data_LONG_2015 <- read.spss("SGP 2015 Wide 6.8.2015.sav", to.data.frame=TRUE)


### clean up data

names(WIDA_MA_Data_LONG_2015) <- toupper(names(WIDA_MA_Data_LONG_2015))

names(WIDA_MA_Data_LONG_2015) <- c("YEAR", "ID", "LAST_NAME", "FIRST_NAME", "MIDDLE_NAME", "DOB", "GRADE", "GRADESPAN", "SS_LEVEL", "SCALE_SCORE")

WIDA_MA_Data_LONG_2015 <- subset(WIDA_MA_Data_LONG_2015, select=c("YEAR", "ID", "LAST_NAME", "FIRST_NAME", "GRADE", "SCALE_SCORE"))
WIDA_MA_Data_LONG_2015$YEAR <- as.character(WIDA_MA_Data_LONG_2015$YEAR)
WIDA_MA_Data_LONG_2015$ID <- as.character(WIDA_MA_Data_LONG_2015$ID)
WIDA_MA_Data_LONG_2015$GRADE <- as.character(WIDA_MA_Data_LONG_2015$GRADE)
WIDA_MA_Data_LONG_2015 <- subset(WIDA_MA_Data_LONG_2015, GRADE!="  ")

WIDA_MA_Data_LONG_2015$LAST_NAME[WIDA_MA_Data_LONG_2015$LAST_NAME=="                  "] <- NA
WIDA_MA_Data_LONG_2015$FIRST_NAME[WIDA_MA_Data_LONG_2015$FIRST_NAME=="              "] <- NA
WIDA_MA_Data_LONG_2015$LAST_NAME <- droplevels(WIDA_MA_Data_LONG_2015$LAST_NAME)
WIDA_MA_Data_LONG_2015$FIRST_NAME <- droplevels(WIDA_MA_Data_LONG_2015$FIRST_NAME)
levels(WIDA_MA_Data_LONG_2015$LAST_NAME) <- sapply(levels(WIDA_MA_Data_LONG_2015$LAST_NAME), capwords)
levels(WIDA_MA_Data_LONG_2015$FIRST_NAME) <- sapply(levels(WIDA_MA_Data_LONG_2015$FIRST_NAME), capwords)

WIDA_MA_Data_LONG_2015$GRADE <- as.factor(WIDA_MA_Data_LONG_2015$GRADE)
levels(WIDA_MA_Data_LONG_2015$GRADE) <- c("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12")
WIDA_MA_Data_LONG_2015$GRADE <- as.character(WIDA_MA_Data_LONG_2015$GRADE)


WIDA_MA_Data_LONG_2015$VALID_CASE <- "VALID_CASE"
WIDA_MA_Data_LONG_2015$CONTENT_AREA <- "READING"

### Reorder 

WIDA_MA_Data_LONG_2015 <- as.data.table(WIDA_MA_Data_LONG_2015)
setcolorder(WIDA_MA_Data_LONG_2015, c(7,8,1,2,3,4,5,6))


### Save data

save(WIDA_MA_Data_LONG_2015, file="Data/WIDA_MA_Data_LONG_2015.Rdata")
