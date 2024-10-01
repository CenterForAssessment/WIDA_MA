#######################################################################################################
###
### Script to run 2024 analyses
### STEP 1: Percentiles (cohort and baseline referenced)
### STEP 2: Projections (cohort and baseline referenced/lagged and current) using adjusted grades
###
#######################################################################################################

### Load packages
require(SGP)
require(data.table)
require(SGPmatrices)
options(error=recover)

### Load Data
load("Data/WIDA_MA_SGP_23.Rdata")
load("Data/WIDA_MA_Data_LONG_2024.Rdata")

###   Add single-cohort baseline matrices to SGPstateData
SGPstateData <- SGPmatrices::addBaselineMatrices("WIDA_MA", "2024")

### STEP 1: Run analyses to calculate SGPs
WIDA_MA_SGP <- updateSGP(
  what_sgp_object=WIDA_MA_SGP_23,
  with_sgp_data_LONG=WIDA_MA_Data_LONG_2024,
  steps=c("prepareSGP", "analyzeSGP", "combineSGP"),
  sgp.percentiles=TRUE,
  sgp.projections=FALSE,
  sgp.projections.lagged=FALSE,
  sgp.percentiles.baseline=TRUE,
  sgp.projections.baseline=FALSE,
  sgp.projections.lagged.baseline=FALSE,
  get.cohort.data.info=TRUE,
  #parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4, GA_PLOTS=1, SG_PLOTS=1))); Helps "speed things up" - can throw issues with windows; not necessary
  save.intermediate.results=FALSE)

### STEP 2: Run analyses to calculate projections (swapping GRADE and GRADE_ADJUSTED)
setnames(WIDA_MA_SGP@Data, c("GRADE", "GRADE_ADJUSTED"), c("GRADE_ADJUSTED", "GRADE"))

WIDA_MA_SGP <- abcSGP(
  sgp_object=WIDA_MA_SGP,
  steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
  years="2024",
  sgp.percentiles=FALSE,
  sgp.projections=TRUE,
  sgp.projections.lagged=TRUE,
  sgp.percentiles.baseline=FALSE,
  sgp.projections.baseline=TRUE,
  sgp.projections.lagged.baseline=TRUE,
  sgp.target.scale.scores=TRUE)
  #parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4, GA_PLOTS=1, SG_PLOTS=1))); Helps "speed things up" - can throw issues with windows; not necessary

setnames(WIDA_MA_SGP@Data, c("GRADE", "GRADE_ADJUSTED"), c("GRADE_ADJUSTED", "GRADE"))

### Save SGP object 
save(WIDA_MA_SGP, file="Data/WIDA_MA_SGP.Rdata")

### Create formatted output 
WIDA_MA_Formatted_Output_2024 <- copy(WIDA_MA_SGP@Data[YEAR=="2024"])

### Convert CURRENT SCALE_SCORE_TARGETS to PROFICIENCY_TARGETS
WIDA_MA_Formatted_Output_2024[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_5_YEAR_PROJ_YEAR_1_CURRENT:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](as.character(as.numeric(GRADE)+1), ceiling(SCALE_SCORE_SGP_TARGET_BASELINE_5_YEAR_PROJ_YEAR_1_CURRENT))]
WIDA_MA_Formatted_Output_2024[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_4_YEAR_PROJ_YEAR_1_CURRENT:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](as.character(as.numeric(GRADE)+1), ceiling(SCALE_SCORE_SGP_TARGET_BASELINE_4_YEAR_PROJ_YEAR_1_CURRENT))]
WIDA_MA_Formatted_Output_2024[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_3_YEAR_PROJ_YEAR_1_CURRENT:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](as.character(as.numeric(GRADE)+1), ceiling(SCALE_SCORE_SGP_TARGET_BASELINE_3_YEAR_PROJ_YEAR_1_CURRENT))]
WIDA_MA_Formatted_Output_2024[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_2_YEAR_PROJ_YEAR_1_CURRENT:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](as.character(as.numeric(GRADE)+1), ceiling(SCALE_SCORE_SGP_TARGET_BASELINE_2_YEAR_PROJ_YEAR_1_CURRENT))]
WIDA_MA_Formatted_Output_2024[, PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_1_YEAR_PROJ_YEAR_1_CURRENT:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](as.character(as.numeric(GRADE)+1), ceiling(SCALE_SCORE_SGP_TARGET_BASELINE_1_YEAR_PROJ_YEAR_1_CURRENT))]

### Select CURRENT PROFICIENCY_TARGETS based upon YEARS_IN_MASS
WIDA_MA_Formatted_Output_2024[YEARS_IN_MA==1, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_5_YEAR_PROJ_YEAR_1_CURRENT]
WIDA_MA_Formatted_Output_2024[YEARS_IN_MA==2, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_4_YEAR_PROJ_YEAR_1_CURRENT]
WIDA_MA_Formatted_Output_2024[YEARS_IN_MA==3, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_3_YEAR_PROJ_YEAR_1_CURRENT]
WIDA_MA_Formatted_Output_2024[YEARS_IN_MA==4, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_2_YEAR_PROJ_YEAR_1_CURRENT]
WIDA_MA_Formatted_Output_2024[YEARS_IN_MA>=5, ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=4.2]

### Select CURRENT SGP_TARGETS based upon YEARS_IN_MASS
WIDA_MA_Formatted_Output_2024[YEARS_IN_MA==1, ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_5_YEAR_CURRENT]
WIDA_MA_Formatted_Output_2024[YEARS_IN_MA==2, ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_4_YEAR_CURRENT]
WIDA_MA_Formatted_Output_2024[YEARS_IN_MA==3, ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_3_YEAR_CURRENT]
WIDA_MA_Formatted_Output_2024[YEARS_IN_MA==4, ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_2_YEAR_CURRENT]
WIDA_MA_Formatted_Output_2024[YEARS_IN_MA>=5, ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_1_YEAR_CURRENT]

### Define variables in final file
variables.to.keep <- c("ID", "CONTENT_AREA", "YEAR", "GRADE", "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_ORIGINAL", "SCALE_SCORE", "SGP_BASELINE", "ACCOUNTABILITY_SGP_TARGET_CURRENT", "ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT", "YEARS_IN_MA")
WIDA_MA_Formatted_Output_2024 <- WIDA_MA_Formatted_Output_2024[VALID_CASE=="VALID_CASE", ..variables.to.keep]

### Save results
save(WIDA_MA_Formatted_Output_2024, file="Data/WIDA_MA_Formatted_Output_2024.Rdata")