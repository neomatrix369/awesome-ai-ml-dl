import pandas as pd
import numpy as np
import random
import sys

column_names = sys.argv[1]
source_file = sys.argv[2]
target_file = sys.argv[3]

def duplicate_rows(source_dataframe, num_of_rows=50, random_seed=42):
    maximum_rows = source_dataframe.shape[0]
    random.seed(random_seed)
    
    random_indices = [random.randrange(0, maximum_rows) for a_random_value in range(num_of_rows)]
    random_rows = source_dataframe.iloc[random_indices].copy()

    target_dataframe = pd.concat([source_dataframe, random_rows])

    return target_dataframe

names = [line.strip() for line in open(column_names, 'r')]

print("Column names", names)
print("Reading source dataset {}".format(source_file))
data = pd.read_csv(source_file, names=names)

new_data = duplicate_rows(data)

duplicate_entries = new_data.shape[0] - data.shape[0]
print("Writing to target dataset {} ({} duplicate entries created)".format(target_file, duplicate_entries))
new_data.to_csv(target_file, sep=',', index=False, header=False)