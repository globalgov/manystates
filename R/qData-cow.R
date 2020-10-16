#' Correlates	of	War	Project.	2016.	“State	System	Membership	List,	v2016.”	Online,
#' http://correlatesofwar.org.
#'
#' This dataset contains 	list	of	states	in	the	international	system	as	updated	and	distributed	by
#' the	Correlates	of	War	Project (COW). The dates range from 1816 until 2016. 	
#'
#' @format A data frame with 243 rows and 10 variables:
#' \describe{
#'   \item{stateabb}{Abbreviation of state name, follows ISO format}
#'   \item{ccode}{COW	state	number}
#'   \item{StateNme}{Primary COW state name}
#'   \item{StYear}{Beginning	year	of	state	tenure}
#'   \item{StMonth}{Beginning	month	of	state tenure}
#'   \item{StDay}{Beginning	day	of	state	tenure}
#'   \item{EndYear}{Ending	year	of	state	tenure}
#'   \item{EndMonth}{Ending	month	of	state	tenure}
#'   \item{EndDay}{Ending	day	of	state	tenure}
#'   \item{Version}{Data	file	version	number}
#' }
#' @source \url{https://correlatesofwar.org/data-sets/state-system-membership}
"cow"