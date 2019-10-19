#!/bin/bash

#
# Copyright 2019 Mani Sarkar
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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