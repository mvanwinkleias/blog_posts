#!/usr/bin/bash

function printf_hex_to_char
{
	printf "\x$1"
}

function printf_char_to_dec
{
	printf "%d" "'$1"
}

function is_in_range
{
	local low ; low="$1" ; shift
	local high ; high="$1" ; shift
	local value ; value="$1" ; shift

	if (( value >= low && value <= high ))
	then
		return 0
	fi
	return 1
}

function convert_hex_to_url
{
	local _hex_code; _hex_code="$1" ; shift

	local converted; converted=$( printf_hex_to_char "$_hex_code" )
	
	local converted_dec ; converted_dec=$( printf_char_to_dec "$converted" )

	local dec_A; dec_A=$( printf_char_to_dec 'A')
	local dec_Z; dec_Z=$( printf_char_to_dec 'Z')

	local dec_a; dec_a=$( printf_char_to_dec 'a')
	local dec_z; dec_z=$( printf_char_to_dec 'z')

	local dec_0; dec_0=$( printf_char_to_dec '0')
	local dec_9; dec_9=$( printf_char_to_dec '9')

	# Comparisons: Ranges should be tested first (in ASCII order) to increase
	# chance of earlier hit.
	#
	# Individual comparisons happen later (in ASCII order).
	if is_in_range "$dec_A" "$dec_Z" "$converted_dec" \
		|| is_in_range "$dec_a" "$dec_z" "$converted_dec" \
		|| is_in_range "$dec_0" "$dec_9" "$converted_dec" \
		|| [[ "$converted" = '-' ]] \
		|| [[ "$converted" = '.' ]] \
		|| [[ "$converted" = '_' ]] \
		|| [[ "$converted" = '~' ]] 
	then
		printf '%s' "$converted"
	else
		printf '%%%s' "$_hex_code"
	fi
}

function test_convert_hex_to_url
{
	
}
