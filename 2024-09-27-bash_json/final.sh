#!/bin/bash

function create_associative_array_from_json_string
{
	local -n aarr="$1" ; shift
	local json_string="$1" ; shift

	local key

	local count=0

	local entry
	for entry in $( printf "%s" "$json_string" | jq 'to_entries[] | .key, .value' )
	do

		if [[ $((count%2)) == 0 ]]
		then
			key="$( printf "%s" "$entry" | jq --raw-output '.+"x"' )"
			key=${key%x}
		else
			value="$( printf "%s" "$entry" | jq --raw-output '.+"x"' )"
			value=${value%x}
			aarr["$key"]="$value"
		fi
		count=$((count+1))

	done
}

declare -A config
create_associative_array_from_json_string config "$( cat config.json)"

printf "User: %s\nPass: %s\n" "${config[db_user]}" "${config[db_pass]}"
# declare -p config
