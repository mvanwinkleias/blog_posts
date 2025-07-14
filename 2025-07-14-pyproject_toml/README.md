# THis isn't fully baked yet

# pyproject.toml

I do some things differently with repository layouts, and it's (kind of)
nice to see Python catching up.

Back in the day if you looked up how to make a pip, they'd have everything
in the same directory, a la:

```
.
├── my_package
│   ├── __init__.py
│   └── module.py
└── setup.py
```

Now they call it "ad-hoc" layout.  I guess having all of that stuff top-level
is not a fantastic idea.

An alternative is something they call the src layout, which is definitely
better organized:
```
.
├── pyproject.toml
└── src
    └── my_package
        ├── __init__.py
        └── module.py
```

That's "better".  But you run into other funny things, such as
if you want to use setup tools to find namespace packages, you
end up needing to exclude whatever stuff you put in the src
directory

( * https://setuptools.pypa.io/en/latest/userguide/package_discovery.html)

So, I've always taken my layouts "one step further" and done this:

```
.
├── pyproject.toml
└── src
    └── lib
        └── python3
            └── my_package
                ├── __init__.py
                └── module.py
```

Now, if I use  ```[tool.setuptools.packages.find]``` on src/lib/python3 , and it
pulls something from there that shouldn't be there... well, that's my own fault.

i.e. by using these things called "directories", and by organizing things under them
I don't need to tell setup tools to exclude anything.

I can expand my project if I want:
```
.
├── pyproject.toml
└── src
    ├── bin
    │   └── my_wrapper.py
    └── lib
        └── python3
            └── my_package
                ├── __init__.py
                └── module.py
```

## Anyway

Under this directory you'll find something you can build with a simple
```
python3 -m build
```

It has a couple of examples to call / include your code

* run_wrapper.sh - should be able to call the module just fine
* src/bin/ias-network-sample-app-wrapper.py - does some library path manipulations
to make the code in src/lib/python3 callable .

project.toml shows how you'd use "project.scripts" (which directly calls the library's main
subroutine).  It also shows how you'd install the script in src/bin .

## project.toml Disappointments

You can use a glob for license files:
```toml
[project]
license-files = ["LICEN[CS]E*", "vendored/licenses/*.txt", "AUTHORS.md"]
```
* https://packaging.python.org/en/latest/guides/writing-pyproject-toml/

but you can't for script files?!  LOL.


