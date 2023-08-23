# A Simple Infrastructure Script That I'd Cron Up

This is a "short" example of a set of script files that are
how I'd begin to start building a Bash scripting infrastructure.

It consists of 2 files.  After the full source code listing
documentation on a section-by-section basis is provided.

The first is a script that "only" downloads a web page; but adds
much more value, from the perspective of Infrastructure, because
it behaves like a good Unix script, and it logs.

Good Unix scripts:
* Only produce output to STDOUT when something doesn't
"go right", or when a verbose flag is passed in
* Exit with a non-zero status if something went wrong.

The second is a Bash library that is used by the script.

It contains Infrastructure functionality that allows for consistency
and code reuse.

## License
copyright (C) 2022 Martin VanWinkle, Institute for Advanced Study

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

See

http://www.gnu.org/licenses/
# ias-download-google.sh
## Full Code Listing

[//]: # (Generated: Generated: Wed 16 Aug 2023 01:07:42 PM EDT)
```bash
#!/bin/bash

all_arguments=( "$@" )

script_dir=$(dirname $(realpath "$0"))
. "$script_dir/bash_lib.sh" || exit 1

url=${1:-"https://www.google.com"} ; shift

output_dir=${output_dir:-$(get_output_dir)}
output_file_name=${output_file_name:-$(get_output_file_name)}

write_log_start "$all_arguments"

mkdir -p "$output_dir" || {
	write_log_error "Error: Couldn't mkdir $output_dir"
	write_log_end
	exit 1
}

write_log_informational "Fetching url: $url to $output_file_name"
curl --silent "$url" > "$output_file_name"
result=$?

if [[ "$result" != "0" ]]
then
	write_log_error "I couldn't curl $url"
	write_log_end
	exit 1
else
	write_log_informational "Success."
fi

write_log_end

exit $result
```
Most of the code at the top is boiler-plate and doesn't change
much, if at all, from program to program.
## Saving / Copying Arguments
The first thing we do is save a copy of the arguments to the script.
This comes in handy when you want to log the arguments the script was run with.

```bash
#!/bin/bash
all_arguments=( "$@" )
```
## Loading A Library Relative to the "True" Location of the Script
We figure out the full path to the directory containing the script.
This allows us to symbolically link the script somewhere else, and still
load our library code.

```bash
script_dir=$(dirname $(realpath "$0"))
```
Then we load our library:

```bash
. "$script_dir/bash_lib.sh" || exit 1
```
## Argument Handling
The first argument to the script is the URL to download.

```bash
url=${1:-"https://www.google.com"} ; shift
```
## Setting Up Output Directories and File Names
bash_lib.sh contains (simple) subroutines for us that automatically
"know" where it should place files based off of the name of the script.

```bash
output_dir=${output_dir:-$(get_output_dir)}
output_file_name=${output_file_name:-$(get_output_file_name)}
```
## Writing A Log Start Message
After we've set up some variables, (i.e. things that shouldn't take much time)
we write a log start message.  The log start message contains things like:
* current working directory
* arguments

```bash
write_log_start "$all_arguments"
```
## Output Directory Creation (If Needed)
If we can't confirm that the output directory exists, we should exit.

```bash
mkdir -p "$output_dir" || {
	write_log_error "Error: Couldn't mkdir $output_dir"
	write_log_end
	exit 1
}
```
## The actual Work...
We log that we're about to start some process, and we save the result in a variable.
(Sometimes you want to check if the command has succeeded after running another
set of commands, so you save the result.)

```bash
write_log_informational "Fetching url: $url to $output_file_name"
curl --silent "$url" > "$output_file_name"
result=$?
```
## Check If It worked
Here, if things didn't go as expected, we:
* log the error
* write the log end
* exit with non-zero status

```bash
if [[ "$result" != "0" ]]
then
	write_log_error "I couldn't curl $url"
	write_log_end
	exit 1
```
If it did work, we log that it worked (yay).

```bash
else
	write_log_informational "Success."
fi
```
## Lastly
We write the log end message, and here we exit with the same exit value
that curl gave us; which effectively just makes this a "fancy" wrapper
for curl.

