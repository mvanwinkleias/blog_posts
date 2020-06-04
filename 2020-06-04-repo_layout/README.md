# Repo Layout

A good .gitignore is very important.  Chances are you can make a large one that covers a bunch of
languages, and use it.

Here's how we're going to organize things during this tutorial:

```
.
├── .gitignore
├── README.md
└── src
    ├── bin
    │   ├── some_script.pl
    │   ├── some_script.py
    │   └── some_script.rb
    └── lib
        ├── perl5
        │   └── IAS
        │       └── HelloRepoLayout.pm
        ├── python3
        │   └── IAS
        │       └── HelloRepoLayout
        │           ├── HelloRepoLayout.py
        │           └── __init__.py
        └── ruby2
            └── IAS
                └── HelloRepoLayout.rb
```

# Goals

All of these languages are unrelated, but they use the same layout.

You start from the perspective of accomodating for future growth by organizing
things.  Then you use the design as a template so that "quick and dirty"
is just "quick".

A problem with ALL programming languages is that you don't know how a library
is going to look ahead of time.  You struggle to find the right names, and
the right structure.  This allows you to just create functionality without
worrying about that stuff.

This is future-proof.  When you've finally gotten a good idea of how things
could be organized, you can pick off functionality and put them into more
"official" libraries.  You lose nothing.  You gain mobility.

# Features

All scripts can be symbolically linked to wherever.  They're capable of finding
the libraries they use.

# Rules / Guidelines

## Avoiding Conflicts and Breakage

If you use globally unique library names you don't have to worry about conflicts.

If, when unsure if an update is going to break backward compatibility with
another bit of software that uses these libraries, you can
simply copy the library and name it HelloRepoLayout2 (for example) .  It is always good to
retroactively examine what other source files are using the old version and
see if you can easily get them to use the new version.

## Semantic Versioning and Tags
If you use Semantic Versioning, then, for example, you can use a tagging scheme like this:

* 1.2.3-4

Where

* 1.2.3 is Major.Minor.Patch for things under src dir. (Functionality)
* 4 is the release number, when things outside of src have changed. (Deployment,
documentation, etc).


