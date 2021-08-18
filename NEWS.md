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
