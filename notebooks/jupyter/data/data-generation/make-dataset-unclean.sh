#!/bin/bash

set -e
set -u
set -o pipefail

if [[ ! -s "column.header" ]]; then
	cat > column.header <<EOF
crim
zn
indus
chas
nox
rm
age
dis
rad
tax
ptratio
b
lstat
medv 
EOF
echo "Column header was missing, created now."
fi

if [[ ! -s "housing.csv" ]]; then
	echo "Downloading the Boston Housing dataset from Jason Brownlee's repo"
	wget https://raw.githubusercontent.com/jbrownlee/Datasets/master/housing.csv
fi

if [[ -s "housing.csv" ]]; then
	echo "~~~~~ Adding nulls to the clean Boston Housing dataset (housing.csv)"
	time python3 add_nulls.py column.header housing.csv housing-unclean.csv
	echo "housing-unclean.csv - now contains nulls"

	echo ""

	echo "~~~~~ Adding duplicates to the clean Boston Housing dataset (housing.csv)"
	time python3 add_duplicates.py column.header housing-unclean.csv housing-duplicates.csv
	rm housing-unclean.csv
	mv housing-duplicates.csv housing-unclean.csv
	echo "housing-unclean.csv - now contains duplicates"	
else
	echo "Unable to load housing.csv, possibly a download failure."
fi