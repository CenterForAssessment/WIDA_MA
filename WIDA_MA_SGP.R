##########################################################################################
###
### Script for calculating SGPs for 2011-2012 for MEPA 
###
##########################################################################################

### Load SGP package

require(SGP)
options(error=recover)
options(warn=2)


### Load Data

load("Data/WIDA_MA_Data_LONG.Rdata")


### NULL out SGPstateData stuff associated with 2013 data and assessment transition (hasn't happened yet when these analyses would have originally happened)

SGPstateData[["WIDA_MA"]][["Assessment_Program_Information"]][["Scale_Change"]] <- NULL
SGPstateData[["WIDA_MA"]][["Achievement"]][["Cutscores"]][["READING.2013"]] <- NULL
SGPstateData[["WIDA_MA"]][["Achievement"]][["Knots_Boundaries"]][["READING.2013"]] <- NULL
SGPstateData[["WIDA_MA"]][["Assessment_Program_Information"]][["Assessment_Transition"]] <- NULL
SGPstateData[["WIDA_MA"]][["Assessment_Program_Information"]][["Assessment_Abbreviation"]] <- "MEPA"
SGPstateData[["WIDA_MA"]][["Achievement"]][["Levels"]] <- list(
	Labels=c("MEPA Level 1", "MEPA Level 2", "MEPA Level 3", "MEPA Level 4", "MEPA Level 5", "NO SCORE"),
	Proficient=c("Not Proficient", "Not Proficient", "Not Proficient", "Proficient", "Proficient", NA))
SGPstateData[["WIDA_MA"]][["Student_Report_Information"]][["Achievement_Level_Labels"]] <- list(
	"MEPA L1"="MEPA Level 1",
	"MEPA L2"="MEPA Level 2",
	"MEPA L3"="MEPA Level 3",
	"MEPA L4"="MEPA Level 4",
	"MEPA L5"="MEPA Level 5")
SGPstateData[["WIDA_MA"]][["SGP_Configuration"]][["sgPlot.fan.condition"]] <- "head(Achievement_Levels, 1) %in% paste('MEPA Level', 1:3)"


### Run analyses

WIDA_MA_SGP <- abcSGP(
		WIDA_MA_Data_LONG,
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
		sgp.percentiles=TRUE,
		sgp.projections=TRUE,
		sgp.projections.lagged=TRUE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		save.intermediate.results=TRUE),
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4)))


### Save results

save(WIDA_MA_SGP, file="Data/WIDA_MA_SGP.Rdata")
