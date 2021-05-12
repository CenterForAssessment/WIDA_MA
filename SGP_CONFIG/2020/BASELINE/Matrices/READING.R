################################################################################
###                                                                          ###
###      READING BASELINE matrix configurations (sequential and skip-year)   ###
###                                                                          ###
################################################################################

READING_BASELINE.config <- list(
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2019', '2020'),
		sgp.baseline.grade.sequences=c('0', '1'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2019', '2020'),
		sgp.baseline.grade.sequences=c('1', '2'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2018', '2019', '2020'),
		sgp.baseline.grade.sequences=c('0', '1', '2'),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2019', '2020'),
		sgp.baseline.grade.sequences=c('2', '3'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2018', '2019', '2020'),
		sgp.baseline.grade.sequences=c('1', '2', '3'),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2019', '2020'),
		sgp.baseline.grade.sequences=c('3', '4'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2018', '2019', '2020'),
		sgp.baseline.grade.sequences=c('2', '3', '4'),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2019', '2020'),
		sgp.baseline.grade.sequences=c('4', '5'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2018', '2019', '2020'),
		sgp.baseline.grade.sequences=c('3', '4', '5'),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2019', '2020'),
		sgp.baseline.grade.sequences=c('5', '6'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2018', '2019', '2020'),
		sgp.baseline.grade.sequences=c('4', '5', '6'),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2019', '2020'),
		sgp.baseline.grade.sequences=c('6', '7'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2018', '2019', '2020'),
		sgp.baseline.grade.sequences=c('5', '6', '7'),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2019', '2020'),
		sgp.baseline.grade.sequences=c('7', '8'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2018', '2019', '2020'),
		sgp.baseline.grade.sequences=c('6', '7', '8'),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2019', '2020'),
		sgp.baseline.grade.sequences=c('8', '9'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2018', '2019', '2020'),
		sgp.baseline.grade.sequences=c('7', '8', '9'),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2019', '2020'),
		sgp.baseline.grade.sequences=c('9', '10'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2018', '2019', '2020'),
		sgp.baseline.grade.sequences=c('8', '9','10'),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2019', '2020'),
		sgp.baseline.grade.sequences=c('10', '11'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2018', '2019', '2020'),
		sgp.baseline.grade.sequences=c('9', '10', '11'),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2019', '2020'),
		sgp.baseline.grade.sequences=c('11', '12'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2018', '2019', '2020'),
		sgp.baseline.grade.sequences=c('10', '11', '12'),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	###  SKIP YEAR
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2018', '2020'),
		sgp.baseline.grade.sequences=c('0', '2'),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2018', '2020'),
		sgp.baseline.grade.sequences=c('1', '3'),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2017', '2018', '2020'),
		sgp.baseline.grade.sequences=c('0', '1', '3'),
		sgp.baseline.grade.sequences.lags=c(1,2)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2018', '2020'),
		sgp.baseline.grade.sequences=c('2', '4'),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2017', '2018', '2020'),
		sgp.baseline.grade.sequences=c('1', '2', '4'),
		sgp.baseline.grade.sequences.lags=c(1,2)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2018', '2020'),
		sgp.baseline.grade.sequences=c('3', '5'),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2017', '2018', '2020'),
		sgp.baseline.grade.sequences=c('2', '3', '5'),
		sgp.baseline.grade.sequences.lags=c(1,2)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2018', '2020'),
		sgp.baseline.grade.sequences=c('4', '6'),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2017', '2018', '2020'),
		sgp.baseline.grade.sequences=c('3', '4', '6'),
		sgp.baseline.grade.sequences.lags=c(1,2)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2018', '2020'),
		sgp.baseline.grade.sequences=c('5', '7'),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2017', '2018', '2020'),
		sgp.baseline.grade.sequences=c('4', '5', '7'),
		sgp.baseline.grade.sequences.lags=c(1,2)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2018', '2020'),
		sgp.baseline.grade.sequences=c('6', '8'),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2017', '2018', '2020'),
		sgp.baseline.grade.sequences=c('5', '6', '8'),
		sgp.baseline.grade.sequences.lags=c(1,2)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2018', '2020'),
		sgp.baseline.grade.sequences=c('7', '9'),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2017', '2018', '2020'),
		sgp.baseline.grade.sequences=c('6', '7', '9'),
		sgp.baseline.grade.sequences.lags=c(1,2)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2018', '2020'),
		sgp.baseline.grade.sequences=c('8', '10'),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2017', '2018', '2020'),
		sgp.baseline.grade.sequences=c('7', '8', '10'),
		sgp.baseline.grade.sequences.lags=c(1,2)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2018', '2020'),
		sgp.baseline.grade.sequences=c('9', '11'),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2017', '2018', '2020'),
		sgp.baseline.grade.sequences=c('8', '9', '11'),
		sgp.baseline.grade.sequences.lags=c(1,2)),
	list(
		sgp.baseline.content.areas=rep('READING', 2),
		sgp.baseline.panel.years=c('2018', '2020'),
		sgp.baseline.grade.sequences=c('10', '12'),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=rep('READING', 3),
		sgp.baseline.panel.years=c('2017', '2018', '2020'),
		sgp.baseline.grade.sequences=c('9', '10', '12'),
		sgp.baseline.grade.sequences.lags=c(1,2)))
