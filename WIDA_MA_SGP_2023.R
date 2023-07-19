##########################################################################################
###
### Script for calculating SGPs for 2023 WIDA/ACCESS Massachusetts
###
##########################################################################################

### Load SGP package
require(SGP)
require(data.table)

### Load Data
load("Data/WIDA_MA_SGP.Rdata")
load("Data/WIDA_MA_Data_LONG_2023.Rdata")

###   Add single-cohort baseline matrices to SGPstateData
SGPstateData <- SGPmatrices::addBaselineMatrices("WIDA_MA", "2023")

### Run analyses
WIDA_MA_SGP <- updateSGP(
		WIDA_MA_SGP,
		WIDA_MA_Data_LONG_2023,
		steps=c("prepareSGP", "analyzeSGP", "combineSGP"),
		sgp.percentiles=TRUE,
		sgp.projections=TRUE,
		sgp.projections.lagged=TRUE,
		sgp.percentiles.baseline=TRUE,
		sgp.projections.baseline=TRUE,
		sgp.projections.lagged.baseline=TRUE,
		get.cohort.data.info=TRUE,
		sgp.target.scale.scores=TRUE,
		save.intermediate.results=FALSE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4, GA_PLOTS=1, SG_PLOTS=1)))

### Convert SCALE_SCORE_TARGETS to PROFICIENCY_TARGETS
tmp.data <- copy(WIDA_MA_SGP@Data)
tmp.data[YEAR=="2023", PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_5_YEAR_PROJ_YEAR_1:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](GRADE, SCALE_SCORE_SGP_TARGET_BASELINE_5_YEAR_PROJ_YEAR_1)]
tmp.data[YEAR=="2023", PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_4_YEAR_PROJ_YEAR_1:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](GRADE, SCALE_SCORE_SGP_TARGET_BASELINE_4_YEAR_PROJ_YEAR_1)]
tmp.data[YEAR=="2023", PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_3_YEAR_PROJ_YEAR_1:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](GRADE, SCALE_SCORE_SGP_TARGET_BASELINE_3_YEAR_PROJ_YEAR_1)]
tmp.data[YEAR=="2023", PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_2_YEAR_PROJ_YEAR_1:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](GRADE, SCALE_SCORE_SGP_TARGET_BASELINE_2_YEAR_PROJ_YEAR_1)]
tmp.data[YEAR=="2023", PROFICIENCY_LEVEL_SGP_TARGET_BASELINE_1_YEAR_PROJ_YEAR_1:=SGPstateData[['WIDA']][['SGP_Configuration']][['ss_to_pl_function']][['value']](GRADE, SCALE_SCORE_SGP_TARGET_BASELINE_1_YEAR_PROJ_YEAR_1)]
WIDA_MA_SGP@Data <- tmp.data

### Select PROFICIENCY_TARGETS based upon YEARS_IN_MASS


### Output & Save results
#outputSGP(WIDA_MA_SGP)
#save(WIDA_MA_SGP, file="Data/WIDA_MA_SGP.Rdata")
