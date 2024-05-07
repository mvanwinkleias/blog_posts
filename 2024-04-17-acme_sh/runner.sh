#!/bin/bash

. bash_lib.sh

# printf_hex_to_char '41'
# printf "\n"

# printf_char_to_dec 'A'
# printf "\n"

# Tests happen in ASCII order

function local_test_convert_hex_to_url
{
convert_hex_to_url '2d' # '-' - hyphen.  Should come through.
convert_hex_to_url '2e' # '.' - dot.  Should come through.

convert_hex_to_url '40' # '@' - should stay 40
convert_hex_to_url '41' # 'A' - should come through.
convert_hex_to_url '5A' # 'Z' - should come through.
convert_hex_to_url '5b' # '[' - should stay 5b

convert_hex_to_url '5f' # '_' - underscore.  Should come through.

convert_hex_to_url '60' # '`' - backtick.  Should stay 60
convert_hex_to_url '61' # 'a' - should come through
convert_hex_to_url '7a' # 'z' - should come through
convert_hex_to_url '7b' # '{' - should stay 7b

convert_hex_to_url '7e' # '~' - tilde.  Should come through.
printf "\n"
}

test_convert_hex_to_url
