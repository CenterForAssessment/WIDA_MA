######
### Create formatted output from WIDA_MA_SGP with 2023 accountability indicators
######

### Load packages
require(data.table)
require(SGP)

### Load SGP object
load("Data/WIDA_MA_SGP.Rdata")

### Copy 2023 results
WIDA_MA_Formatted_Output_2023 <- copy(WIDA_MA_SGP@Data[YEAR=="2023"])

### Convert LAGGED SCALE_SCORE_TARGETS to PROFICIENCY_TARGETS
WIDA_MA_Formatted_Output_2023[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_5_YEAR_PROJ_YEAR_1:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](GRADE, SCALE_SCORE_SGP_TARGET_BASELINE_5_YEAR_PROJ_YEAR_1)]
WIDA_MA_Formatted_Output_2023[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_4_YEAR_PROJ_YEAR_1:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](GRADE, SCALE_SCORE_SGP_TARGET_BASELINE_4_YEAR_PROJ_YEAR_1)]
WIDA_MA_Formatted_Output_2023[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_3_YEAR_PROJ_YEAR_1:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](GRADE, SCALE_SCORE_SGP_TARGET_BASELINE_3_YEAR_PROJ_YEAR_1)]
WIDA_MA_Formatted_Output_2023[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_2_YEAR_PROJ_YEAR_1:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](GRADE, SCALE_SCORE_SGP_TARGET_BASELINE_2_YEAR_PROJ_YEAR_1)]
WIDA_MA_Formatted_Output_2023[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_1_YEAR_PROJ_YEAR_1:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](GRADE, SCALE_SCORE_SGP_TARGET_BASELINE_1_YEAR_PROJ_YEAR_1)]
WIDA_MA_Formatted_Output_2023[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_0_YEAR_PROJ_YEAR_1:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](GRADE, SCALE_SCORE_SGP_TARGET_BASELINE_0_YEAR_PROJ_YEAR_1)]

### Convert CURRENT SCALE_SCORE_TARGETS to PROFICIENCY_TARGETS
WIDA_MA_Formatted_Output_2023[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_5_YEAR_PROJ_YEAR_1_CURRENT:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](as.character(as.numeric(GRADE)+1), SCALE_SCORE_SGP_TARGET_BASELINE_5_YEAR_PROJ_YEAR_1_CURRENT)]
WIDA_MA_Formatted_Output_2023[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_4_YEAR_PROJ_YEAR_1_CURRENT:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](as.character(as.numeric(GRADE)+1), SCALE_SCORE_SGP_TARGET_BASELINE_4_YEAR_PROJ_YEAR_1_CURRENT)]
WIDA_MA_Formatted_Output_2023[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_3_YEAR_PROJ_YEAR_1_CURRENT:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](as.character(as.numeric(GRADE)+1), SCALE_SCORE_SGP_TARGET_BASELINE_3_YEAR_PROJ_YEAR_1_CURRENT)]
WIDA_MA_Formatted_Output_2023[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_2_YEAR_PROJ_YEAR_1_CURRENT:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](as.character(as.numeric(GRADE)+1), SCALE_SCORE_SGP_TARGET_BASELINE_2_YEAR_PROJ_YEAR_1_CURRENT)]
WIDA_MA_Formatted_Output_2023[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_1_YEAR_PROJ_YEAR_1_CURRENT:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](as.character(as.numeric(GRADE)+1), SCALE_SCORE_SGP_TARGET_BASELINE_1_YEAR_PROJ_YEAR_1_CURRENT)]

### Select LAGGED PROFICIENCY_TARGETS based upon YEARS_IN_MASS
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1==0, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_5_YEAR_PROJ_YEAR_1]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1==1, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_4_YEAR_PROJ_YEAR_1]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1==2, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_3_YEAR_PROJ_YEAR_1]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1==3, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_2_YEAR_PROJ_YEAR_1]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1==4, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_1_YEAR_PROJ_YEAR_1]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1>=5, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_0_YEAR_PROJ_YEAR_1]

### Select LAGGED SGP_TARGETS based upon YEARS_IN_MASS
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1==0, ACCOUNTABILITY_SGP_TARGET:=SGP_TARGET_BASELINE_5_YEAR]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1==1, ACCOUNTABILITY_SGP_TARGET:=SGP_TARGET_BASELINE_4_YEAR]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1==2, ACCOUNTABILITY_SGP_TARGET:=SGP_TARGET_BASELINE_3_YEAR]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1==3, ACCOUNTABILITY_SGP_TARGET:=SGP_TARGET_BASELINE_2_YEAR]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1==4, ACCOUNTABILITY_SGP_TARGET:=SGP_TARGET_BASELINE_1_YEAR]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1>=5, ACCOUNTABILITY_SGP_TARGET:=SGP_TARGET_BASELINE_0_YEAR]

### Select CURRENT PROFICIENCY_TARGETS based upon YEARS_IN_MASS
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA==0, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_5_YEAR_PROJ_YEAR_1_CURRENT]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA==1, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_4_YEAR_PROJ_YEAR_1_CURRENT]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA==2, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_3_YEAR_PROJ_YEAR_1_CURRENT]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA==3, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_2_YEAR_PROJ_YEAR_1_CURRENT]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA==4, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_1_YEAR_PROJ_YEAR_1_CURRENT]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA>=5, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=4.2]

### Select CURRENT SGP_TARGETS based upon YEARS_IN_MASS
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1==0, ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_5_YEAR_CURRENT]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1==1, ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_4_YEAR_CURRENT]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1==2, ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_3_YEAR_CURRENT]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1==3, ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_2_YEAR_CURRENT]
WIDA_MA_Formatted_Output_2023[YEARS_IN_MA-1>=4, ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_1_YEAR_CURRENT]


### Define variables in final file
variables.to.keep <- c("ID", "CONTENT_AREA", "YEAR", "GRADE", "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_ORIGINAL", "SCALE_SCORE", "ACCOUNTABILITY_SGP_TARGET_CURRENT", "ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT", "YEARS_IN_MA")
WIDA_MA_Formatted_Output_2023 <- WIDA_MA_Formatted_Output_2023[VALID_CASE=="VALID_CASE", ..variables.to.keep]


### Save results
save(WIDA_MA_Formatted_Output_2023, file="Data/WIDA_MA_Formatted_Output_2023.Rdata")