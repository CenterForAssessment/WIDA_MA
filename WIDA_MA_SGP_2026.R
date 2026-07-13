#######################################################################################################
###
### Script to run 2026 analyses
### STEP 1: Percentiles (cohort referenced) NOTE: No cohort referenced projections due to scale change
### STEP 2: Percentiles (baseline referenced) using 2026 scores mapped to OLD scale
### STEP 3: Projections (baseline referenced/lagged and current) using adjusted grades and 2026 scores mapped to OLD scale
###
#######################################################################################################

### Load packages
require(SGP)
require(data.table)
require(SGPmatrices)
options(error=recover)

### Load Data
load("Data/WIDA_MA_SGP.Rdata")
load("Data/WIDA_MA_Data_LONG_2026.Rdata")

###   Add single-cohort baseline matrices to SGPstateData
SGPstateData <- SGPmatrices::addBaselineMatrices("WIDA_MA", "2026")

### Define arguments
parallel.config = list(BACKEND = "MIRAI", WORKERS = list(PERCENTILES = 4, PROJECTIONS = 2, LAGGED_PROJECTIONS = 2, BASELINE_PERCENTILES = 4))
#parallel.config <- NULL  ### To turn off parallel processing

####################################################
### STEP 1: Run analyses to calculate SGPs
####################################################
WIDA_MA_SGP <- updateSGP(
  what_sgp_object=WIDA_MA_SGP,
  with_sgp_data_LONG=WIDA_MA_Data_LONG_2026,
  steps=c("prepareSGP", "analyzeSGP", "combineSGP"),
  sgp.percentiles=TRUE,
  sgp.projections=FALSE,
  sgp.projections.lagged=FALSE,
  sgp.percentiles.baseline=FALSE,
  sgp.projections.baseline=FALSE,
  sgp.projections.lagged.baseline=FALSE,
  get.cohort.data.info=TRUE,
  parallel.config=parallel.config,
  save.intermediate.results=FALSE)

####################################################
### STEP 2: Run analyses to calculate baseline referenced percentiles (swapping SCALE_SCORE and SCALE_SCORE_OLD_SCALE)
####################################################
WIDA_MA_SGP@Data[YEAR<"2026", SCALE_SCORE_OLD_SCALE:=SCALE_SCORE]
setnames(WIDA_MA_SGP@Data, c("SCALE_SCORE", "SCALE_SCORE_OLD_SCALE"), c("SCALE_SCORE_OLD_SCALE", "SCALE_SCORE"))

WIDA_MA_SGP <- abcSGP(
  sgp_object=WIDA_MA_SGP,
  steps=c("prepareSGP", "analyzeSGP", "combineSGP"),
  years="2026",
  sgp.percentiles=FALSE,
  sgp.projections=FALSE,
  sgp.projections.lagged=FALSE,
  sgp.percentiles.baseline=TRUE,
  sgp.projections.baseline=FALSE,
  sgp.projections.lagged.baseline=FALSE,
  sgp.target.scale.scores=FALSE,
  parallel.config=parallel.config)

####################################################
### STEP 3: Run analyses to calculate baseline referenced projections (swapping SCALE_SCORE and SCALE_SCORE_OLD_SCALE)
####################################################
setnames(WIDA_MA_SGP@Data, c("GRADE", "GRADE_ADJUSTED"), c("GRADE_ADJUSTED", "GRADE"))

WIDA_MA_SGP <- abcSGP(
  sgp_object=WIDA_MA_SGP,
  steps=c("prepareSGP", "analyzeSGP", "combineSGP"),
  years="2026",
  sgp.percentiles=FALSE,
  sgp.projections=FALSE,
  sgp.projections.lagged=FALSE,
  sgp.percentiles.baseline=FALSE,
  sgp.projections.baseline=TRUE,
  sgp.projections.lagged.baseline=TRUE,
  sgp.target.scale.scores=TRUE,
  parallel.config=parallel.config)

setnames(WIDA_MA_SGP@Data, c("GRADE", "GRADE_ADJUSTED"), c("GRADE_ADJUSTED", "GRADE"))
setnames(WIDA_MA_SGP@Data, c("SCALE_SCORE", "SCALE_SCORE_OLD_SCALE"), c("SCALE_SCORE_OLD_SCALE", "SCALE_SCORE"))

#######################################
### Add in additional variables
#######################################

tmp.data <- copy(WIDA_MA_SGP@Data)

