#!/bin/bash

user=$(jq --raw-output '.db_user' config.json)
pass=$(jq --raw-output '.db_pass' config.json)

printf "User: %s\nPass: %s\n" "$user" "$pass"
