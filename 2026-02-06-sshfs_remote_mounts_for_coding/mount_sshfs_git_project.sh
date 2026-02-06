#!/bin/bash

remote_host="localhost"

# In this case, we don't have separate users on the remote box
# so we use ~/user/ to store things in for 
remote_user="remote-user"
remote_user_home_dir="/home/$remote_user"
ssh_identity="~/.ssh/some-dir/id_rsa"
remote_user_dir_name="$USER"
depot_dir="src_sshfs/git/gitlab.com/git_org/org_group/"
remote_base_dir="$remote_user_home_dir/remote_users/$remote_user_dir_name/$depot_dir"


remote_dir="$1" ; shift

available_dirs=$( \
	ssh -i "$ssh_identity" \
		"$remote_user"@"$remote_host" \
		ls "$remote_base_dir" \
)


if [[ -z "$remote_dir" ]]
then
	>&2 printf "Specify directory to mount:\n"
	printf "$available_dirs\n";
	exit 1
fi

what_grep_found=$(
	printf "$available_dirs\n" \
	| grep -E "^$remote_dir\$" \
)
grep_result="$?"

if [[ -z "$what_grep_found" ]]
then
	>&2 printf -- "grep was unable to find the remote directory: $remote_dir\n"
	>&2 printf -- "\nHere are the available directories:\n"
	>&2 printf -- "$available_dirs\n"
	exit 1
fi

sshfs \
	"$remote_user"@"$remote_host":"$remote_base_dir"/"$remote_dir" \
	./"$remote_dir" \
	-o IdentityFile="$ssh_identity" \

