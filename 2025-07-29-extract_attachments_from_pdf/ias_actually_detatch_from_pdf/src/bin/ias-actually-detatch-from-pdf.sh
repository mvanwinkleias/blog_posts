#!/bin/bash

# actually_detatch.sh 'password' some_file.pdf output_dir
# pdfdetach might have problems extracting files with / in them

pdf_passwd="$1" ; shift
pdf_file="$1" ; shift
dst_path="$1" ; shift

if [[ -z "$dst_path" ]]
then
	dst_path='.'
fi

list_output=$( pdfdetach -list -opw "$pdf_passwd" "$pdf_file" | tail -n +2)
result=$?

if [[ "$result" != "0" ]]
then
	>&2 printf "pdfdetatch failed.\n"
	exit 1
fi

# count=$( printf "$list_output" | head -n1 | awk '{print $1}')
# printf "Count: $count\n"


# printf "List output: \n$list_output\n"

while IFS= read -r line
do
	# printf "$line\n";
	number=$( printf "$line" | awk -F':' '{print $1}' )
	# printf "Number: $number\n"
	file=$( printf "$line" | sed 's/^[0-9]\+: //' )
	# printf "File: \n$file\n"
	dirname=$( dirname "$file" )
	mkdir -p "$dst_path/$dirname"
	extracted_name="$dst_path/$file"
	
	pdfdetach -save "$number" -o "$extracted_name" -opw "$pdf_passwd" "$pdf_file"
done <<< "$list_output"
