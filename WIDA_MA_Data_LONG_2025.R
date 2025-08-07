###########################################################################
### Prepare WIDA_MA 2025 data for analysis
###########################################################################

# Load packages
library(data.table)

# Load data
load("Data/Base_Files/WIDA_MA_SGP_25.Rdata")

# Parameters
variables.to.keep <-  c("VALID_CASE", "CONTENT_AREA", "YEAR", "GRADE", "ID", "SCALE_SCORE", "ACHIEVEMENT_LEVEL", "YEARS_IN_MA", "GRADE_CLUSTER", "ACHIEVEMENT_LEVEL_ORIGINAL", "GRADE_ADJUSTED")

# Subset data
WIDA_MA_Data_LONG_2025 <- WIDA_MA_SGP@Data[YEAR == "2025", variables.to.keep, with = FALSE]

# Correct ACHIEVEMENT_LEVEL
WIDA_MA_Data_LONG_2025[ACHIEVEMENT_LEVEL_ORIGINAL %in% c("4.2", "4.3", "4.4", "4.5", "4.6", "4.7", "4.8", "4.9"), ACHIEVEMENT_LEVEL:="WIDA Level 4.2"]

# Setkey and save data
setkey(WIDA_MA_Data_LONG_2025, VALID_CASE, CONTENT_AREA, YEAR, GRADE, ID)
save(WIDA_MA_Data_LONG_2025, file = "Data/WIDA_MA_Data_LONG_2025.Rdata")
