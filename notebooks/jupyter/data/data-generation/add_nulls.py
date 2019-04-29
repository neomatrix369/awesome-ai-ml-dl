import pandas as pd
import numpy as np
import random
import sys

column_names = sys.argv[1]
source_file = sys.argv[2]
target_file = sys.argv[3]

def generate_random_sample(source_list=range(0, 10), max_number_of_choices=5):
    return random.sample(set(source_list), random.randint(1, max_number_of_choices))

def create_rows_with_random_nulls(source_dataframe, num_of_rows=50, random_seed=42):
    random.seed(random_seed)
    
    random_rows = source_dataframe.sample(n=num_of_rows).copy()

    maximum_rows = random_rows.shape[0]
    maximum_columns = random_rows.shape[1]
    columns_to_fill = [random.choice(random_rows.columns) for dummy in generate_random_sample(source_list=range(0, maximum_columns), max_number_of_choices=maximum_columns)]

    for column in columns_to_fill:
        rows_to_fill = generate_random_sample(source_list=random_rows.index.values, max_number_of_choices=maximum_rows)
        for row in rows_to_fill:
            random_rows.loc[row, column] = np.nan

    target_dataframe = pd.concat([source_dataframe, random_rows])
    return target_dataframe

names = [line.strip() for line in open(column_names, 'r')]

print("Column names", names)
print("Reading source dataset {}".format(source_file))
data = pd.read_csv(source_file, names=names)

new_data = create_rows_with_random_nulls(data)

null_entries = new_data.shape[0] - data.shape[0]
print("Writing to target dataset {} ({} null entries created)".format(target_file, null_entries))
new_data.to_csv(target_file, sep=',', index=False, header=False)