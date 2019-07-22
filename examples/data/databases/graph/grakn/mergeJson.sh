#!/bin/bash

set -e
set -u
set -o pipefail

python -c '

import json

import glob



json_files = glob.glob("*.json")

output = [json.load(open(file)) for file in json_files]

json.dump(output, open("report.json", "w"), indent=4)

'