#!/bin/bash

while read line
do
	ls $line
done <"output.txt"
