#!/bin/bash

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

echo "SCRIPT_PATH: " $SCRIPT_PATH

cd "$SCRIPT_PATH"

dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz

