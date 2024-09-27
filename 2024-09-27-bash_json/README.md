# BASH and JSON.

All of the examples (short as they may be) are available in this directory.

## The Overall Problem

I frequently run into off-the-cuff configuration file formats (and locations)
for BASH programs.  As an example:

* config.txt
```
database_user
super_secret_password
```

Which could get read like this:

* [script1&#46;sh](./script1.sh)
```bash
user=$(head -n1 config.txt)
pass=$(tail -n1 config.txt)

printf "User: %s\nPass: %s\n" "$user" "$pass"
```

Well, that doesn't really scale.  And soon (if you have to deal with more
complexity) you'll need to choose between:
* extending the "syntax" of the configuration file
* making another configuration file
* rewriting the program to use something completey different

and so on.

Those options, in turn, create more problems.

So then why not choose a "configuration file format" that accomodates for
growth and is supported by other programming languages?

## Enter JSON

* JSON is excellent for simple configuration files.
* *jq* , a program for (among other things) querying JSON is widely available.

The above example becomes:

* [config.json](./config.json)
```
{
	"db_user" : "database_user",
	"db_pass" : "super_secret_password"
}
```

* [script2&#46;sh](./script2.sh)
```bash
user=$(jq --raw-output '.db_user' config.json)
pass=$(jq --raw-output '.db_pass' config.json)

printf "User: %s\nPass: %s\n" "$user" "$pass"
```

Advantages:
* Other programs can use the configuration file.
* Configuration entries can be added without interfering with other entries.
* You can use *jq* to verify the JSON is syntactically valid.

## "That's more stuff..."

Yes, it is.  And more stuff means more stuff can go wrong.  BUT...

## We Can Do Better

I've written a BASH function that loads a JSON object of 1 depth
into a BASH associative array:

* [final&#46;sh](./final.sh)

```bash
declare -A config
create_associative_array_from_json_string config "$( cat config.json)"

printf "User: %s\nPass: %s\n" "${config[db_user]}" "${config[db_pass]}"
```

Outputs:

```
User: database_user
Pass: super_secret_password
```

## The Code

All you have to do is put this code in your script, or source it somehow. 

```bash

function create_associative_array_from_json_string
{
	local -n aarr="$1" ; shift
	local json_string="$1" ; shift

	local key
	local count=0
	local entry

	for entry in $( printf "%s" "$json_string" | jq 'to_entries[] | .key, .value' )
	do

		if [[ $((count%2)) == 0 ]]
		then
			key="$( printf "%s" "$entry" | jq --raw-output '.+"x"' )"
			key=${key%x}
		else
			value="$( printf "%s" "$entry" | jq --raw-output '.+"x"' )"
			value=${value%x}
			aarr["$key"]="$value"
		fi
		count=$((count+1))

	done
}
```

## That Was The Gist

Stuff that follows is more for pedantry than anything else.

### Loading An Array From JSON

Depending on your opinion of the above, you might call this a bonus (or a curse):

```bash
function create_array_from_json_string
{
	local -n arr="$1" ; shift
	local json_string="$1" ; shift

	local entry
	local value

	for entry in $( printf "%s" "$json_string" | jq -c '.[]' )
	do
		value="$(printf "%s" "$entry" | jq --raw-output '.+"x"' )"
		value=${value%x}
		arr+=( "$value" )
	done	
}
```

## Disclaimer

[BASH has its problems](http://mywiki.wooledge.org/BashWeaknesses) .
While I'm a huge proponent of "use a real programming language", I've found
that the gaps left by that mentality are usually filled by people who don't
know about BASH's weaknesses, or those who are unwilling to put in the
effort to mitigate them.

This "post" is meant to mitigate some of the issues.
