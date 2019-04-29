## Data Generation

### Purpose

Create an unclean (tainted) version of the Boston Housing Dataset, from the clean version that can be found at https://raw.githubusercontent.com/jbrownlee/Datasets/master/housing.csv. 

This is useful for performing and experimenting a number of data cleaning actions on the dataset.

### Scripts

The scripts are hard-coded for the purpose of creating an unclean dataset from the Boston Housing Dataset.

- [make-dataset-unclean.sh]() - create the unclean dataset from the provided Boston Housing dataset
    - [add_nulls.py]() - extracts a sample set of rows from the provided dataset and adds nulls randomly across the rows and columns. And creates a new dataset with rows from the original and tainted rows concatenated 
    - [add_duplicates.py]() - extracts a sample set of rows from the provided dataset. And creates a new dataset with rows from the original and duplicated rows concatenated
- [create-archive.sh]() - creates the artifact 
- [release-to-github.sh]() - pushes the `boston_housing_dataset.zip` artifact to the GitHub repo, requires the repo's GitHub token made available in the environment

### Data files

- `housing.csv`: downloaded from Jason Brownlee's git repo (see above)
- `column.header`: created manually
- `housing.names`: downloaded from Jason Brownlee's git repo (see above)
- `housing-unclean.csv`: generated using the above scripts, see [above](README.md#scripts), since we don't have access to the original raw dataset which might have been unclean. 

### Artifact

- `artifacts` folder
- `boston_housing_dataset.zip`