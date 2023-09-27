#!/bin/bash

function get_sasl_login_authentication_failed
{
	local all_arguments=( "$@" )
	local wrap_command=(
		grep
		'SASL LOGIN authentication failed'
	)

	if ((${#all_arguments[@]}));
	then
		wrap_command+=( "${all_arguments[@]}" )
	fi
	
	"${wrap_command[@]}"
}

function get_log_date
{
	all_arguments=( "$@" )

	date_command=(
		date \
		'+%Y%m%d' \
	)

	if ((${#all_arguments[@]}));
	then
		date_command+=( "${all_arguments[@]}" )
	fi

	"${date_command[@]}"

}



get_log_date "$@"
