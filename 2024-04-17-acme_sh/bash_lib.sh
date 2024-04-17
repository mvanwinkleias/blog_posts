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
	local test_input # Things to be converted
	declare -a test_input

	local good_output # Expected values of conversion
	declare -a good_output

	local test_result
	declare -a test_result
	# Tests happen in ASCII order

	test_input+=( '2d' ) # '-' should come through
	good_output+=( '-' )

	test_input+=('2e') # '.' - should come through
	good_output+=('.')

	test_input+=('40') # '@' - should be hex
	good_output+=('%40')

	test_input+=('41') # 'A' - should come through
	good_output+=('A')

	test_input+=('5a') # 'Z' - should come through
	good_output+=('Z')

	test_input+=('5b') # '[' - should be hex
	good_output+=('%5b')

	test_input+=('5f') # '_' - should come through
	good_output+=('_')

	test_input+=('60') # '`' - should be hex
	good_output+=('%60')

	test_input+=('61') # 'a' - should come through
	good_output+=('a')

	test_input+=('7a') # 'z' - should come through
	good_output+=('z')
	
	test_input+=('7b') # '{' - should stay 7b
	good_output+=('%7b')

	test_input+=('7e') # '~' - should come through
	good_output+=('~')

	printf "Test input: %s\n" "${test_input[*]}"
	printf "Good output: %s\n" "${good_output[*]}"

	for test_value in "${test_input[@]}"
	do
		# printf "Testing: $test_value\n"
		test_result+=( $( convert_hex_to_url "$test_value" ) )
	done
	printf "Test result: %s\n" "${test_result[*]}"
		
}
