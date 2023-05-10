# Package Shell Walkthrough

## Introduction

### Elevator Pitch - 1

This presentation is about leveling up.

The ENTIRE presentation can be summed up with:

* Use a project template system.
* Put it in git.
* Put files in the right place.

THAT'S IT.

### Elevator Pitch - 2

It is centered around "my" project template.

So, what's with all of the "extra" stuff?

Let's say you have a simple script.  You might not be interested in:

* shared libraries
* configuration files
* generating artifacts

... but why hold yourself back?

### Elevator Pitch - 3

* You can ignore the extra stuff.
* 99% of the work has been done for you.
* Just put files in the right place.

### Elevator Pitch - 4

If you have absolutely no interest in leveling up,
you don't need to be here.

### Mostly How, Some Why

I will be walking through the steps to create a project.

The rationale for a lot of things will be left out.

Just please trust that this is worth your time.

If you're aware of something better, please tell me.

### Target Audience

* All programmers (who care)

You must at least be familiar with how to navigate a filesystem.

# Presentation

## Muddling Your Way Through - A BIG "Why"

Why you should ALWAYS use a project template system.

### A "First" Project - 1

Let's say you need to write a script that does something.

```bash
#!/bin/bash

printf "%s\n" "Hello!"
```

So you put it in a repo:

```
project_1/
└── hello.sh
```

### A "First" Project - 2

But, there's a problem.  You accidentally checked in some temporary files
that your editor created.  So, you add a ```.gitignore``` file.

```
project_1/
├── .gitignore
└── hello.sh
```

### A "First" Project - 3

Now you need to add a README.md file.

```
project_1/
├── .gitignore
├── hello.sh
└── README.md
```

### Repeated Organic Growth

After a while "repeated organic growth" can lead to
inconsistencies between all of your projects.

### A "First" Project - 4

I could go on.  But you'll notice that a lot of work that
you do with a project isn't actually related to the thing
you originally set out to do.

That, and everything is in the "root" of the project.
There's no organization here.

### Basic Assumptions

* You live in an ecosystem.
> ecosystem - (in general use) a complex network or interconnected system. - google
* Ecosystems are complicated.
* Simply creating a script and putting it into a VCS is no longer sufficient.

### A "First" Project - Conclusion

There are any number of tings that can go wrong
with creating ancillary files for a project.

* Complexity can lead to problems. (Human error)
* Computers Can Handle Complexity.
* Let the computer do the work.

You SHOULD use a template system.

## Template Systems

### A Good Template

A good template should:

* Create (all of) the ancillary files for a project
* have clear definitions for where files go
* Work out of the box

## Getting Stuff Done

Without further ado, let's get in to how to actually
get stuff done.

### Creating a Project

* Run ```ias_package_shell.pl``` .
* Answer questions.
* Profit.

```
$ ias_package_shell.pl 
####################
#   Project Name: 
Contains only letters, numbers and underscores.  Required.
Enter Response: project_1
####################
#   Summary: 
Short description of project.  Required.
Enter Response: Example project
####################
#   Wiki page: 
External documentation.
Enter Response: 
####################
#   Ticket: 
Link to ticket, or ticket ID
Enter Response: 
$
```

### What You Get

You get a lot of things that have already been organized for you.

```
project_1/
├── artifacts
├── aspell_project.pws
├── doc
├── .editorconfig
├── examples
├── .gitignore
├── LICENSE
├── Makefile
├── package_shell
├── README.md
├── spell_check.sh
├── src
└── tests
```

### But Where's My Script?!

It's there:

```
project_1/src/
└── bin
    └── project-1_hello.sh
```

### That's ... A Lot

* You don't have to know everything.
* Just put your scripts in ```src/bin/```
* Check the project into git (or subversion)

Then you're on your way.

## Let's Talk Layouts


### Just Put Things In The Right Place

The solution to a layout problem is to define where
things should go if they are to become part of
the project.

### Major Distinction

The first "major" distinction in a layout should be "ancillary"
vs "source code".

### Major Distinction - Ancillary files

These things can include:

* ```.gitignore```
* ```README.md```
* Build scripts
* License files
* Editor configuration files
* Tests

etc

### Major Distinction - Source Files

Everything under the ```src``` directory

### The ```src``` Directory

There are pre-defined directories where if you create them
certain things "automatically" happen, and it helps with
knowing what purpose those files serve.

* ```src/bin/``` - Stuff you run
* ```src/lib/``` - Libraries
* ```src/etc/``` - Project level configuration
* ```src/root_etc/``` - "Root" level configuration

#### ```src/lib```

* These files are installed into ```/opt/IAS/lib``` .
* They must not conflict with other installed libaries.

#### ```src/etc/```

* These files are installed into ```/opt/IAS/etc/project-name``` .

For RPM based systems, they are set to config replace.

#### ```src/root_etc/```

* These files are installed into ```/etc/```

For RPM based systems, they are set to config no-replace.

#### The ```src``` Directory - Conclusion

There are other directories that can be created
and things "automatically" happen.

Those might not be covered in this presentation.

