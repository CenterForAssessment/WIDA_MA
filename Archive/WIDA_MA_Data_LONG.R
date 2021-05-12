########################################################################################
###
### Data preparation code for 2014 Access
###
########################################################################################

### Load Packages

require(SGP)
require(foreign)
require(data.table)


### Load Data

WIDA_MA_Data_LONG <- read.spss("Data/Base_Files/MEPA_ACCESS Long with Access Scaled scores_5.5.2014.sav", to.data.frame=TRUE)


### clean up data

names(WIDA_MA_Data_LONG) <- toupper(names(WIDA_MA_Data_LONG))

names(WIDA_MA_Data_LONG) <- c("YEAR", "ID", "LAST_NAME", "FIRST_NAME", "MIDDLE_NAME", "DOB", "GRADE", "GRADESPAN", "SS_LEVEL", "SCALE_SCORE")

WIDA_MA_Data_LONG <- subset(WIDA_MA_Data_LONG, select=c("YEAR", "ID", "LAST_NAME", "FIRST_NAME", "GRADE", "SCALE_SCORE"))
WIDA_MA_Data_LONG$YEAR <- as.character(WIDA_MA_Data_LONG$YEAR)
WIDA_MA_Data_LONG$ID <- as.character(WIDA_MA_Data_LONG$ID)
WIDA_MA_Data_LONG$GRADE <- as.character(WIDA_MA_Data_LONG$GRADE)
WIDA_MA_Data_LONG <- subset(WIDA_MA_Data_LONG, GRADE!="  ")

WIDA_MA_Data_LONG$LAST_NAME[WIDA_MA_Data_LONG$LAST_NAME=="                  "] <- NA
WIDA_MA_Data_LONG$FIRST_NAME[WIDA_MA_Data_LONG$FIRST_NAME=="              "] <- NA
WIDA_MA_Data_LONG$LAST_NAME <- droplevels(WIDA_MA_Data_LONG$LAST_NAME)
WIDA_MA_Data_LONG$FIRST_NAME <- droplevels(WIDA_MA_Data_LONG$FIRST_NAME)
levels(WIDA_MA_Data_LONG$LAST_NAME) <- sapply(levels(WIDA_MA_Data_LONG$LAST_NAME), capwords)
levels(WIDA_MA_Data_LONG$FIRST_NAME) <- sapply(levels(WIDA_MA_Data_LONG$FIRST_NAME), capwords)

WIDA_MA_Data_LONG$GRADE <- as.factor(WIDA_MA_Data_LONG$GRADE)
levels(WIDA_MA_Data_LONG$GRADE) <- c("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12")
WIDA_MA_Data_LONG$GRADE <- as.character(WIDA_MA_Data_LONG$GRADE)


WIDA_MA_Data_LONG$VALID_CASE <- "VALID_CASE"
WIDA_MA_Data_LONG$CONTENT_AREA <- "READING"

### Reorder 

WIDA_MA_Data_LONG <- as.data.table(WIDA_MA_Data_LONG)
setcolorder(WIDA_MA_Data_LONG, c(7,8,1,2,3,4,5,6))


### Save data

save(WIDA_MA_Data_LONG, file="Data/WIDA_MA_Data_LONG.Rdata")
