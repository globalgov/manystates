
# qStates <img src="qStates_hexlogo.png" align="right" width="220"/>

<!-- badges: start -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
![GitHub release (latest by
date)](https://img.shields.io/github/v/release/globalgov/qStates)
![GitHub Release
Date](https://img.shields.io/github/release-date/globalgov/qstates)
![GitHub
issues](https://img.shields.io/github/issues-raw/globalgov/qStates)
<!-- [![HitCount](http://hits.dwyl.com/globalgov/qStates.svg)](http://hits.dwyl.com/globalgov/qStates) -->
[![Codecov test
coverage](https://codecov.io/gh/globalgov/qStates/branch/main/graph/badge.svg)](https://codecov.io/gh/globalgov/qStates?branch=main)
<!-- ![GitHub All Releases](https://img.shields.io/github/downloads/jhollway/roctopus/total) -->
<!-- badges: end -->

`{qStates}` is a a data package for the `{qData}` ecosystem of packages.
It is a data package about states actors across the globe. It
encompasses several datasets with states’ names and dates of beginning
and ending (for some states), alongside other information. The package
is geared towards global governance research, but can be used broadly
for anyone interested in states actors across time.

For more about the [the PANARCHIC project](www.panarchic.ch). Please
also check out [`{qData}`](https://github.com/globalgov) for more on the
`{qStates}` and `{qData}` packages.

## Downloading and installing qStates

The development version of the package `{qStates}` can be downloaded
from GitHub.

    #install.package(remotes)
    remotes::install_github("globalgov/qStates")

## To check on qStates and other available qPackages for qData

`{qData}` connects users to other packages in the ecosystem. The
`get_packages()` function can be also used to discover `{qStates}` and
other packages currently available in the ecosystem.

``` r
 library(qData)
```

    ## Loading required package: tibble

    ## Warning: package 'tibble' was built under R version 3.6.3

``` r
 get_packages()
```

    ## # A tibble: 2 x 7
    ##   name   full_name   description      installed latest updated    contributors  
    ##   <chr>  <chr>       <chr>            <chr>     <chr>  <date>     <chr>         
    ## 1 qData  globalgov/~ An R package fo~ 0.3.0     0.2.1  2020-11-26 jhollway, hen~
    ## 2 qStat~ globalgov/~ <NA>             0.0.1     Unrel~ NA         henriquesposi~

## Datasets included in the states database

`{qStates}` allows to quickly check all the datasets included in the
package’s database called.

``` r
qStates::states
```

    ## $COW
    ## # A tibble: 243 x 5
    ##    COW_Nr ID    Beg        End        Label            
    ##    <chr>  <chr> <date>     <date>     <chr>            
    ##  1 300    AUH   1816-01-01 1918-11-12 Austria-Hungary  
    ##  2 267    BAD   1816-01-01 1871-01-18 Baden            
    ##  3 245    BAV   1816-01-01 1871-01-18 Bavaria          
    ##  4 390    DEN   1816-01-01 1940-04-09 Denmark          
    ##  5 220    FRN   1816-01-01 1942-11-11 France           
    ##  6 255    GMY   1816-01-01 1945-05-08 Germany          
    ##  7 273    HSE   1816-01-01 1866-07-26 Hesse Electoral  
    ##  8 275    HSG   1816-01-01 1867-04-17 Hesse Grand Ducal
    ##  9 325    ITA   1816-01-01 2016-12-31 Italy            
    ## 10 210    NTH   1816-01-01 1940-07-14 Netherlands      
    ## # ... with 233 more rows
    ## 
    ## $GW
    ## # A tibble: 216 x 5
    ##    COW_Nr ID    Beg        End        Label            
    ##    <chr>  <chr> <date>     <date>     <chr>            
    ##  1 700    AFG   1816-01-01 1888-12-30 Afghanistan      
    ##  2 615    ALG   1816-01-01 1830-07-05 Algeria          
    ##  3 300    AUH   1816-01-01 1918-11-13 Austria-Hungary  
    ##  4 267    BAD   1816-01-01 1871-01-17 Baden            
    ##  5 245    BAV   1816-01-01 1871-01-17 Bavaria          
    ##  6 710    CHN   1816-01-01 2017-12-31 China            
    ##  7 390    DEN   1816-01-01 2017-12-31 Denmark          
    ##  8 220    FRN   1816-01-01 2017-12-31 France           
    ##  9 255    GMY   1816-01-01 1945-05-07 Germany (Prussia)
    ## 10 41     HAI   1816-01-01 1915-07-04 Haiti            
    ## # ... with 206 more rows
    ## 
    ## $ISD
    ## # A tibble: 362 x 7
    ##    COW_Nr ID    Beg        End        Label           Micro New.State
    ##    <chr>  <fct> <date>     <date>     <chr>           <int>     <int>
    ##  1 8531   ACH   1816-01-01 1874-01-30 Aceh                1         0
    ##  2 700    AFG   1816-01-01 1879-12-31 Afghanistan         0         0
    ##  3 615    ALG   1816-01-01 1830-12-31 Algeria             0         0
    ##  4 7572   ASA   1816-01-01 1817-04-30 Assam               0         0
    ##  5 4521   AST   1816-01-01 1896-02-01 Ashanti             0         0
    ##  6 300    AUH   1816-01-01 1918-11-12 Austria-Hungary     0         0
    ##  7 4908   AZA   1816-01-01 1895-12-31 Azande              0         0
    ##  8 267    BAD   1816-01-01 1871-01-18 Baden               0         0
    ##  9 245    BAV   1816-01-01 1871-01-18 Bavaria             0         0
    ## 10 7533   BHP   1816-01-01 1817-12-01 Bhopal              0         0
    ## # ... with 352 more rows

Please see the user vignette on [the
website](https://globalgov.github.io/qData/) for more information about
how to use both `qStates}` and `{qData}` for analysis.
