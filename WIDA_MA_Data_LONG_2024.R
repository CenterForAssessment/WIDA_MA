###########################################################################
### Prepare WIDA_MA 2024 data for analysis
###########################################################################

# Load packages
library(data.table)

# Load data
load("Data/Base_Files/WIDA_MA_SGP_24.Rdata")

# Parameters
variables.to.keep <-  c("VALID_CASE", "CONTENT_AREA", "YEAR", "GRADE", "ID", "SCALE_SCORE", "ACHIEVEMENT_LEVEL", "YEARS_IN_MA", "GRADE_CLUSTER", "ACHIEVEMENT_LEVEL_ORIGINAL", "GRADE_ADJUSTED")

# Subset data
WIDA_MA_Data_LONG_2024 <- WIDA_MA_SGP@Data[YEAR == "2024", variables.to.keep, with = FALSE]

# Setkey and save data
setkey(WIDA_MA_Data_LONG_2024, VALID_CASE, CONTENT_AREA, YEAR, GRADE, ID)
save(WIDA_MA_Data_LONG_2024, file = "Data/WIDA_MA_Data_LONG_2024.Rdata")