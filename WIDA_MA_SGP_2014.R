#########################################################################################
###
### Script to run WIDA baseline analyses
###
#########################################################################################

### Load SGP Package

require(SGP)


### Load data

load("Data/WIDA_Data_LONG.Rdata")


### Modify SGPstateData

SGPstateData[["WIDA"]][["Growth"]][["System_Type"]] <- "Baseline Referenced"


### Run abcSGP

WIDA_MA_SGP_2014 <- abcSGP(
		WIDA_Data_LONG,
		years="2014",
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "visualizeSGP", "outputSGP"),
		sgp.percentiles=FALSE,
		sgp.percentiles.baseline=TRUE,
		sgp.projections=FALSE,
		sgp.projections.baseline=TRUE,
		sgp.projections.lagged=FALSE,
		sgp.projections.lagged.baseline=TRUE,
		save.intermediate.results=TRUE,
		plot.types="growthAchievementPlot")

save(WIDA_MA_SGP_2014, file="Data/WIDA_MA_SGP_2014.Rdata")
