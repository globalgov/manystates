# qStates 0.0.1

## Package

- Created the package structure and files using `qData::setup_package()`
- Closed #2 by adding and updating initial documentation as CONTRIBUTING, COC, License, and pull request templates
- Added a `NEWS.md` file to track changes to the package
- Added a `README` document that outlines main characteristics of the data package

## Data

- Closed #13 by using `qData::export_data()` and other functions from `{qData}` to form the `states` database from: 
  - Added the Correlates of War (COW) dataset and preparations scripts, documentation
  - Closed #6 by adding the International Systems Dataset (ISD) dataset and preparations scripts
  - Closed #7 by adding the Gleditsch & Ward dataset (GW)  dataset and preparations scripts

## Functions

- Added `code_states()` to extract state IDs from a character vector
