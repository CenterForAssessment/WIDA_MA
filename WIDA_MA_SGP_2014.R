#########################################################################################
###
### Script for calculating SGPs for 2013-2014 for WIDA/ACCESS
###
#########################################################################################

### Load SGP Package

require(SGP)


### Load Data

load("Data/WIDA_MA_SGP.Rdata")
load("Data/WIDA_MA_Data_LONG_2014.Rdata")


### Create config for percentiles and 1 projections

READING_2014.config <- list(
        READING.2014 = list(
                sgp.content.areas=rep('READING', 4),
                sgp.projection.content.areas=rep('READING', 2),
                sgp.projection.baseline.content.areas=rep('READING', 2),
                sgp.panel.years=c('2011', '2012', '2013', '2014'),
                sgp.projection.panel.years=c('2013', '2014'),
                sgp.projection.baseline.panel.years=c('2013', '2014'),
                sgp.grade.sequences=list(c('0', '1'), c('0', '1', '2'), c('0', '1', '2', '3'), c('1', '2', '3', '4'), c('2', '3', '4', '5'), c('3', '4', '5', '6'), c('4', '5', '6', '7'), c('5', '6', '7', '8'), c('6', '7', '8', '9'), c('7', '8', '9', '10'), c('8', '9', '10', '11'), c('9', '10', '11', '12')),
                sgp.projection.grade.sequences=list('0', c('0', '1'), c('1', '2'), c('2', '3'), c('3', '4'), c('4', '5'), c('5', '6'), c('6', '7'), c('7', '8'), c('8', '9'), c('9', '10'), c('10', '11')),
                sgp.projection.baseline.grade.sequences=list('0', c('0', '1'), c('1', '2'), c('2', '3'), c('3', '4'), c('4', '5'), c('5', '6'), c('6', '7'), c('7', '8'), c('8', '9'), c('9', '10'), c('10', '11'))))


### updateSGP

WIDA_MA_SGP <- updateSGP(
		WIDA_MA_SGP,
		WIDA_MA_Data_LONG_2014,
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
		sgp.percentiles=TRUE,
		sgp.projections=TRUE,
		sgp.projections.lagged=TRUE,
		sgp.percentiles.baseline=TRUE,
		sgp.projections.baseline=TRUE,
		sgp.projections.lagged.baseline=TRUE,
		sgp.config=READING_2014.config,
		plot.types=c("studentGrowthPlot", "growthAchievementPlot"),
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4, GA_PLOTS=1, SG_PLOTS=1)))


### save ouput

save(WIDA_MA_SGP, file="Data/WIDA_MA_SGP.Rdata")
