#' states datacube documentation
#'
#' @format The states datacube is a list that contains the
#' following 8 datasets: GW, ISD, COW, ICOW, RATRULES, HUGGO_STATES,
#' EconomicFreedom, EconomicFreedomHist.
#' For more information and references to each of the datasets used,
#' please use the `manydata::call_sources()` and `manydata::compare_dimensions()` functions.
#'\describe{
#' \item{GW: }{A dataset with 216 observations and the following
#' 6 variables: cowID, Begin, End, cowNR, StateName, stateID.}
#' \item{ISD: }{A dataset with 362 observations and the following
#' 8 variables: cowID, Begin, End, cowNR, StateName, Micro, NewState, stateID.}
#' \item{COW: }{A dataset with 243 observations and the following
#' 6 variables: cowID, Begin, End, cowNR, StateName, stateID.}
#' \item{ICOW: }{A dataset with 217 observations and the following
#' 16 variables: cowID, StateName, ColRuler, IndFrom, Begin, IndViol, IndType,
#' SecFrom, SecDate, SecViol, Into, IntoDate, COWsys, GWsys, Notes, stateID.}
#' \item{RATRULES: }{A dataset with 177 observations and the following
#' 3 variables: stateID, StateName, RatProcedure.}
#' \item{HUGGO_STATES: }{A dataset with 470 observations and the following
#' 14 variables: stateID, StateName, Capital, Begin, End, StateName2, Capital2,
#' Latitude, Longitude, Area, Region, RatProcedure, Constitutional Description,
#' Source_rat.}
#' \item{EconomicFreedom: }{A dataset with 4290 observations and the following
#' 73 variables: cowID, Year, StateName, Economic Freedom Summary Index, Rank,
#' Quartile, 1A Government Consumption, 1A_data, 1B  Transfers and subsidies,
#' 1B_data, 1C  Government investment, 1C_data, 1Di Top marginal income tax rate,
#' 1Di_data, 1Dii Top marginal income and payroll tax rate, 1Dii_data,
#' 1D  Top marginal tax rate, IE State Ownership of Assets, 1  Size of Government,
#' 2A  Judicial independence, 2B  Impartial courts, 2C  Protection of property rights,
#' 2D  Military interference in rule of law and politics,
#' 2E Integrity of the legal system, 2F Legal enforcement of contracts,
#' 2G Regulatory restrictions on the sale of real property,
#' 2H Reliability of police, Gender Legal Rights Adjustment,
#' 2  Legal System & Property Rights, 3A  Money growth, 3A_data,
#' 3B  Standard deviation of inflation, 3B_data, 3C  Inflation: Most recent year,
#' 3C_data, 3D  Freedom to own foreign currency bank accounts, 3  Sound Money,
#' 4Ai  Revenue from trade taxes (% of trade sector), 4Ai_data,
#' 4Aii  Mean tariff rate, 4Aii_data, 4Aiii  Standard deviation of tariff rates,
#' 4Aiii_data, 4A  Tariffs, 4Bi  Non-tariff trade barriers,
#' 4Bii  Compliance costs of importing and exporting, 4B  Regulatory trade barriers,
#' 4C  Black market exchange rates, 4Di  Financial Openness, 4Dii  Capital controls,
#' 4Diii Freedom of foreigners to visit, 4D  Controls of the movement of capital and people,
#' 4  Freedom to trade internationally, 5Ai  Ownership of banks, 5Aii Private sector credit,
#' 5Aiii  Interest rate controls/negative real interest rates),
#' 5A  Credit market regulations, 5Bi  Hiring regulations and minimum wage,
#' 5Bii  Hiring and firing regulations, 5Biii  Centralized collective bargaining,
#' 5Biv  Hours Regulations, 5Bv Mandated cost of worker dismissal, 5Bvi  Conscription,
#' 5B  Labor market regulations, 5Ci  Administrative requirements, 5Cii  Regulatory Burden,
#' 5Ciii  Starting a  business, 5Civ  Impartial Public Administration,
#' 5Cv Licensing restrictions, 5Cvi Tax compliance, 5C  Business regulations, 
#' 5  Regulation, stateID.}
#' \item{EconomicFreedomHist: }{A dataset with 458 observations and the following
#' 5 variables: stateID, Year, StateName, EFW, Rank.}
#' }
#' @source
#' \itemize{
#' \item{GW: }{
#' K. S. Gleditsch and M. D. Ward. “Interstate system membership: A revised list of the independent states since 1816”.
#' _International Interactions_ 25.4 (1999), pp. 393-413.}
#' \item{ISD: }{
#' R. D. Griffiths and C. R. Butcher. “Introducing the international system (s) dataset (ISD), 1816-2011”.
#' _International Interactions_ 39.5 (2013), pp. 748-768.}
#' \item{COW: }{
#' Correlates of War Project. _State System Membership List, v2016._
#' <http://correlatesofwar.org>. Accessed: 2021-01-25.}
#' \item{ICOW: }{
#' P. R. Hensel. (2018). _ICOW Colonial History Data Set, version 1.1._
#' <http://www.paulhensel.org/icowcol.html>.Accessed: 2021-12-23.}
#' \item{RATRULES: }{
#' B. A. Simmons. _Mobilizing for Human Rights: International Law in Domestic Politics_.
#' Cambridge University Press, 2009.}
#' \item{HUGGO_STATES: }{
#' J. Hollway. manystates: States for manydata. 2021.}
#' \item{EconomicFreedom: }{
#' J. Gwartney, R. Lawson, and J. Hall. (2020). _2020 Economic Freedom Dataset, published in Economic Freedom of the World: 2020 Annual Report_.
#' <http://www.fraserinstitute.org/studies/economic-freedom-of-the-world-2020-annual-report>. Accessed: 2021-12-23.}
#' \item{EconomicFreedomHist: }{
#' J. Gwartney, R. Lawson, and J. Hall. (2020). _2020 Economic Freedom Dataset, published in Economic Freedom of the World: 2020 Annual Report_.
#' <http://www.fraserinstitute.org/studies/economic-freedom-of-the-world-2020-annual-report>. Accessed: 2021-12-23.}
#' }
#' @section URL:
#' \itemize{
#' \item{GW: }{
#' \url{http://ksgleditsch.com/data-4.html}
#' }
#' \item{ISD: }{
#' \url{http://www.ryan-griffiths.com/data}
#' }
#' \item{COW: }{
#' \url{https://correlatesofwar.org/data-sets/state-system-membership}
#' }
#' \item{ICOW: }{
#' \url{http://www.paulhensel.org/icowcol.html}
#' }
#' \item{RATRULES: }{
#' \url{https://doi.org/10.1017/CBO9780511811340}
#' }
#' \item{HUGGO_STATES: }{Hand-coded data by the GGO team}
#' \item{EconomicFreedom: }{
#' \url{https://www.fraserinstitute.org/economic-freedom}
#' }
#' \item{EconomicFreedomHist: }{
#' \url{https://www.fraserinstitute.org/economic-freedom}
#' }
#' }
#' @section Mapping:
#' \itemize{
#' \item{GW: }{
#' Variable Mapping
#'
#' |  *from*  | *to*
#' |:------------:|:------------:|
#' | Cow ID | cowID |
#' | Start | Begin |
#' | Finish | End |
#' | Name of State | StateName |
#' | Cow NR. | cowNR |
#' 
#' }
#' \item{ISD: }{
#' Variable Mapping
#'
#' |  *from*  | *to*
#' |:------------:|:------------:|
#' | COW.ID | cowID |
#' | Start | Begin |
#' | Finish | End |
#' | State.Name | StateName |
#' | COW.Nr | cowNr |
#' 
#' }
#' \item{COW: }{
#' Variable Mapping
#'
#' |  *from*  | *to*
#' |:------------:|:------------:|
#' | stateabb | cowID |
#' | styear, stmonth, stday | Begin |
#' | endyear, endmonth, endday | End |
#' | statenme | StateName |
#' | ccode | cowNR |
#' 
#' }
#' \item{ICOW: }{
#' Variable Mapping
#'
#' |  *from*  | *to*
#' |:------------:|:------------:|
#' | State | cowID |
#' | Name | StateName |
#' | IndDate | Begin |
#' 
#' }
#' \item{RATRULES: }{
#' Variable Mapping
#'
#' |  *from*  | *to*
#' |:------------:|:------------:|
#' | StatID | stateID |
#' | Rat | RatProcedure |
#' 
#' }
#' \item{EconomicFreedom: }{
#' Variable Mapping
#'
#' |  *from*  | *to*
#' |:------------:|:------------:|
#' | Countries | StateName |
#' | ISO_Code_3 | cowID |
#' | data...9 | 1A_data |
#' | data...11 | 1B_data |
#' | data...13 | 1C_data |
#' | data...15 | 1Di_data |
#' | data...17 | 1Dii_data |
#' | data...32 | 3A_data |
#' | data...34 | 3B_data |
#' | data...36 | 3C_data |
#' | data...40 | 4Ai_data |
#' | data...42 | 4Aii_data |
#' | data...44 | 4Aiii_data |
#' 
#' }
#' \item{EconomicFreedomHist: }{
#' Variable Mapping
#'
#' |  *from*  | *to*
#' |:------------:|:------------:|
#' | Country | StateName |
#' 
#' }
#' }
#' @md
#' @details
#' ``` {r, echo = FALSE, warning = FALSE}
#' lapply(states, messydates::mreport)
#' ```
"states"
