# manystates 0.2.0

## Package

* Closed #61 by updating functions to import [Varieties of Democracy](https://github.com/vdeminstitute) data from the Github package with standardised variable names.
* Updated `import_vdem()`, `import_vparty()`, and `import_cshapes()` function by fixing CMD warnings and notes.
* Closed #54 by moving `code_states()` to `{manypkgs}` for consistency across packages.
* Added first draft of vignette to publicize `{manystates}` data.
* Updated pkgdown.yml file

## Data

* Closed #57 by replacing GNEVAR datasets with HUGGO datasets for handcoded data in `states`, `leaders`, and `contiguity` databases.
* Added some missing state names (`StateName` variable) and regions (`Region` variable) in `HUGGO_STATES` dataset.

# manystates 0.1.1

## Functions

* Added `generate_states()` for generating lists of fictional state names

# manystates 0.1.0

## Package

* Updated regex for `code_states()` to more accurately match and translate states' names.
* Updated workflow files to include package caching.
* Re-rendered documentation using `messydates::mreport()`.
* Added `{cshapes}` and `{vdemdata}` dependencies

## Data

* Added data across databases
  * Closed #9 by adding ICOW datasets to `states` database.
  * Closed #24 by adding Economic Freedom datasets to `economics` database.
  * Closed #25 by adding Freedom House data to `regimes` database.
  * Closed #48 by adding data on states' ratification rules to `ratrules` database.
  * Closed #49 by adding Colonial Relations data from ICOW dataset to `colsrels` database.
  * Closed #50 by adding self-coded data on the latitude and longitude of state capitals as `GNEVAR_STATES` dataset in `states` database.
  * Closed #51 by adding contiguity and regions data from FAO and ICOW in `contiguity` database.
* Changed class for date variables (`Beg` and `End`) from `messydt` to `mdate` using `messydates::as_messydate()` in preparation scripts across databases.

# manystates 0.0.6

## Package

* Fixed #43 by extending the regex pattern matching process of `code_states()`
* Changed the package name from `{qStates}` to `{manystates}`

# qStates 0.0.5

## Package

* Fixed #38 by fixing a bug preventing `data_contrast("qStates")` from being run while `{qStates}` is also loaded in the environment.
* Updated the CSS in the package to make it consistent with other packages in the qVerse

## Data

* Closed #29 by adding the ARCHIGOS database
* Closed #23 by adding `import_vdem()` to automatically import and consistently format the V-Dem dataset
* Closed #22 by adding `import_vparty()` to automatically import and consistently format the V-Party dataset
* Closed #37 by improving the way we deal with special categorical values (-66, -77, -88) in the Polity-V dataset
* Closed #36 by completing the regex table for improved text matching

# qStates 0.0.4

## Package

* Fixed #26 by updating list of states for `code_states()` function
* Fixed #30 by transforming date columns in qStates datasets to `messydt` class
* Closed #31 by creating qStates website
* Added vignette for working with `{CShapes}` and historical maps

## Data

* Closed #1 by adding the Polity5 dataset
* Integrated `{CShapes}`
  * Closed #10  by integrating datasets on distances from `{CShapes}`
  * Added `import_cshapes()` function to import `{CShapes}` data
  * Added `import_distlist()` function to import `{CShapes}` distances
  * Added `import_distmatrix()` function to import `{CShapes}` distance matrices

# qStates 0.0.3

## Package

* Updated README to align it with other qPackages
* Added a new package logo similar to other qPackages
* Added new pull request template consistent with `{qData}`

## Data

* Re-exported package data to reflect new testing, templates and argument changes with `export_data()` function in `{qData}` 

# qStates 0.0.2

## Data

- Closes #17 by rerunning the new `export_data()` function on the `states` database which adds new metadata(source link and source bibliography) as well as setting the bibliography at the correct database level instead of the dataset level.
- Added .bib files in each `data-raw` folder with the original datasets to provide citation information.
- Added link arguments to each `dataset-prepare` script.


# qStates 0.0.1

## Package

- Created the package structure and files using `qData::setup_package()`
- Closed #2 by adding and updating initial documentation as CONTRIBUTING, COC, LICENSE, issue and PR templates
- Added a `NEWS.md` file to track changes to the package
- Added a `README` document that outlines main characteristics of the data package
- Fixed #15 by removing ^data$ from .RBuildignore

## Data

- Closed #13 by using `qData::export_data()` and other functions from `{qData}` to form the `states` database from: 
  - Added the Correlates of War (COW) dataset and preparations scripts, documentation
  - Closed #6 by adding the International Systems Dataset (ISD) dataset and preparations scripts
  - Closed #7 by adding the Gleditsch & Ward dataset (GW)  dataset and preparations scripts
- Closed #12 by adding tests for all these datasets

## Functions

- Added `code_states()` to extract state IDs from a character vector
