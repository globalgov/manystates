
# manystates <img src="man/figures/manystates_hexlogo.png" alt="The manystates logo" align="right" width="220"/>

<!-- badges: start -->

[![lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg)](https://www.tidyverse.org/lifecycle/#stable)
![GitHub release (latest by
date)](https://img.shields.io/github/v/release/globalgov/manystates)
![GitHub Release
Date](https://img.shields.io/github/release-date/globalgov/manystates)
![GitHub
issues](https://img.shields.io/github/issues-raw/globalgov/manystates)
[![Codecov test
coverage](https://codecov.io/gh/globalgov/manystates/branch/main/graph/badge.svg)](https://app.codecov.io/gh/globalgov/manystates?branch=main)
[![CodeFactor](https://www.codefactor.io/repository/github/globalgov/manystates/badge)](https://www.codefactor.io/repository/github/globalgov/manystates)
<!-- badges: end -->

`manystates` is a data package within the [many universe of
packages](https://github.com/globalgov). It contains an ensemble of
datasets currently available on states and state-like entities in the
world, including information on states’ beginning and, where applicable,
end dates, and geographical characteristics. An important aim of
`manystates` is to record and include states as far back in history as
possible. The package is geared towards global governance research, but
can also be used by anyone interested in state actors across time.

Please also check out
[`{manydata}`](https://github.com/globalgov/manydata) for more
information about the other packages and tools to handle data from the
many universe of packages.

## How to install

We’ve made it easier than ever to install and start analysing global
governance data in R. Simply install the core package,
[manydata](https://github.com/globalgov/manydata), as follows, and then
you can discover, install and update various ‘many packages’ from the
console.

``` r
manydata::call_packages() # this prints a list of the publicly available data packages currently available
# manydata::call_packages("manystates") # this downloads and installs the named package
```

## Included data

Once you have installed the package, you can access the primary datacube
in the package, `states`, as follows. You can see that currently the
datacube combines three datasets: Gleditsch and Ward’s (1999) state
list, the International System(s) Dataset (ISD) by Griffiths and Butcher
(2013), and the state list developed by Hollway, Sposito, and Tan (2021)
for this package.

``` r
manydata::describe_datacube(manystates::states)
```

    ## [1] "The `manystates::states` datacube is a list containing 3 datasets: ISD, HUGGO, and GW"

``` r
manystates::states
```

    ## $ISD
    ## # A tibble: 482 × 35
    ##    stateID StateName StateName2 Begin End   Latitude Longitude StartType EndType
    ##    <chr>   <chr>     <chr>      <mda> <mda> <chr>    <chr>     <chr>     <chr>  
    ##  1 KOR     Korea     Koryo Cho… 0676  1905… 37 34 0… 126 58 0… 4         2      
    ##  2 CHI     Chien Kh… <NA>       0800? 1831… 19 25 0… 103 30 0… 2         2      
    ##  3 TON     Tonga     Kingdom O… 1100? 1900… 21 8 0 S 175 12 0… 4         1      
    ##  4 MNG     Mongolia  <NA>       1200? 2016… 47 55 1… 106 55 2… 2         <NA>   
    ##  5 BOH     Bohol     <NA>       1200? 1829… 9 54 0 N 124 12 0… <NA>      1      
    ##  6 ETH     Ethiopia  Abyssinia… 1270  1936… 14 07 2… 38 44 21… 6         2      
    ##  7 LWU     Luwu      Ware       1300  1906… 3 0 0 S  120 12 0… 1         1      
    ##  8 BON     Bone      <NA>       1300? 1905… 4 32 19… 120 19 4… 2         1      
    ##  9 MIN     Minangka… <NA>       1347  1837… 0 26 22… 100 40 9… 2         1      
    ## 10 IFE     Ile Ife   Ife Kingd… 1350? 1849… 7 29 25… 4 33 10.… 1         2      
    ## # ℹ 472 more rows
    ## # ℹ 26 more variables: cowID <chr>, cowNR <chr>, ISD_Category <chr>,
    ## #   Region <chr>, Start_Am <chr>, EStart_Am <chr>, Declare <chr>,
    ## #   DecDate <chr>, Population <chr>, PopDate <chr>, PopAm <chr>,
    ## #   PopulationHigh <chr>, PopulationLow <chr>, StartType_Am <chr>,
    ## #   StartSettle <chr>, End_Am <chr>, EndType_Am <chr>, EndSettle <chr>,
    ## #   Sovereignty_Am <chr>, EuroDip <chr>, Borders <chr>, Borders_Am <chr>, …
    ## 
    ## $HUGGO
    ## # A tibble: 470 × 14
    ##    stateID StateName  Capital    Begin     End   Latitude Longitude Constitution
    ##    <chr>   <chr>      <chr>      <mdate>   <mda> <chr>    <chr>     <chr>       
    ##  1 SMR     San Marino San Marino 0301-09-… 9999… 43.9367  12.4463   San Marino,…
    ##  2 BGR     Bulgaria   Sofia      0681-12-… 1018… 42.69751 23.32415  <NA>        
    ##  3 HRV     Croatia    Zagreb     0879-06-… 1102… 45.81444 15.97798  <NA>        
    ##  4 CHM     Chamba     Chamba     0920-01-… 1846… 32.5558  76.12592  <NA>        
    ##  5 DRV     Annam      Hue        0939-01-… 1883… 16.46667 107.6     <NA>        
    ##  6 HUN     Hungary    Budapest   1000-12-… 1526… 47.49801 19.03991  <NA>        
    ##  7 POL     Poland     Warsaw     1025-04-… 1795… 52.22977 21.01178  <NA>        
    ##  8 MMR     Myanmar    Rangoon    1044-01-… 1885… 16.80528 96.15611  As provided…
    ##  9 RWA     Ruanda     Kigali     1081-01-… 1890… -1.94995 30.05885  <NA>        
    ## 10 MPR     Manipur    Imphal     1110-01-… 1891… 24.80805 93.9442   <NA>        
    ## # ℹ 460 more rows
    ## # ℹ 6 more variables: RatProcedure <chr>, Area <chr>, Region <chr>,
    ## #   StateName2 <chr>, Capital2 <chr>, Source_rat <chr>
    ## 
    ## $GW
    ## # A tibble: 216 × 6
    ##    stateID Begin        End          StateName            cowID cowNR
    ##    <chr>   <mdate>      <mdate>      <chr>                <chr> <chr>
    ##  1 AFG     ..1816-01-01 1888-12-30   Afghanistan          AFG   700  
    ##  2 AFG     1919-05-01   2017-12-31.. Afghanistan          AFG   700  
    ##  3 AGO     1975-11-11   2017-12-31.. Angola               ANG   540  
    ##  4 ALB     1913-01-01   2017-12-31.. Albania              ALB   339  
    ##  5 ALG     ..1816-01-01 1830-07-05   Algeria              ALG   615  
    ##  6 ALG     1962-07-05   2017-12-31.. Algeria              ALG   615  
    ##  7 ARE     1971-12-02   2017-12-31.. United Arab Emirates UAE   696  
    ##  8 ARG     1816-07-09   2017-12-31.. Argentina            ARG   160  
    ##  9 ARM     1991-12-21   2017-12-31.. Armenia              ARM   371  
    ## 10 AUH     ..1816-01-01 1918-11-13   Austria-Hungary      AUH   300  
    ## # ℹ 206 more rows

Working with ensembles of related data has many advantages for robust
analysis. Just take a look at our vignettes
[here](https://globalgov.github.io/manydata/articles/user.html).

## Included functions

In addition to the datasets, the package also includes a number of
functions that help you work with state data. `code_states()` is a
particularly useful function that helps you identify states or
state-like entities when referenced within text data. By default it will
identify the first state mentioned in each text, but it is possible to
look for multiple states by setting the `max_count` argument to a value
greater than 1. By default, the function will return ISO 3166 alpha-3
codes, but it is possible to return a standardised state name instead.

``` r
manystates::code_states(c("This was done in the United Kingdom", 
            "Switzerland and New Zealand made an agreement"),
            max_count = 2)
```

    ## [1] "GBR"       "{CHE,NZL}"

Additionally, there is a somewhat whimsical function that generates a
number of random state names. This function is inspired by observed
state names, but is not intended to reflect any actual states. It is
primarily designed for use in class exercises when a number of novel
state names are required. It can also be used to generate fictional
state names for creative writing or games.

``` r
manystates::generate_states(3)
```

    ## [1] "Jawar"           "Aramin Union"    "Maliwar Kingdom"

Feedback on either of these functions is most welcome.

## Many packages

The development of [many
packages](https://github.com/globalgov/manydata) is aimed at collecting,
connecting and correcting network data across issue-domains of global
governance.

While some ‘many packages’ can and do include novel data, much of what
they offer involves standing on the shoulders of giants. ‘many packages’
endeavour to be as transparent as possible about where data comes from,
how it has been coded and/or relabelled, and who has done the work. As
such, we make it easy to cite the datasets you use by listing the
official references using the function above, as well as the package
providers for their work assembling the data by using the function
below.

``` r
citation("manystates")
```

    ## To cite manystates in publications use:
    ## 
    ##   J. Hollway. manystates: States for manydata. 2021.
    ## 
    ## A BibTeX entry for LaTeX users is
    ## 
    ##   @Manual{,
    ##     title = {manystates: States for manydata},
    ##     author = {James Hollway},
    ##     year = {2021},
    ##     url = {https://github.com/globalgov/qStates},
    ##   }

## Contributing

If you have already developed a dataset salient to this package, please
reach out by flagging this as an
[issue](https://github.com/globalgov/manystates/issues) for us, or by
forking, further developing the package yourself, and opening a [pull
request](https://github.com/globalgov/manystates/pulls) so that your
data can be used easily.

If you have collected or developed other data that may not be best for
this package, but could be useful within the wider universe of
`many packages`, [`{manypkgs}`](https://github.com/globalgov/manypkgs)
includes a number of functions that make it easy to create a new
`many package` and populate it with clean, consistent global governance
data.

If you have any other ideas about how this package or the manydata
universe more broadly might better facilitate your empirical analysis,
we’d be very happy to hear from you.

## Funding details

Development on this package has been funded by the Swiss National
Science Foundation (SNSF) [Grant Number
188976](https://data.snf.ch/grants/grant/188976): “Power and Networks
and the Rate of Change in Institutional Complexes” (PANARCHIC).
