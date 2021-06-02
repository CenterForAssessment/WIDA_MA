###########################################################################################
###                                                                                     ###
###   WIDA Massachusetts Learning Loss Analyses -- 2020 Baseline Growth Projections     ###
###                                                                                     ###
###########################################################################################

###   Load packages
require(SGP)

###   Load data from baseline SGP analyses
load("Data/WIDA_MA_SGP.Rdata")

###   Add single-cohort baseline matrices to SGPstateData
SGPstateData <- SGPmatrices::addBaselineMatrices("WIDA_MA", "2021")

#####
###   Run projections analysis - run abcSGP on object from BASELINE SGP analysis
#####

WIDA_MA_SGP <- abcSGP(
        sgp_object = WIDA_MA_SGP,
		years="2020",
        steps = c("prepareSGP", "analyzeSGP"), # no changes to @Data - don't combine or output
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = FALSE,
        sgp.projections.baseline = TRUE, # Need P50_PROJ_YEAR_1_CURRENT for Ho's Fair Trend/Equity Check metrics
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = list(
					BACKEND = "PARALLEL",
          WORKERS=list(PROJECTIONS=8))
)

###   Save results
save(WIDA_MA_SGP, file="Data/WIDA_MA_SGP.Rdata")
