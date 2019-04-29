#!/bin/bash

set -e
set -u
set -o pipefail

echo "Creating archive for Boston Housing dataset."
time zip boston_housing_dataset.zip \
         column.header housing*.*
echo "Finished creating archive for Boston Housing dataset."