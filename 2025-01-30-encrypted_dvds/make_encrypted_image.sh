#!/bin/bash


function debug
{
	cat << EOF
dest_file: $dest_file
EOF
}

function usage
{
	cat << EOF
USAGE:
$0 path1 [path2 ...] dest_image
EOF
}

argc=${#@}

# printf "argc: $argc\n"

if (( argc < 2 ))
then
	>&2 printf "Not enough arguments.\n"
	usage hello
	exit 1
fi

dest_file="${@: -1}"

# debug

# usage
