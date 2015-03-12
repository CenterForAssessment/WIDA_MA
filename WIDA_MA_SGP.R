##########################################################################################
###
### Script for calculating SGPs for 2012-2013 and 2013-2014 for WIDA/ACCESS/MA
###
##########################################################################################

### Load SGP package

require(SGP)
options(error=recover)
options(warn=2)


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
		save.intermediate.results=TRUE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4)))


### Save results

save(WIDA_MA_SGP, file="Data/WIDA_MA_SGP.Rdata")
