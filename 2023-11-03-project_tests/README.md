# Tests

The solution is to provide examples that:

* Work out of the box
* Are easy to setup and configure

Such that it is easy to demonstrate that the convienence that
is provided is better than not using it.

Having a consistent and published way of doing things is not
a mandate.  I'd like to think that we create tools to make life
easy, and if the tool doesn't make life easier, then it's not
a good tool.  Showing how something can work is not an endorsement.

This is not the same thing as achieving a requisite level of
knowledge in order to abstract complexity:  If somebody on a
team can write tests for software in a way that adds no
encumberance to the development process, then that can be a
good thing.

The point of a lot of this work is to figure out where things
have a tendency to get out of hand when organization and design
of ancillary components take a back seat to work.

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


## When do I need more tests?

* Complexity
* Criticality

### Complexity

The thing does so many things you've lost track of what it's supposed to do

### Criticality

How much failure hurts

## Tests and the toplevel makefile

The way the full project layout works is it's supposed to allow you
to build multiple artifacts from the same project.

Knowing which targets to run for building and testing is a responsibility
of the build environment.
