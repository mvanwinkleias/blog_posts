# Texinfo sample documentation tree

Every once in a while I "rediscover" Texinfo.

This "post" combines examples that show:

* A Texinfo cross reference to a file in a subdirectory
* Using Make to only run makeinfo on texi files that have changed
* Spell checking with a custom aspell file for the project
	* Unfortunately it doesn't only check files that have changed
		since the last spell checking
* invoking info on the "main" documentation page

I suppose the goal of this was to get to a reasonable point where
I could just start typing and have some sort of basic scaffolding
in place.
