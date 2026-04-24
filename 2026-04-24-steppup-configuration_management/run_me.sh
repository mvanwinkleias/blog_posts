#!/bin/bash

targets=$( ./git_pull_and_signal.sh \
        "signal_apache_config_has_changed" \
        "origin master --quiet" \
        /etc/httpd/conf.d \
	/etc/httpd/2nd \
	/etc/httpd/3rd \
)
result=$?

printf "Result: $result\n"
printf "====\n"
printf "Targets: $targets\n"
printf "===\n"

if [[ "$result" == 0 ]]
then
	printf "%s " "$targets" | xargs ./apache_control.mk
fi

