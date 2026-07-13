###########################################################################
### Prepare WIDA_MA 2026 data for analysis
###########################################################################

# Load packages
library(data.table)
library(SGP)

# Load data
load("Data/Base_Files/WIDA_MA_Data_LONG_2026.Rdata")

# Parameters
variables.to.keep <-  c("VALID_CASE", "CONTENT_AREA", "YEAR", "GRADE", "ID", "SCALE_SCORE", "ACHIEVEMENT_LEVEL", "YEARS_IN_MA", "GRADE_CLUSTER", "ACHIEVEMENT_LEVEL_ORIGINAL", "GRADE_ADJUSTED")

# Set column order
setcolorder(WIDA_MA_Data_LONG_2026, variables.to.keep)

# Correct ACHIEVEMENT_LEVEL
WIDA_MA_Data_LONG_2026[ACHIEVEMENT_LEVEL_ORIGINAL %in% c("5.0", "5.1", "5.2", "5.3", "5.4", "5.5", "5.6", "5.7", "5.8", "5.9"), ACHIEVEMENT_LEVEL:="WIDA Level 5.0"]
WIDA_MA_Data_LONG_2026[ACHIEVEMENT_LEVEL_ORIGINAL %in% c("6.0"), ACHIEVEMENT_LEVEL:="WIDA Level 6.0"]

# Create SCALE_SCORE_OLD variable (2026 NEW scale -> OLD scale)
WIDA_MA_Data_LONG_2026[VALID_CASE == "VALID_CASE", SCALE_SCORE_OLD_SCALE := SGPstateData[["WIDA"]][["SGP_Configuration"]][["ss_2026_scale_score_transformation_function"]](GRADE, SCALE_SCORE, direction = "NEW_to_OLD")]

# Setkey and save data
setkey(WIDA_MA_Data_LONG_2026, VALID_CASE, CONTENT_AREA, YEAR, GRADE, ID)
save(WIDA_MA_Data_LONG_2026, file = "Data/WIDA_MA_Data_LONG_2026.Rdata")
