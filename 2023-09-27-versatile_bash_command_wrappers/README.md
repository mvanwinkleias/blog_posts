# Wrapping a bash command

Of interest are 2 ways some commands process input and command line options.

One is to have standard input redirected to them, like a pipe:

```bash
$ some_program | another_program
```

One is to be able to pass in a file name
```bash
$ another_program --input-file some_program_output.txt
```

When you wrap *another_program* with Bash, you want to preserve the
options to pipe stuff in AND to pass arguments to it.

## Scenario: Looking through a log file for something

There is a common string we'd like to search a log file for:
```
SASL LOGIN authentication failed
```

How do we wrap that in a function so that we can pass parameters
to grep AND be able to pipe things into it as well?

### Full code listing:

```bash
function get_sasl_login_authentication_failed
{
	local all_arguments=( "$@" )
	local wrap_command=(
		grep
		'SASL LOGIN authentication failed'
	)

	if ((${#all_arguments[@]}));
	then
		wrap_command+=( "${all_arguments[@]}" )
	fi

	"${wrap_command[@]}"
}
```

### Commented:

function get_sasl_login_authentication_failed
{
		# The first thing we do is save all of the arguments
		# passed to us.  We want to preserve these, so the sooner
		# the better.

        local all_arguments=( "$@" )

		# We start setting up the array we will use to 
		# run the command
        local wrap_command=(
                grep
                'SASL LOGIN authentication failed'
        )

		# If there are arguments that we want to pass to the program

        if ((${#all_arguments[@]}));
        then
				# Then for this particular program, just tack them on
				# to the array that contains what to run

                wrap_command+=( "${all_arguments[@]}" )
        fi

		# Run the entire array.
        "${wrap_command[@]}"
}