```bash
write_log_end

exit $result
```
# bash_lib.sh
## Full Code Listing
```bash
#!/bin/bash

output_base_dir=${output_base_dir:-/var/tmp}

# Logging functionality
function write_log_informational
{
	logger "$0 [$$] $@"
}

function write_log_start
{
	write_log_informational "$0 $$ $LOGNAME PWD: $(pwd) ---STARTING--- arguments: $@"
}

function write_log_end
{
	write_log_informational "$0 $$ $LOGNAME --ENDING---"
}

function write_log_error
{
	local msg="$@"
	msg=$(date)
	msg="${msg} : $@"
	>&2 printf "%s\n" "$msg"
	write_log_informational "$@"
}


# Returns the script name without the extension.
function get_script_name
{
	script_name=$( basename -- "$0" )
	script_name="${script_name%.*}"
	printf "%s" "$script_name"
}

function get_output_dir
{
	local script_name
	script_name=$( get_script_name )
	local output_dir="${output_base_dir}/$script_name"
	printf "%s" "$output_dir"
}

function get_output_file_name
{
	local label="$1"; shift
	label=${label:-generic.txt}
	local timestamp
	timestamp=$( date '+%Y-%m-%d-%H-%M-%S' )
	printf "%s" "$( get_output_dir)/${timestamp}-${label}"
}
```
## Configuration Variables
Normally we wouldn't combine configuration variables and functional
code in the same file.  But, for simplicity's sake, we can.

```bash
#!/bin/bash
output_base_dir=${output_base_dir:-/var/tmp}
```
## Logging
Here we define our logging functionality.  All of our logging code
goes through one subroutine which calls *logger* .  If you don't
want to use syslog, that's fine.  This is just an example.

```bash
# Logging functionality
function write_log_informational
{
	logger "$0 [$$] $@"
}
```
### Log Start
When an "infrastructure" program starts, you want to know:
* the path to the program and the program name
* the pid
* the name of the user running the script
* the current working directory of the script
* the arguments

This might not be all-inclusive, but it's a very good start.

```bash
function write_log_start
{
	write_log_informational "$0 $$ $LOGNAME PWD: $(pwd) ---STARTING--- arguments: $@"
}
```
### Log End
You want to know the name of the program, process ID, and the user.
Some of it is redundant, but it helps to keep track of things.

```bash
function write_log_end
{
	write_log_informational "$0 $$ $LOGNAME --ENDING---"
}
```
### Error Logging
How you handle error logging is up to you.
This code prints to STDERR, as well as doing an informational log.

More expansive libraries might use different syslog levels for logging errors.
This was designed to be simple.

```bash
function write_log_error
{
	local msg="$@"
	msg=$(date)
	msg="${msg} : $@"
	>&2 printf "%s\n" "$msg"
	write_log_informational "$@"
}
```
## Output Functionality
You'll spend a lot of your time coming up with directory names and
output file names.  These subroutines eliminate that from your workflow
by basing these names off of the script name.
### The Script Name
A way of making this all tie together is to have output directories
named after the name of the script that's being run.  That way
multiple scripts with different names have different output directories.

```bash
# Returns the script name without the extension.
function get_script_name
{
	script_name=$( basename -- "$0" )
	script_name="${script_name%.*}"
	printf "%s" "$script_name"
}
```
### Output Directory
The name of the output directory is based off of the name of the script.
This allows you to have many scripts with different names that can say,
"What's my output directory?" and not conflict with one-another.

```bash
function get_output_dir
{
	local script_name
	script_name=$( get_script_name )
	local output_dir="${output_base_dir}/$script_name"
	printf "%s" "$output_dir"
}
```
### Output File Names
Most times you want a timestamp, and a simple way of specifying
the label of the file.  This does that.

```bash
function get_output_file_name
{
	local label="$1"; shift
	label=${label:-generic.txt}
	local timestamp
	timestamp=$( date '+%Y-%m-%d-%H-%M-%S' )
	printf "%s" "$( get_output_dir)/${timestamp}-${label}"
}
```
## Conclusion
This code, for the most part, is self-documenting.

If you cron it up, it should be quiet unless it runs into problems.

Also, because a lot of the functionality was abstracted into a library
you could put the library into a separate project, and install it
so other programs could use it.
