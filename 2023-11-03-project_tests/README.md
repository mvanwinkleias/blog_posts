# Tests

While I was establishing how tests could be done within the full
project system I thought about things.  Some of those things
don't belong inside the system itself.

## Forward

Your project is governed by your philosophy.

I haven't put much philosophical ramblings into project templates
for certain reasons; but the main reason is that building systems
that "just work", "do the right thing", and "require as little
work as possible" should speak for themselves.

Tests break that "fourth wall", and require balance in order to
not encumber the programmer.

I believe this layout allows for tests of arbitrary complexity
ranging from very simple to "if you need something else, at
least you're not starting from a nightmare."

Not all "projects" require a rigid and thorough testing infrastructure.
But, the idea behind all of this "Full Project" template stuff
is that you should be able to create a simple project, and "grow"
without experiencing growing pains.

I do believe that large software package repositories should have
a standard for how automated tests are defined, and run, etc.
I believe that something as simple as "just making sure the program
doesn't have syntax errors" should be sufficient for simple things
that have no substantial risk of being deployed with bugs, or there
is little risk to having been deployed with bugs.

To that end, I will eventually be making testing templates that
automatically work the following scenarios:

* [TAP](https://testanything.org) whereby:
	* Running "prove tests/t" in the top level of the project
	should be sufficient for simple things and for the simple
	examples provided.
