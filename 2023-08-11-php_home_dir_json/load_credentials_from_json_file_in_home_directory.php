<?php

$my_home_dir = posix_getpwnam(
	getenv('LOGNAME') != '' ? getenv('LOGNAME')
	: getenv('USER') != '' ? getenv('USER')
	: null
)['dir'];

$ipam_credentials_file="$my_home_dir/.config/IAS/some-awesome-project/ipam_credentials.json";

# print(realpath('~/bin')."\n");

// print("Home dir: $my_home_dir\n");

$credentials = json_decode(file_get_contents($ipam_credentials_file));

# var_dump($credentials);
