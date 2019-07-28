##########################################################################################
###
### Script for calculating SGPs for 2017-2019 WIDA/ACCESS Massachusetts
###
##########################################################################################

### Load SGP package

require(SGP)


### Load Data

#load("Data/WIDA_MA_SGP.Rdata")
#load("Data/WIDA_MA_Data_LONG_2019.Rdata")
load("Data/WIDA_MA_Data_LONG.Rdata")

### Run analyses


WIDA_MA_SGP <- abcSGP(
		WIDA_MA_Data_LONG,
#WIDA_MA_SGP <- updateSGP(
#		WIDA_MA_SGP,
#		WIDA_MA_Data_LONG_2019,
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
		sgp.percentiles=TRUE,
		sgp.projections=TRUE,
		sgp.projections.lagged=TRUE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		get.cohort.data.info=TRUE,
		sgp.target.scale.scores=TRUE,
		save.intermediate.results=FALSE)#,
#		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4, GA_PLOTS=1, SG_PLOTS=1)))


### Save results

save(WIDA_MA_SGP, file="Data/WIDA_MA_SGP.Rdata")
