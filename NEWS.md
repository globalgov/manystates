# qStates 0.0.1

## Package

- Updates the name from data slabs to datasets.
- Cleans the package of redundant files.
- Changes the references from qDatr to qData.
- Closes #12 by updating tests to work with new dataset and database format
- Added a `NEWS.md` file to track changes to the package.

## Data

- Added the Correlates of War (COW) dataset and preparations scripts, documentation and tests
- Added the International Systems Dataset (ISD) dataset and preparations scripts and tests
- Added the Gleditsch & Ward dataset (GW)  dataset and preparations scripts and tests
- Corrected the datasets and exported them using `qData::export_data()` to form the states database
- Closes #7 by loading the GW dataset into a usable .rda object.
- Closes #6 by loading the ISD dataset into a usable .rda object.
- Closes #13 updating the loaders of the COW, GW, and ISD datasets

# qStates 0.0.0

- Closes #2 by adding and updating initial documentation as CONTRIBUTING, COC, License, and pull request templates
- Created the package structure and files using `qData::setup_package()`