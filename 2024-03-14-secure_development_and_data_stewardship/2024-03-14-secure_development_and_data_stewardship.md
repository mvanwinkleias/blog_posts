# Secure Development and Data Stewardship

In my opinion, Data Stewardship is the largest hurdle for developing software securely.

You could argue that everything is technically Data Stewardship, but that casts an opaque wall in
front of understanding what the actual issues with Data Stewardship are.


## Data Stewardship's Main Elements

### Sensitivity

It can be very dangerous to store sensitive information inside of a repository.

### Cost

It can be very expensive to store too much data inside of a repository.

## Data Sensitivity

It's not a good idea to rely on git ignoring sensitive data.  It's best to not get sensitive
data anywhere near the repository where it could be checked in, and shipped out.

Keep sensitive data away from your repository.

### Credentials

Credentials (for example) can be located in ```~/.config/CompanyName/``` where that directory
is readable by only the current user.

Programs can be written to look for files containing credentials by default in that directory. 

### Turing Complete Configuration Is Bad

Reasons:

* Static analysis is hard on Turing Complete things
* UNLESS you've made something that makes static analysis of a specific format easy

The long story short is that Turing Complete things can do anything and that's hard
to analyze, unless you've come up with a standardized way of doing those things.
And if you've come up with a standardized way of doing those things (such as configuration)
it doesn't need to be Turing Complete.

This allows you to isolate areas that "code" can creep in from.

## The Separation of Production Data, Test Data and Logs

Create a standard repository layout and ```.gitignore``` files which ignore the locations where
transient data might be stored inside of the repository.

Write libraries for programs to use which automatically endow programs with knowledge of the
standardized layouts.

Here is the layout that I use:

```
sample_layout/
├── src
│   ├── input  # Doesn't get checked in
│   ├── log    # Doesn't get checked in
│   └── output # Doesn't get checked in
└── tests
    └── data   # Gets checked in
```

Here is a corresponding section of ```.gitignore``` file:

```
/src/input
/src/output
/src/log
```

This allows me to check out a project, and (for example) symbolically link where input, output,
and log files should go.

Sometimes programs will create those directories by default

### Input, Output

There are a lot of programs that fit a model that reads files as the form of Input
and/or write files in the form of Output.

For example:
* A program can load a CSV (input file) into a database.
* A program can dump a database to a CSV (output file)
* A program can search for records in an input file and output relevant records in an output file
* and so on

Having standard ways to refer to common places in your program, such as ```get_input_dir()``` and
```get_output_dir()``` can be a big step toward standardizing repository layouts.

### Test Data

Standards for test data should be created.  Such as:

* Must have sensitive information redacted
* Must be small enough so that tests complete in a reasonable amount of time
* Must be stored in a standard location

### Logs

Abstracting logging so that the programmer only has to run (say) ```write_log_info("Processing ....")```
helps standardize Data Stewardship issues:  The understanding is that the message is being logged
(to somewhere) and (hopefully) sensitive information should not find its way into log files.

Try to discourage the use of print statements to debug code that's in production.  Most times
a simple implementation of (say) ```write_log_debug("We are at this stage...")``` is what was needed
with the ability to increase / decrease logging verbosity.


