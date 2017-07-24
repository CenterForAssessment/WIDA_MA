##########################################################################################
###
### Script for calculating SGPs for 2016-2017 for WIDA-ACCESS
###
##########################################################################################

### Load SGP package

require(SGP)


### Load Data

load("Data/WIDA_MA_Data_LONG.Rdata")


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
		sgp.target.scale.scores=TRUE,
		save.intermediate.results=TRUE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4)))


### Save results

save(WIDA_MA_SGP, file="Data/WIDA_MA_SGP.Rdata")
