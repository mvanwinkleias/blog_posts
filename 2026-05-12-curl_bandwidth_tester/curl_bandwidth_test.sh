#!/bin/bash

# tftp_server="kickstart2.net.ias.edu"
# test_data_file="/test_data/random_1mb.data"

# curl tftp://kickstart2.net.ias.edu/test_data/random_1mb.data

now=$(date "+%Y-%m-%d--%H:%M:%S")

curl_output=$( \
curl "$@" \
--silent \
-o /dev/null \
--write-out "$now\t%{time_total}\t%{speed_download}\t%{size_download}\n" \
)

printf "timestamp\ttime_total\tspeed_download(MB/s)\tsize_download(MB)\n"

printf "%s" "$curl_output" \
| awk '{printf "%s\t%.2f\t%.2f\t%.2f\n",
	$1,
	$2,
	$3/(1024*1024),
	$4/(1024*1024)
}'
