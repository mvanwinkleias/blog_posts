#!/bin/bash

signal_names="$1" ; shift
git_options="$1" ; shift

function git_pull_and_signal_usage
{
	>&2 cat <<EOH
	$0 "signal_apache_config_has_changed signal_another_thing" "origin main" dir1 [ dir2 ...]
EOH

}

if [[ -z "$signal_names" ]]
then
	git_pull_and_signal_usage
	exit 1
fi

if [[ -z "$git_options" ]]
then
	git_pull_and_signal_usage
	exit 1
fi

function do_git_work
{
	pull_errors=0

	for dir in "$@"
	do
		pushd . > /dev/null
		cd "$dir"
	
		>&2 git fetch $git_options
		
		if [[ "$(git rev-parse HEAD)" != "$(git rev-parse @{u})" ]]
		then
			>&2 git pull $git_options
			pull_result="$?"
			if [[ "$pull_result" == "0" ]]
			then
				printf "%s\n" $signal_names
			else
				((pull_errors++))
				>&2 printf "Pull errors: $dir $pull_errors\n"
			fi
			# printf "%s\n" $signal_names
		fi
	
		popd > /dev/null
	done
	# printf "Pull errors at end: $pull_errors\n"
	return $pull_errors
}

do_git_work "$@" # | sort | uniq
git_work_result=${PIPESTATUS[0]}
# printf "Git work result: $git_work_result\n"
exit $git_work_result


