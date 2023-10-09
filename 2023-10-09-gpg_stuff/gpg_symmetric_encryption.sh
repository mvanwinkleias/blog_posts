#!/bin/bash

dir_to_encrypt="$1"; shift

passphrase_file="$HOME/.config/IAS/certificate_bundle_passphrase.txt"

function gpg_encrypt_stdin_symmetric
{
	local passphrase_file;
	passphrase_file="$1"; shift

	local output_file;
	output_file="$1"; shift

	gpg \
		--batch \
	 	--symmetric \
		--passphrase-file "$passphrase_file" \
		--output "$output_file"

}

function gpg_decrypt_stdout_symmetric
{
	local passphrase_file
	passphrase_file="$1"; shift

	local input_file
	input_file="$1" ; shift

	gpg \
		--batch \
		--symmetric \
		--decrypt \
		--passphrase-file "$passphrase_file"

}