### Convert CURRENT SCALE_SCORE_TARGETS to PROFICIENCY_TARGETS
tmp.data[YEAR == "2026", PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_5_YEAR_PROJ_YEAR_1_CURRENT:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](as.character(as.numeric(GRADE)+1), ceiling(SCALE_SCORE_SGP_TARGET_BASELINE_5_YEAR_PROJ_YEAR_1_CURRENT))]
tmp.data[YEAR == "2026", PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_4_YEAR_PROJ_YEAR_1_CURRENT:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](as.character(as.numeric(GRADE)+1), ceiling(SCALE_SCORE_SGP_TARGET_BASELINE_4_YEAR_PROJ_YEAR_1_CURRENT))]
tmp.data[YEAR == "2026", PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_3_YEAR_PROJ_YEAR_1_CURRENT:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](as.character(as.numeric(GRADE)+1), ceiling(SCALE_SCORE_SGP_TARGET_BASELINE_3_YEAR_PROJ_YEAR_1_CURRENT))]
tmp.data[YEAR == "2026", PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_2_YEAR_PROJ_YEAR_1_CURRENT:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](as.character(as.numeric(GRADE)+1), ceiling(SCALE_SCORE_SGP_TARGET_BASELINE_2_YEAR_PROJ_YEAR_1_CURRENT))]
tmp.data[YEAR == "2026", PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_1_YEAR_PROJ_YEAR_1_CURRENT:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](as.character(as.numeric(GRADE)+1), ceiling(SCALE_SCORE_SGP_TARGET_BASELINE_1_YEAR_PROJ_YEAR_1_CURRENT))]

### Select CURRENT PROFICIENCY_TARGETS based upon YEARS_IN_MASS
tmp.data[YEAR == "2026" & YEARS_IN_MA==1 & ACHIEVEMENT_LEVEL_ORIGINAL < "4.2", ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_5_YEAR_PROJ_YEAR_1_CURRENT]
tmp.data[YEAR == "2026" & YEARS_IN_MA==2 & ACHIEVEMENT_LEVEL_ORIGINAL < "4.2", ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_4_YEAR_PROJ_YEAR_1_CURRENT]
tmp.data[YEAR == "2026" & YEARS_IN_MA==3 & ACHIEVEMENT_LEVEL_ORIGINAL < "4.2", ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_3_YEAR_PROJ_YEAR_1_CURRENT]
tmp.data[YEAR == "2026" & YEARS_IN_MA==4 & ACHIEVEMENT_LEVEL_ORIGINAL < "4.2", ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_2_YEAR_PROJ_YEAR_1_CURRENT]
tmp.data[YEAR == "2026" & YEARS_IN_MA>=5 & ACHIEVEMENT_LEVEL_ORIGINAL < "4.2", ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=4.2]
tmp.data[YEAR == "2026" & ACHIEVEMENT_LEVEL_ORIGINAL >= "4.2", ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT:=4.2]

### Select CURRENT SGP_TARGETS based upon YEARS_IN_MASS
tmp.data[YEAR == "2026" & YEARS_IN_MA==1 & ACHIEVEMENT_LEVEL_ORIGINAL < "4.2", ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_5_YEAR_CURRENT]
tmp.data[YEAR == "2026" & YEARS_IN_MA==2 & ACHIEVEMENT_LEVEL_ORIGINAL < "4.2", ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_4_YEAR_CURRENT]
tmp.data[YEAR == "2026" & YEARS_IN_MA==3 & ACHIEVEMENT_LEVEL_ORIGINAL < "4.2", ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_3_YEAR_CURRENT]
tmp.data[YEAR == "2026" & YEARS_IN_MA==4 & ACHIEVEMENT_LEVEL_ORIGINAL < "4.2", ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_2_YEAR_CURRENT]
tmp.data[YEAR == "2026" & YEARS_IN_MA>=5 & ACHIEVEMENT_LEVEL_ORIGINAL < "4.2", ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_1_YEAR_CURRENT]
tmp.data[YEAR == "2026" & ACHIEVEMENT_LEVEL_ORIGINAL >= "4.2", ACCOUNTABILITY_SGP_TARGET_CURRENT:=SGP_TARGET_BASELINE_1_YEAR_CURRENT]

### Add to SGP object
WIDA_MA_SGP@Data <- tmp.data

### Define variables in final file
variables.to.keep <- c("ID", "CONTENT_AREA", "YEAR", "GRADE", "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_ORIGINAL", "SCALE_SCORE", "SGP_BASELINE", "ACCOUNTABILITY_SGP_TARGET_CURRENT", "ACCOUNTABILITY_PROFICIENCY_LEVEL_TARGET_CURRENT", "YEARS_IN_MA")
WIDA_MA_Formatted_Output_2026 <- WIDA_MA_SGP@Data[ YEAR == "2026" & VALID_CASE=="VALID_CASE", ..variables.to.keep]

### Save Formatted Results
save(WIDA_MA_Formatted_Output_2026, file="Data/WIDA_MA_Formatted_Output_2026.Rdata")

### Save SGP object
setkey(WIDA_MA_SGP@Data, VALID_CASE, CONTENT_AREA, YEAR, GRADE, ID)
#save(WIDA_MA_SGP, file="Data/WIDA_MA_SGP.Rdata")

