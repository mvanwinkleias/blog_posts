#!/bin/bash

user=$(head -n1 config.txt)
pass=$(tail -n1 config.txt)

printf "User: %s\nPass: %s\n" "$user" "$pass"

