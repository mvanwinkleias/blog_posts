#!/usr/bin/python3

import csv
import sys

data = [
    {'first_name': 'Baked', 'last_name': 'Beans'},
    {'first_name': 'Lovely', 'last_name': 'Spam'},
    {'first_name': 'Another', 'last_name': 'Something', 'extra' : 'this is extra'},
    {'first_name': 'Wonderful', 'last_name': 'Spam'}
]

fieldnames = ['first_name', 'last_name', 'extra']

writer = csv.DictWriter(
    sys.stdout,
    fieldnames = fieldnames,
    restval = '',
)

writer.writeheader()
for row in data:
    writer.writerow(row)
