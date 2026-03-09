#!/usr/bin/jq -rsf

# This is based off of / nearly identical to:
# https://stackoverflow.com/questions/32960857/how-to-convert-arbitrary-simple-json-to-csv-using-jq

# -r - raw output
# -slurp - read the entire input stream into a large array and run
#       the filter just once
# -f - run the stuff in this file
(map(keys) | add | unique) as $cols 
| map(
		. as $row | $cols | map($row[.])
	) as $rows 
| $cols, $rows[] 
| @csv
