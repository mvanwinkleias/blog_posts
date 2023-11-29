# Modular Code Rant

Programs must be modular in order to be maintainable.
When developing programs, you need to separate your code into Libraries.

The "leap" occurs when you realize that the up front work of putting all of your
code into a library (except for a few lines to set up an environment, and load that
library) ends up being much more maintainable than putting everything in the same
(gosh-darn) file.

The cognitive load of organization can be too much to handle when you're trying to Get Something Done.
Boilerplate code, along with a basic knowledge of how to follow and implement patterns are your friend.

If it is too difficult for you to adequately code in a modular way when you need to Get Something Done,
then you should invest time (outside of the GSD mindset) analyzing how to make program organization
easy when you are in the GSD mindset.

## Libraries

Logic can be broken down into (but not limited to):

* Filesystem - how to organize and where to find files (configuration, logging, input, output)
* Configuration - environment specific, debugging
* Individual Systems - such as standardizing an interface to OpenSSL
* Business - combines all of the above into functional units

## Filesystem Organization

It would be nice if you knew which files are to be:

* executed
* loaded as configuration files
* processed as input files
* written to as log files

It'd be pretty cool if programs saved their output to standardized places as well.
This helps you perform cleanup operations, and, sometimes you can link one program's
output directory to another program's input directory.

## Filesystem Self-Awareness

How does a program "find" it's configuration and libraries?

We must first look at what the program is aware of when it runs.

It knows its current working directory, and it knows how it was run.

From there, you can calculate relative paths to the useful directories as listed above.

In order to keep a program file's logic simple, one method for "finding" all of that
stuff is to only program what's necessary to load an "include" file, and get right to business.

The include file, (for bash, I call it something like *bash_lib.bash* or *bashlib.sh*)
then calculates the configuration, library, input, output, and logging locations.


